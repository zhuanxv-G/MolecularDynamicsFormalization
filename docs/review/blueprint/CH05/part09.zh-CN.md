[上一部分](part08.zh-CN.md) / [目录](../../CH05_BLUEPRINT.zh-CN.md) / [下一部分](part10.zh-CN.md)

## 1. MD-5.4.1-AnisotropicInitialCurve · definition · 印刷p.201 / PDFp.222

### 2. 原文陈述

> Fix, arbitrarily, a small set of initial conditions for the anisotropic pendulum at energy $`E_0`$, with positions in a small interval on the positive $`x`$ axis, $`1.05\le x\le1.15`$ and $`y=0`$. For each point $`(x,0)`$ taken from this set select the initial velocities as $`\dot x=0`$, $`\dot y=[2(E_0-U(x,0))]^{1/2}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def anisotropicInitialCurve (κ l ε c x : ℝ) : MolecularDynamics.Chapter05Review.Phase 2 :=
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![0,Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))])
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.anisotropicInitialCurve` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件 Blueprint/Ch05.lean:1161–1162 中 anisotropicPotential κ₀ l₀ ε q=Chapter01Review.anisotropicEnergy κ₀ l₀ ε (q 0) (q 1) 0 0；依赖摘录 MolecularDynamics/Chapter01/ReviewDefinitions.lean:12008–12019 展开后，r=√(x²+y²)、c₃=4(x/r)³−3x/r、κ\_eff=κ₀(1−εc₃/2)、l\_eff=l₀(1+εc₃/2)，U=κ\_eff(r−l\_eff)²/2。展开目标附件:1205–1206 的 anisotropicInitialCurve 得 γ(x)=((x,0),(0,√(2(c−U(x,0)))))，WithLp.toLp 2 仅将指定坐标放入标准欧氏空间；c 对应 E₀，单位质量下动量等于速度。此项是参数化公式定义，原区间[1.05,1.15]已在 context\_notation 明示，集合使用时应限制到该区间，映射本身在整个实线上定义并不改变受限初值集。Real.sqrt 在负参数上取0的总定义按标准语义理解：本 def 自身没有断言所有参数下能量恒等式成立，实初值能量资格由下一条明确约束。因此不将缺少定义体或总定义延拓误判为缺失对象或数学错误。extra\_assumptions 为空，def 无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch05.anisotropicInitialCurve`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1794)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-AnisotropicInitialEnergy · unnumbered_claim · 印刷p.201 / PDFp.222

### 2. 原文陈述

> For each point $`(x,0)`$ taken from this set select the initial velocities as $`\dot x=0`$, $`\dot y=[2(E_0-U(x,0))]^{1/2}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem anisotropicInitialEnergy : ∀ κ l ε c x : ℝ,
  0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]) →
  let z := anisotropicInitialCurve κ l ε c x
  ((z.2 0)^2+(z.2 1)^2)/2+anisotropicPotential κ l ε z.1=c := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.anisotropicInitialEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]根号内非负且单位质量；实际初值能量等式，不从构造宣称轨道遍历整个能量面。 | [EXTRA] |

[EXTRA] [EXTRA]根号内非负且单位质量；实际初值能量等式，不从构造宣称轨道遍历整个能量面。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件 Blueprint/Ch05.lean:1161–1162 中 anisotropicPotential κ₀ l₀ ε q=Chapter01Review.anisotropicEnergy κ₀ l₀ ε (q 0) (q 1) 0 0；依赖摘录 MolecularDynamics/Chapter01/ReviewDefinitions.lean:12008–12019 展开后，r=√(x²+y²)、c₃=4(x/r)³−3x/r、κ\_eff=κ₀(1−εc₃/2)、l\_eff=l₀(1+εc₃/2)，U=κ\_eff(r−l\_eff)²/2。目标附件:1205–1206 的初值定义展开为 q=(x,0)、p=(0,√(2(c−U(q))))。本声明量化所有实 κ₀,l₀,ε,c,x，在唯一前提 c−U(q)≥0 下推出 |p|²/2+U(q)=c；前提正好保证实平方根的平方等于根号内量。[EXTRA]非负根号资格必要且合理，单位质量已体现于动能系数1/2；参数正性和短区间约束不是这个代数能量恒等式所必需，省去它们是有效的一般化。本项没有声称轨道覆盖或遍历整个能量面，也未将能量结论作为前提。PASS 只批准签名语义，theorem 主体仍为 sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch05.anisotropicInitialEnergy`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1799)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-InitialSegmentPrinted · unnumbered_claim · 印刷p.201 / PDFp.222

### 2. 原文陈述

> The set of initial conditions forms a line segment in the four-dimensional phase space.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem initialSegmentPrinted : ∀ κ l ε c : ℝ,
  (∀ x ∈ Icc (105/100 : ℝ) (115/100),0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])) →
  ∃ a b : MolecularDynamics.Chapter05Review.Phase 2,anisotropicInitialCurve κ l ε c '' Icc (105/100 : ℝ) (115/100)=segment ℝ a b := by
  sorry



/-- 修正版，对应原文 MD-5.4.1-InitialSegmentPrinted。改动：四维相空间初值集只定义为参数曲线像，不再宣称一般为仿射线段；位置投影直线与动量根号依赖分别解释。 -/
```

独立修正版：

```lean
def initialSegmentPrinted_corrected (κ l ε c : ℝ) : Set (MolecularDynamics.Chapter05Review.Phase 2) :=
  anisotropicInitialCurve κ l ε c '' Icc (105/100 : ℝ) (115/100)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.initialSegmentPrinted`；`MD.Ch05.initialSegmentPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]保留真实相空间对象、书中区间及实初值的非负根号资格；不把线段结论作假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 四维相空间初值集只定义为参数曲线像，不再宣称一般为仿射线段；位置投影直线与动量根号依赖分别解释。 | [EXTRA] |

[EXTRA] [EXTRA]保留真实相空间对象、书中区间及实初值的非负根号资格；不把线段结论作假设。；[ERRATUM?] 四维相空间初值集只定义为参数曲线像，不再宣称一般为仿射线段；位置投影直线与动量根号依赖分别解释。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依补充规则重审：Lean 4.34.0 / Mathlib v4.34.0 的 EuclideanSpace、WithLp.toLp、HasDerivAt、gradient、ContDiff、deriv、Set.image、Icc 和 segment 等按标准数学含义采信，不要求其定义体出现在项目依赖摘录。仅展开项目自定义对象。Ch05\_deps.txt 的 MolecularDynamics/Chapter05/ReviewDefinitions.lean:5315–5316 中 E n=EuclideanSpace ℝ (Fin n)、Phase n=E n×E n，分别是欧氏 ℝⁿ 与位置/动量积空间。目标附件 Blueprint/Ch05.lean:1161–1162 中 anisotropicPotential κ₀ l₀ ε q=Chapter01Review.anisotropicEnergy κ₀ l₀ ε (q 0) (q 1) 0 0；依赖摘录 MolecularDynamics/Chapter01/ReviewDefinitions.lean:12008–12019 展开后，r=√(x²+y²)、c₃=4(x/r)³−3x/r、κ\_eff=κ₀(1−εc₃/2)、l\_eff=l₀(1+εc₃/2)，U=κ\_eff(r−l\_eff)²/2。目标附件:1205–1206 的实际初值是 γ(x)=((x,0),(0,√(2(c−U(x,0)))))；1218–1220 量化任意实 κ₀,l₀,ε,c，假定闭区间 I=[21/20,23/20] 上 c−U≥0，结论存在 a,b∈Phase 2 使 γ(I)=segment ℝ a b。标准 Mathlib segment ℝ a b 是 {(1−s)a+s b | 0≤s≤1} 的仿射闭线段，不能理解成任意拓扑弧或参数曲线。[EXTRA]保留真实相空间对象、区间与非负根号资格正确且无循环，但不能使平方根动量关于 x 为仿射函数。该签名忠实复现原书 line segment 的字面措辞，同时把原书疑误写成了假的数学定理，应 FAIL；问题与 Mathlib 定义体是否提供无关。没有显式 [ERRATUM?] 标签可据此默认接受错误，疑误及修复必须明示。声明体为 sorry，独立记录。

### 7. 状态与证明位置

incomplete；`MD.Ch05.initialSegmentPrinted`：未证（原书疑误不证）；`MD.Ch05.initialSegmentPrinted_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1808)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-CircleInitialPoints · definition · 印刷p.202 / PDFp.223

### 2. 原文陈述

> Now consider an alternative initial set. Begin, as before, with a line segment on the $`x`$-axis, but now choose the initial momenta from the uniform distribution on the circle $`p_x^2+p_y^2=2(E_0-U(x,0))`$. In this way we again get initial conditions on the $`H=E_0`$ energy surface, but this time the points are not close to one another in phase space, since the momenta of successive points may differ greatly.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def circleInitialPoints (κ l ε c x θ : ℝ)
    (_hfeas : 0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]))
    (_hx : x ∈ Icc (105/100 : ℝ) (115/100)) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])

def circleInitialPoints_total (κ l ε c x θ : ℝ) : MolecularDynamics.Chapter05Review.Phase 2 :=
  let R := Real.sqrt (2*(c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0])))
  (WithLp.toLp 2 ![x,0],WithLp.toLp 2 ![R*Real.cos θ,R*Real.sin θ])
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.circleInitialPoints`；`MD.Ch05.circleInitialPoints_total` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 将实际初值域限定可行能量及原x区间；θ为后条均匀角分布的取样变量，定性样本图像不强化为全样本必然分离。零半径为允许退化；总延拓仅作独立辅助定义。 | [EXTRA] |

[EXTRA] [EXTRA] 将实际初值域限定可行能量及原x区间；θ为后条均匀角分布的取样变量，定性样本图像不强化为全样本必然分离。零半径为允许退化；总延拓仅作独立辅助定义。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；已核对circleInitialPoints及circleInitialPoints\_total。Phase 2确为E 2×E 2，位置为(x,0)，动量为(R cos θ,R sin θ)，R=√(2(c−U(x,0)))。实际接口显式要求c−U(x,0)≥0及x∈[1.05,1.15]，与可行能量及“as before”的原位置区间相符；κ,l,ε,c,x,θ均为实参数，θ没有在本定义中被伪称随机变量的概率律。U实际调用给出的anisotropicPotential→anisotropicEnergy，零速度消去了动能；角向参数是4 cos³α−3 cosα，对应给出的各向异性参数定义，没有换成双弹簧势。total接口明确是无前提的辅助总延拓，负能差时不能称为能量c上的初值。均匀性在条目11另作测度定义，能量等式在条目12另作结论；[EXTRA]没有将样本可能相距很远强化为所有θ、所有样本都分离。

### 7. 状态与证明位置

self-contained；`MD.Ch05.circleInitialPoints`：定义；`MD.Ch05.circleInitialPoints_total`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1821)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-CircleInitialLaw · definition · 印刷p.202 / PDFp.223

### 2. 原文陈述

> choose the initial momenta from the uniform distribution on the circle $`p_x^2+p_y^2=2(E_0-U(x,0))`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def circleInitialLaw (κ l ε c x : ℝ)
    (hfeas : 0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]))
    (hx : x ∈ Icc (105/100 : ℝ) (115/100)) : Measure (MolecularDynamics.Chapter05Review.Phase 2) :=
  Measure.map (fun θ ↦ circleInitialPoints κ l ε c x θ hfeas hx)
    ((ENNReal.ofReal (2*Real.pi))⁻¹ • (volume.restrict (Ioc (0 : ℝ) (2*Real.pi))))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.circleInitialLaw` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定x的真实均匀角测度及角参数化推送；不把任意集合叫uniform，不添加跨x独立性假设；概率总质量尚未逐条证明。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 均匀圆概率主接口限定可行能量和原x区间，使用归一化角测度推前；c=U为退化Dirac，不默认负能差的sqrt总化初值。 | [EXTRA] |

[EXTRA] [EXTRA]固定x的真实均匀角测度及角参数化推送；不把任意集合叫uniform，不添加跨x独立性假设；概率总质量尚未逐条证明。；[EXTRA] 均匀圆概率主接口限定可行能量和原x区间，使用归一化角测度推前；c=U为退化Dirac，不默认负能差的sqrt总化初值。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；circleInitialLaw对固定κ,l,ε,c,x及其可行性、区间资格，定义Phase 2上的真实Measure.map。原测度是(2π)⁻¹倍的Lebesgue测度在(0,2π]上的限制；π>0，区间长度为2π，归一化系数和端点选择正确。推前映射恰是条目10的实际可行接口，关于θ连续，因此推前确有概率总质量1；没有把“尚未证明概率实例”误作公式错误。当R>0，这给出固定位置下对动量圆的均匀角/归一化弧长概率分布；R=0时退化为该固定相点的Dirac概率。原文没有指定跨x的联合抽样规律，本定义也没有擅加x均匀性或不同x之间的独立性。

### 7. 状态与证明位置

self-contained；`MD.Ch05.circleInitialLaw`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1834)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.4.1-CircleInitialEnergy · unnumbered_claim · 印刷p.202 / PDFp.223

### 2. 原文陈述

> In this way we again get initial conditions on the $`H=E_0`$ energy surface,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem circleInitialEnergy : ∀ κ l ε c x θ : ℝ,
  0 ≤ c-anisotropicPotential κ l ε (WithLp.toLp 2 ![x,0]) →
  let z := circleInitialPoints_total κ l ε c x θ
  ((z.2 0)^2+(z.2 1)^2)/2+anisotropicPotential κ l ε z.1=c := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.circleInitialEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定位置的实动量圆，根号非负；全能量等式不意味着极限图像填满可达区域。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 原能量恒等式保留为正式库总延拓的辅助证明；本条适用前提仍是非负能差，实际取样主接口由CircleInitialPoints/Law限定区间及可行域。 | [EXTRA] |

[EXTRA] [EXTRA]固定位置的实动量圆，根号非负；全能量等式不意味着极限图像填满可达区域。；[EXTRA] 原能量恒等式保留为正式库总延拓的辅助证明；本条适用前提仍是非负能差，实际取样主接口由CircleInitialPoints/Law限定区间及可行域。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；circleInitialEnergy对所有κ,l,ε,c,x,θ∈ℝ，仅要求c−U(x,0)≥0，在circleInitialPoints\_total上断言两动量平方和的一半加同一势能等于c。cos²θ+sin²θ=1及非负根号平方给出该恒等式，动能系数与圆半径的因子2相抵；R=0同样成立。本条作为辅助总定义的结论不限制x区间是正确的推广，实际书中抽样接口的区间限制在条目10、11，且两种点定义在其共同可行域的表达式相同。没有偷换势能，未把能量等式本身作前提。

### 7. 状态与证明位置

incomplete；`MD.Ch05.circleInitialEnergy`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1843)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-Correlation · definition · 印刷p.203–204 / PDFp.224–225

### 2. 原文陈述

> Let $`a`$ and $`b`$ be mappings from the phase space to the same Euclidean space, and define the temporal correlation of $`a`$ and $`b`$ (on the surface of energy $`E`$) by

$$
C_{ab}(\tau)\stackrel{\rm def}{=}k\operatorname{Av}_{H=E}(a(\mathcal F_t(z))\cdot b(z)) =kZ_E^{-1}\int_{\Sigma_E}a(\mathcal F_t(z))\cdot b(z)\delta[H-E]d\omega;
$$


> where $`k`$ is a normalization constant that is often incorporated to ensure that $`C_{ab}(0)=1`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def correlation {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)



/-- 修正版，对应原文 MD-5.5-Correlation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def correlation_corrected {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (k t : ℝ) := k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.correlation`；`MD.Ch05.correlation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；correlation对任意状态维n、共同输出维d，接受μ、Φ及a,b:E n→E d和实k,t，返回k乘以真实实欧氏内积的μ积分；只在a上施加Φ\_t，b取初始状态，次序与源文相符。这里定义的是通用测度下的相关核，取μ为已归一化微正则概率测度时才对应原Av_(H=E)；不能据此声称对任意μ都等于原δ积分，也未在此定义或证明微正则测度构造。积分定义可以总延拓至任意观测量；作通常统计相关解释时仍须有相关乘积的可积性。k任意是正确的，“often”并未要求无条件C(0)=1；零lag积分非零时才能取其倒数归一化。Lean统一用一个lag参数t，是对源文τ/t混用的已公开合理修订。

### 7. 状态与证明位置

self-contained；`MD.Ch05.correlation`：定义；`MD.Ch05.correlation_corrected`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1851)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-CorrelationPullback · unnumbered_claim · 印刷p.204 / PDFp.225

### 2. 原文陈述

> Using the notation developed earlier for the propagator, this has the alternative formulation

$$
C_{ab}(t)=k\operatorname{Av}_{H=E}\left[b(z)\cdot(e^{t\mathcal L}a)(z)\right].
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem correlationPullback {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t :
    MolecularDynamics.Chapter05Review.correlation μ Φ a b k t=k*(∫ z,inner ℝ (a (Φ t z)) (b z) ∂μ) := by
  apply MolecularDynamics.Chapter05Review.correlationPullback_proved <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.correlationPullback` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则采信Lean 4.34.0 / Mathlib v4.34.0标准含义：欧氏空间、实内积、Bochner积分、指标、测度推前/限制/加权、AE及Tendsto均不要求在项目依赖中提供定义体；以下只展开项目自定义。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 E n := EuclideanSpace ℝ (Fin n)；average μ g := ∫z,g z ∂μ；correlation μ Φ a b k t := k*(∫z,inner ℝ (a(Φ t z))(b z) ∂μ)。项目pullback Φ g t z := g(Φ t z)，solutionOperator Φ t g := pullback Φ g t。两者在定义中为实标量观测；向量观测的逐坐标传播就是a(Φt z)。主声明对任意n,d,μ,Φ,a,b,k,t断言correlation等于其展开积分，保留k及全部配对项；欧氏实内积对称，故与原b(z)·(e^{tL}a)(z)相同。没有凭函数名字假定它是微分算子的指数：这里使用原flow拉回的传播含义，实际展开体已核对。无额外假设或新增勘误。Ch05\_deps.txt的ReviewProofs.lean中correlationPullback\_proved为rfl，主声明调用它；本条无sorry。无编译验证声明。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch05.correlationPullback`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1861)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-CorrelationTimePrinted · unnumbered_claim · 印刷p.204 / PDFp.225

### 2. 原文陈述

> If the system is ergodic, we could write this as a temporal average with respect to any trajectory initiated on the $`H=E`$ energy surface:

$$
C_{a,b}(t)=k\lim_{\tau\to\infty}\frac1\tau\int_0^{\tau} a(z(s+t))\cdot b(z(s))ds.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem correlationTimePrinted : ∀ n d (H : MolecularDynamics.Chapter05Review.E n → ℝ) c Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  MolecularDynamics.Chapter05Review.microErgodic H c Φ → Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) (MolecularDynamics.Chapter05Review.microMeasure H c) →
  ∀ z ∈ MolecularDynamics.Chapter05Review.energySurface H c,Tendsto
    (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation (MolecularDynamics.Chapter05Review.microMeasure H c) Φ a b k t)) := by
  sorry



/-- 修正版，对应原文 MD-5.5-CorrelationTimePrinted。改动：any初值改为微正则几乎处处初值，并补正则概率能级资格；一般可积相关观测量的Birkhoff桥接尚未证明。 -/
```

独立修正版：

```lean
theorem correlationTimePrinted_corrected : ∀ n d (H : MolecularDynamics.Chapter05Review.E n → ℝ) c Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  MolecularDynamics.Chapter05Review.regularEnergy H c →
  MolecularDynamics.Chapter05Review.microErgodic H c Φ → Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) (MolecularDynamics.Chapter05Review.microMeasure H c) →
  ∀ᵐ z ∂MolecularDynamics.Chapter05Review.microMeasure H c,Tendsto
    (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation (MolecularDynamics.Chapter05Review.microMeasure H c) Φ a b k t)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch05.correlationTimePrinted`；`MD.Ch05.correlationTimePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]真实能量面/微正则测度、标准遍历先验及给定lag相关可积资格；原字面全能量初值只作为待裁定义务，不能当本地PASS。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] any初值改为微正则几乎处处初值，并补正则概率能级资格；一般可积相关观测量的Birkhoff桥接尚未证明。 | [EXTRA] |

[EXTRA] [EXTRA]真实能量面/微正则测度、标准遍历先验及给定lag相关可积资格；原字面全能量初值只作为待裁定义务，不能当本地PASS。；[ERRATUM?] any初值改为微正则几乎处处初值，并补正则概率能级资格；一般可积相关观测量的Birkhoff桥接尚未证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；本轮按补充规则采信Lean 4.34.0 / Mathlib v4.34.0标准含义：欧氏空间、实内积、Bochner积分、指标、测度推前/限制/加权、AE及Tendsto均不要求在项目依赖中提供定义体；以下只展开项目自定义。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 E n := EuclideanSpace ℝ (Fin n)；average μ g := ∫z,g z ∂μ；correlation μ Φ a b k t := k*(∫z,inner ℝ (a(Φ t z))(b z) ∂μ)。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 energySurface H c := {z | H z=c}；grad H := gradient H；hausdorffArea m := ofReal(volume(单位ℝ^m球).toReal/2^m) • hausdorffMeasure m；surfaceMeasure H c := (hausdorffArea (n-1)).restrict(energySurface H c)；microRaw H c := (surfaceMeasure H c).withDensity(fun z => ofReal(‖grad H z‖⁻¹))；microMeasure H c := ((microRaw H c) univ)⁻¹ • microRaw H c；microAverage H c g := average(microMeasure H c)g。timeAverage z g T := T⁻¹*(∫s in 0..T,g(z s))；hasTimeAverage z g a := Tendsto(timeAverage z g) atTop (𝓝 a)；microErgodic H c Φ := ∀g, Integrable g (microMeasure H c) → ∀ᵐz∂microMeasure H c, hasTimeAverage(fun s=>Φs z)g(microAverage H c g)。签名依次全称量化n,d,H,c,Φ,a,b,k,t，假设Φ0=id、flow加法群律、microErgodic及给定lag观测的可积性，结论为所有z∈{H=c}的相关时间积分极限。原文any trajectory确实对应这个全点结论；但本项目microErgodic只提供对每个可积观测的AE性质，不能推出全能量面点性质。[EXTRA]给定lag可积和群律合理，却不足以支持原any；没有正有限微正则质量、正则能量资格或全点平均假设。原文any在通常测度遍历含义下应公开作AE勘误，不能由名字ergodic获得全点结论。下面给出当前签名的直接反例，不因未给Mathlib定义而待裁定。主声明有sorry，但签名失败独立于证明完成度。

### 7. 状态与证明位置

incomplete；`MD.Ch05.correlationTimePrinted`：未证（原书疑误不证）；`MD.Ch05.correlationTimePrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1868)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-CorrelationTimeAE · unnumbered_claim · 印刷p.204 / PDFp.225

### 2. 原文陈述

> If the system is ergodic, we could write this as a temporal average with respect to any trajectory initiated on the $`H=E`$ energy surface:

$$
C_{a,b}(t)=k\lim_{\tau\to\infty}\frac1\tau\int_0^{\tau} a(z(s+t))\cdot b(z(s))ds.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem correlationTime :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  (∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable g μ → ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun s => Φ s z) g (MolecularDynamics.Chapter05Review.average μ g)) →
  Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) μ →
  ∀ᵐ z ∂μ,Tendsto (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation μ Φ a b k t)) := by
  intro n d μ Φ a b k t h0 hg he hi
  filter_upwards [he (fun z => inner ℝ (a (Φ t z)) (b z)) hi] with z hz
  unfold MolecularDynamics.Chapter05Review.hasTimeAverage MolecularDynamics.Chapter05Review.timeAverage at hz
  have hh := hz.const_mul k
  have ht (s : ℝ) : Φ (s+t) z=Φ t (Φ s z) := by rw [add_comm,hg]
  simpa only [MolecularDynamics.Chapter05Review.average,MolecularDynamics.Chapter05Review.correlation,ht,mul_assoc] using hh



/-- 修正版，对应原文 MD-5.5-CorrelationTimeAE。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem correlationTime_corrected :
  ∀ n d (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ
    (a b : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) k t,
  (∀ z,Φ 0 z=z) → (∀ s u z,Φ (s+u) z=Φ s (Φ u z)) →
  (∀ g : MolecularDynamics.Chapter05Review.E n → ℝ,Integrable g μ → ∀ᵐ z ∂μ, MolecularDynamics.Chapter05Review.hasTimeAverage (fun s => Φ s z) g (MolecularDynamics.Chapter05Review.average μ g)) →
  Integrable (fun z => inner ℝ (a (Φ t z)) (b z)) μ →
  ∀ᵐ z ∂μ,Tendsto (fun T => k*T⁻¹*(∫ s in (0 : ℝ)..T,inner ℝ (a (Φ (s+t) z)) (b (Φ s z))))
    atTop (𝓝 (MolecularDynamics.Chapter05Review.correlation μ Φ a b k t)) := by
  intro n d μ Φ a b k t h0 hg he hi
  filter_upwards [he (fun z => inner ℝ (a (Φ t z)) (b z)) hi] with z hz
  unfold MolecularDynamics.Chapter05Review.hasTimeAverage MolecularDynamics.Chapter05Review.timeAverage at hz
  have hh := hz.const_mul k
  have ht (s : ℝ) : Φ (s+t) z=Φ t (Φ s z) := by rw [add_comm,hg]
  simpa only [MolecularDynamics.Chapter05Review.average,MolecularDynamics.Chapter05Review.correlation,ht,mul_assoc] using hh
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.correlationTime`；`MD.Ch05.correlationTime_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]按本章标准遍历结论修正为对给定lag逐次AE初值；保留真实时间积分、向量内积、可积性和flow群律，原any字面另条。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]按本章标准遍历结论修正为对给定lag逐次AE初值；保留真实时间积分、向量内积、可积性和flow群律，原any字面另条。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；correlationTime已逐项核对全部n,d,μ,Φ,a,b,k,t量词、零时恒等及群律。遍历资格在此作为“每个L¹实观测量有各自AE时间平均”的标准性质传入，并要求给定lag的相关观测量可积；在条目1的概率保测可测流条件下，这个资格可由setErgodic取得，未把特定相关等式直接作为假设。结论对给定t几乎处处z，保留k、T⁻¹、真实0到T积分以及a(Φ_(s+t)z)与b(Φ\_s z)的实内积。群律和实数加法交换保证该 integrand 是固定观测量g\_t沿Φ\_s的值，极限目标是同一μ、Φ、a、b、k、t的correlation。没有交换∀t与AE z；也没有从一般遍历性推出每个初值。因此AE修订版完整签名PASS，原书any trajectory仍独立标为待人工。

### 7. 状态与证明位置

self-contained；`MD.Ch05.correlationTime`：已证；`MD.Ch05.correlationTime_corrected`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1897)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-VelocityCorrelation · definition · 印刷p.204 / PDFp.225

### 2. 原文陈述

> The velocity autocorrelation function is often written in the shorthand notation

$$
C_{v,v}(t)\stackrel{\rm def}{=}\frac{\langle v(t)\cdot v(0)\rangle}{\langle v(0)\cdot v(0)\rangle},
$$


> where the averaging may be assumed to be against the microcanonical measure, if otherwise unspecified.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def velocityCorrelation {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (v : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (t : ℝ) := MolecularDynamics.Chapter05Review.correlation μ Φ v v 1 t/MolecularDynamics.Chapter05Review.correlation μ Φ v v 1 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.velocityCorrelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则采信Lean 4.34.0 / Mathlib v4.34.0标准含义：欧氏空间、实内积、Bochner积分、指标、测度推前/限制/加权、AE及Tendsto均不要求在项目依赖中提供定义体；以下只展开项目自定义。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 E n := EuclideanSpace ℝ (Fin n)；average μ g := ∫z,g z ∂μ；correlation μ Φ a b k t := k*(∫z,inner ℝ (a(Φ t z))(b z) ∂μ)。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 velocityCorrelation μ Φ v t := correlation μ Φ v v 1 t / correlation μ Φ v v 1 0；MD.Ch05中的定义调用同一项目correlation。展开为∫inner(v(Φt z))(v z)∂μ除以∫inner(v(Φ0 z))(v z)∂μ。在原轨迹/flow上下文Φ0=id时分母正是〈v(0)·v(0)〉，输出空间ℝ^d及真实dot均保留。μ参数允许原otherwise unspecified的微正则选择及其他指定测度。此定义不声称任意Φ为flow，不自动证明分母非零或可积；context已明确除零总化没有归一化意义，合法使用时须非零零lag平均。无[EXTRA]/[ERRATUM?]假设；定义无sorry。标准Bochner积分/除法定义不造成NEEDS\_HUMAN。

### 7. 状态与证明位置

self-contained；`MD.Ch05.velocityCorrelation`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1931)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-PositionTransition · definition · 印刷p.204 / PDFp.225

### 2. 原文陈述

> Now let $`A`$ and $`B`$ be subsets of configuration space (i.e. subsets in the position space) of nonzero measure, and define $`T_{AB}(\tau)\stackrel{\rm def}{=}C_{1_B,1_A}(\tau)`$,

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def positionTransition {n d : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (π : MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E d) (A B : Set (MolecularDynamics.Chapter05Review.E d)) (k t : ℝ) :=
  k*
  (∫ z,((B.indicator (fun _ => (1 : ℝ))) (π (Φ t z)))*
    ((A.indicator (fun _ => (1 : ℝ))) (π z)) ∂μ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.positionTransition` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 恢复相关定义中完整归一化常数k，原k=1未归一化概率计数作为明确实例；位置投影及两个indicator积分均保留。 | [EXTRA] |

[EXTRA] [EXTRA] 恢复相关定义中完整归一化常数k，原k=1未归一化概率计数作为明确实例；位置投影及两个indicator积分均保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；positionTransition接受同一μ、Φ、实k和t，位置映射π:E n→E d，以及配置集合A、B。被积函数是1\_B(π(Φ\_t z))·1\_A(π z)，并在积分外完整保留k，正对应C_(1\_B,1\_A)的顺序；没有交换始发集合A和目标集合B。π作为参数是通用观测映射，实际原文用法须选为位置投影；原非零测度和可测性要求在一般定义中可以放宽，因为本条没有做除法或断言条件概率。若作概率解释则还须相应概率测度、可测集/映射；特别应取k=1，再除以起始事件的正概率。当前定义本身不是首次到达分布，也不保证对任意k其值都在[0,1]。

### 7. 状态与证明位置

self-contained；`MD.Ch05.positionTransition`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1936)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-TransitionProbability · definition · 印刷p.204 / PDFp.225

### 2. 原文陈述

> Dividing $`T_{AB}`$ by the measure of the set $`A`$, we obtain the probability for a trajectory to make this transition in the given time, which we may write as

$$
\operatorname{Pr}_\tau(A\to B)=\frac{\langle1_B(z(\tau))1_A(z(0))\rangle}{\langle1_A(z(0))\rangle},
$$


> where the averaging is assumed to be with respect to the microcanonical distribution at given energy $`E`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def transitionProbability {n : ℕ} (μ : Measure (MolecularDynamics.Chapter05Review.E n)) (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (A B : Set (MolecularDynamics.Chapter05Review.E n)) (t : ℝ) :=
  (μ (A ∩ (Φ t) ⁻¹' B)).toReal/(μ A).toReal
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.transitionProbability` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]定义中A/B为位置集合的相空间逆像；完整位置投影平均已另条。µ(A)>0使用资格，非首次到达事件。 | [EXTRA] |

[EXTRA] [EXTRA]定义中A/B为位置集合的相空间逆像；完整位置投影平均已另条。µ(A)>0使用资格，非首次到达事件。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 e9c5ec7b563a4f805045e28ca5d392e588e21ad2d6101d581a241cfea2275286）。
网站原返回（对应其审校版本）：PASS；本轮按补充规则采信Lean 4.34.0 / Mathlib v4.34.0标准含义：欧氏空间、实内积、Bochner积分、指标、测度推前/限制/加权、AE及Tendsto均不要求在项目依赖中提供定义体；以下只展开项目自定义。项目依赖定位：Ch05\_deps.txt，-- FILE: MolecularDynamics/Chapter05/ReviewDefinitions.lean。 transitionProbability μ Φ A B t := (μ(A ∩ (Φt)⁻¹' B)).toReal/(μA).toReal。量化n及指定μ、Φ、相空间集合A/B和时刻t，事件是初始在A且终时在B，没有交换方向或替换为首次到达。按[EXTRA]，A/B解释为配置集合在实际位置投影下的逆像；这与上一条位置配置对象兼容。对微正则概率μ、可测/μ零可测的事件、可测flow及0<μA，指标乘积是A∩(Φt)⁻¹B的指标，故Bochner积分比值就是该测度比值；Φ0=id对应原初始轨迹记号。定义泛化到其他μ/集合不声称这些输入均有原条件概率解释；零分母及无限测度toReal的总化不是概率性结论。在原有限概率、正分母域内，所有分子分母子句完整，[EXTRA]逆像解释必要且合理。上一条T\_AB的k歧义不影响这里直接写出的无k比值公式。定义无sorry；未要求项目附件重给Mathlib指标积分定义。

### 7. 状态与证明位置

self-contained；`MD.Ch05.transitionProbability`：定义。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1944)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-MeasureDuality · (5.10) · 印刷p.205 / PDFp.226

### 2. 原文陈述


$$
\int_{\Sigma_E}\phi(z)\rho(z;t)d\omega =\int_{\Sigma_E}\phi(z)e^{t\mathcal L^\dagger}\rho(z,0)d\omega =\int_{\Sigma_E}[e^{t\mathcal L}\phi(z)]\rho(z,0)d\omega =\int_{\Sigma_E}\phi(\mathcal F_t(z))\rho(z,0)d\omega =\int_{\Sigma_E}\phi(\mathcal F_t(z))\frac{\rho(z,0)}{\rho_E(z)}\rho_E(z)d\omega.\tag{5.10}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem measureDuality :
  ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (φ : MolecularDynamics.Chapter05Review.E n → ℝ) t,
  Measurable (Φ t) → Integrable φ (MolecularDynamics.Chapter05Review.measurePropagator Φ t μ) →
    MolecularDynamics.Chapter05Review.average (MolecularDynamics.Chapter05Review.measurePropagator Φ t μ) φ=MolecularDynamics.Chapter05Review.average μ (MolecularDynamics.Chapter05Review.pullback Φ φ t) := by
  intro n μ Φ φ t hm hi
  exact integral_map hm.aemeasurable hi.aestronglyMeasurable

theorem measureDuality_RN (n : ℕ)
    (ν : Measure (MolecularDynamics.Chapter05Review.E n)) (_hν : IsProbabilityMeasure ν)
    (r : MolecularDynamics.Chapter05Review.E n → ℝ) (_hr : Integrable r ν)
    (_hrpos : ∀ z,0 ≤ r z) (_hrmass : (∫ z,r z ∂ν)=1)
    (Φ : ℝ → MolecularDynamics.Chapter05Review.E n → MolecularDynamics.Chapter05Review.E n)
    (t : ℝ) (_hΦ : Measurable (Φ t))
    (φ : MolecularDynamics.Chapter05Review.E n → ℝ) (_hc : Continuous φ)
    (_hb : Bornology.IsBounded (range φ)) :
    let μ₀ := ν.withDensity (fun z ↦ ENNReal.ofReal (r z))
    MolecularDynamics.Chapter05Review.average (Measure.map (Φ t) μ₀) φ=
      MolecularDynamics.Chapter05Review.average μ₀ (MolecularDynamics.Chapter05Review.pullback Φ φ t) ∧
    MolecularDynamics.Chapter05Review.average μ₀ (MolecularDynamics.Chapter05Review.pullback Φ φ t)=
      ∫ z,φ (Φ t z)*r z ∂ν := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.measureDuality`；`MD.Ch05.measureDuality_RN` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]演化密度用真实Measure.map，微正则ρE的比值应理解为对参考奇异测度的Radon–Nikodym密度；不当普通Lebesgue密度相除。明确可测及map下可积，不将最终等式作前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留推前对偶已有证明，补参考概率ν上的非负RN密度r、初始withDensity、演化Measure.map与全部加权配对链；公开ρ/ρ\_E的RN解释，不对奇异δ作函数相除。 | [EXTRA] |

[EXTRA] [EXTRA]演化密度用真实Measure.map，微正则ρE的比值应理解为对参考奇异测度的Radon–Nikodym密度；不当普通Lebesgue密度相除。明确可测及map下可积，不将最终等式作前提。；[EXTRA] 保留推前对偶已有证明，补参考概率ν上的非负RN密度r、初始withDensity、演化Measure.map与全部加权配对链；公开ρ/ρ\_E的RN解释，不对奇异δ作函数相除。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；已分别核对measureDuality和measureDuality\_RN。前者对任意n、μ、Φ、实值φ和实t，在Φ\_t可测且φ对推前measurePropagator可积时，断言推前积分等于初始测度下的pullback积分。实际measurePropagator定义确为Measure.map，pullback确为φ∘Φ\_t，方向与原配对链相符，未把最终等式作前提；这一单时刻换元无需额外流群律。后者对概率参考ν、非负L¹密度r且∫r=1，置μ₀=ν.withDensity(ofReal∘r)，对可测Φ\_t及有界连续φ，依次给出推前配对=μ₀下pullback配对=∫φ(Φ\_t z)r(z)dν。非负性确保ofReal不截去密度，归一化确保μ₀为概率，有界连续φ使所需配对可积。这里的r是相对于ν的RN密度，对应原ρ₀/ρ\_E的已公开测度解释，不是对Dirac分布作函数相除。原来有界密度的语境被推广为非负L¹概率密度，仍足以保证本条有界测试函数的配对链。PASS限于推前/拉回及加权积分的这套明示解释；本条没有定义生成元或证明算子指数e^(tL)、e^(tL†)的解析半群理论。

### 7. 状态与证明位置

incomplete；`MD.Ch05.measureDuality`：已证；`MD.Ch05.measureDuality_RN`：未证（缺大型理论）。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1951)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

## 1. MD-5.5-MixingMemoryLoss · unnumbered_claim · 印刷p.205 / PDFp.226

### 2. 原文陈述

> We assume $`\psi(z)\stackrel{\rm def}{=}\rho(z;0)/\rho_E(z)`$ is bounded on $`\Sigma_E`$, and moreover $`\operatorname{Av}_{H=E}(\psi)=\int_{\Sigma_E}\frac{\rho(z;0)}{\rho_E(z)}\rho_E(z)\,d\omega=1`$ (i.e., the initial density is a probability density on the energy surface), and that the system is mixing. Then the integral (5.10) is well defined and we may view it as a two-point correlation function of $`\phi`$ and $`\psi`$. By the mixing property it must converge to $`\int_{\Sigma_E}\phi(z)\rho_Ed\omega`$, thus the average value of $`\phi`$ is ultimately independent of the initial conditions. We have

$$
\lim_{t\to\infty}\int_{\Sigma_E}\phi(\mathcal F_t(z))(\psi(z)-1)\rho_Ed\omega=0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mixingMemoryLoss : ∀ n (μ : Measure (MolecularDynamics.Chapter05Review.E n)) Φ (β φ : MolecularDynamics.Chapter05Review.E n → ℝ),
  IsProbabilityMeasure μ → weakMixing μ Φ → Integrable β μ → Bornology.IsBounded (range β) → (∀ z,0 ≤ β z) →
  (∫ z,β z ∂μ)=1 → Continuous φ → Bornology.IsBounded (range φ) →
  (∀ t,MeasurePreserving (Φ t) μ μ) →
  Tendsto (fun t => ∫ z,φ (Φ t z)*(β z-1) ∂μ) atTop (𝓝 0) := by
  intro n μ Φ β φ hμ hm hβ hβbound hβpos hβmass hφ hb hΦ
  letI := hμ
  obtain ⟨C,hC,hB⟩ := hb.exists_pos_norm_le
  have hi : Integrable φ μ := Integrable.mono' (integrable_const C)
    hφ.measurable.aestronglyMeasurable (ae_of_all _ (fun z => hB (φ z) (mem_range_self z)))
  have he (t : ℝ) : (∫ z,φ (Φ t z) ∂μ)=MolecularDynamics.Chapter05Review.average μ φ := by
    have hh := integral_map (hΦ t).measurable.aemeasurable
      (show AEStronglyMeasurable φ (Measure.map (Φ t) μ) from by rw [(hΦ t).map_eq];exact hi.aestronglyMeasurable)
    rw [(hΦ t).map_eq] at hh
    exact hh.symm
  have hp (t : ℝ) : Integrable (fun z => φ (Φ t z)*β z) μ :=
    hβ.bdd_mul (hφ.measurable.comp (hΦ t).measurable).aestronglyMeasurable
      (ae_of_all _ (fun z => hB (φ (Φ t z)) (mem_range_self _)))
  have heq (t : ℝ) : (∫ z,φ (Φ t z)*(β z-1) ∂μ)=
      (∫ z,φ (Φ t z)*β z ∂μ)-MolecularDynamics.Chapter05Review.average μ φ := by
    simp_rw [mul_sub,mul_one]
    have hip : Integrable (fun z => φ (Φ t z)) μ := by
      simpa only [Function.comp_def] using (hΦ t).integrable_comp_of_integrable hi
    rw [integral_sub (hp t) hip,he]
  simp_rw [heq]
  simpa only [sub_self] using (hm.2 β φ hβ hβpos hβmass hφ hb).sub (tendsto_const_nhds : Tendsto (fun _ : ℝ => MolecularDynamics.Chapter05Review.average μ φ) atTop (𝓝 (MolecularDynamics.Chapter05Review.average μ φ)))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch05.mixingMemoryLoss` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]β是对实际参考概率测度的非负密度；原bounded在真实假设中保留，可积明确保障所有密度配对。可测参考测度保持保障常数项积分，φ有界连续；最终memory loss未作假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 对应补足资格后的weakMixing取第二合取，保持既有证明及原结论；不增加新证明。 | [EXTRA] |

[EXTRA] [EXTRA]β是对实际参考概率测度的非负密度；原bounded在真实假设中保留，可积明确保障所有密度配对。可测参考测度保持保障常数项积分，φ有界连续；最终memory loss未作假设。；[EXTRA] 对应补足资格后的weakMixing取第二合取，保持既有证明及原结论；不增加新证明。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：n任意，E n为有限维实欧氏空间；μ是表示能量面参考概率的环境测度，未额外假设Lebesgue密度。Φ为实时间流，weakMixing第一合取规定概率、单位元、群律及联合可测，第二合取是对任意可积非负质量1密度和有界连续测试函数的弱收敛；这是混合的密度测试刻画，并非标准仅Cesàro意义的weak mixing。β可积、有界、非负且积分1，φ有界连续，各时Φ保持μ，结论是整个中心化积分随实t→+∞趋0。由测度保持和质量1亦恢复非中心化极限；[EXTRA]限制明确且充分，未把本条特定中心化结论作假设。 本条全部本地声明：MD.Ch05.mixingMemoryLoss。这是只读签名及数学语义审核，未编译、不补证明、不因sorry降级。

### 7. 状态与证明位置

self-contained；`MD.Ch05.mixingMemoryLoss`：已证。
位置：[Blueprint/Ch05.lean](../../../../Blueprint/Ch05.lean#L1976)；逐声明核验：blueprint/closeout24/ch05/full-run.log。

