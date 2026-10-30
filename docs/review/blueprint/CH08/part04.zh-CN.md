[上一部分](part03.zh-CN.md) / [目录](../../CH08_BLUEPRINT.zh-CN.md) / [下一部分](part05.zh-CN.md)

## MD-8.6.2-SINLyapunov

印刷页 368–369 / PDF页 389–390。

### 1. 原文陈述

> For $`\varphi=\xi_2^2/2`$, $`L_{isok}\varphi=(\xi_1^2-\beta^{-1})\xi_2-\gamma\xi_2^2+\sigma^2/2`$, and the isokinetic constraint bounds $`\xi_1`$. The negative tail drift supports the ergodicity argument with further assumptions.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinGenerator (θ γ : ℝ) (F : ℝ → ℝ) (f : Vec 4 → ℝ) (z : Vec 4) : ℝ :=
  additiveGenerator (sinDrift 1 1 θ γ F) (sinHarmonicG θ γ) f z
theorem sinGenerator_lyapunov (θ γ : ℝ) (hθ : 0 < θ) (hγ : 0 < γ)
    (F : ℝ → ℝ) (z : Vec 4) (hK : sinConstraint 1 z ≠ 0) :
    sinGenerator θ γ F (fun x ↦ x 3^2/2) z =
      (z 2^2-θ)*z 3-γ*z 3^2+γ*θ := by
  sorry
theorem sinConstraint_bathBound (θ : ℝ) (z : Vec 4) (hz : sinConstraint 1 z=θ) :
    z 2^2 ≤ 2*θ := by
  dsimp [sinConstraint] at hz
  nlinarith [sq_nonneg (z 1)]

/-- 原页带有符号的线性尾项，只保留其表达式。 -/
def sinLyapunovTailPrinted (θ γ C : ℝ) (z : Vec 4) : ℝ :=
  -γ*z 3^2+C*z 3+γ*θ

/-- 修正版：对两侧尾部均适用的绝对值界。 -/
theorem sinLyapunovTail_corrected (θ γ : ℝ) (hθ : 0 < θ) (hγ : 0 < γ)
    (F : ℝ → ℝ) (z : Vec 4) (hz : sinConstraint 1 z=θ) :
    sinGenerator θ γ F (fun x ↦ x 3^2/2) z ≤
      -γ*z 3^2+θ*|z 3|+γ*θ := by
  have hk : sinConstraint 1 z ≠ 0 := by rw [hz]; exact ne_of_gt hθ
  rw [sinGenerator_lyapunov θ γ hθ hγ F z hk]
  have hb := sinConstraint_bathBound θ z hz
  rcases le_total 0 (z 3) with h | h
  · rw [abs_of_nonneg h]
    nlinarith [mul_nonneg (sub_nonneg.mpr hb) h]
  · rw [abs_of_nonpos h]
    nlinarith [mul_nonneg (sq_nonneg (z 2)) (neg_nonneg.mpr h)]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 局部生成元恒等式、约束上的热浴界、原印有符号尾项表达式与绝对值尾界修正版；不含遍历性充分性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] `sinGenerator_lyapunov`要求$`\theta\gt 0`$、$`\gamma\gt 0`$与$`\Lambda\ne0`$；`sinLyapunovTail_corrected`要求$`\Lambda=\theta`$，因$`\theta\gt 0`$自动排除$`\Lambda=0`$。
- `sinConstraint_bathBound`允许任意θ，但约束等式本身蕴含$`\theta\ge0`$及$`\xi_1^2\le2\theta`$；无需漏加$`\theta\gt 0`$。
- [ERRATUM?] 原页的固定有符号$`K\xi_2`$项不能统一支配两侧尾部；Printed仅存原印表达式，不断言其为上界；修正版为$`-\gamma\xi_2^2+\theta\lvert\xi_2\rvert+\gamma\theta`$。
- 仅覆盖生成元恒等式与约束界；局部计算尚有sorry，此项不据此判签名FAIL。未形式化遍历性的全局条件或充分性。
- [EXTRA] 当前生成元固定单位质量$`Q1=Q2=1`$，并使用$`\sigma^2=2\gamma\theta`$；常数$`\gamma\theta`$来自$`\sigma^2/2`$。局部生成元和约束界不等于全局遍历性。
- 覆盖缺口：局部生成元恒等式、约束上的热浴界、原印有符号尾项表达式与绝对值尾界修正版；不含遍历性充分性。
- 覆盖缺口：仅覆盖生成元恒等式与约束界；局部计算尚有sorry，此项不据此判签名FAIL。未形式化遍历性的全局条件或充分性。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：NEEDS_HUMAN；五项声明及全部依赖定义逐一审查：单位Q1,Q2及$`\sigma^2=2\gamma\theta`$下，sinGenerator和Lyapunov恒等式正确；hθ,hγ,hK与结论对象完整。sinConstraint_bathBound由$`p^2+\xi_1^2/2=\theta`$得到$`\xi_1^2\le2\theta`$，允许θ为任意实数没有遗漏。Printed只保存有符号尾项表达式，字面忠实性PASS；_corrected在$`\Lambda=\theta`$、$`\theta,\gamma\gt 0`$下给双侧有效界，陈述正确PASS，不包含遍历性结论。总体NEEDS_HUMAN源于原书固定有符号尾项上界疑误及全局遍历性论证尚需核实；不因恒等式sorry或依赖该恒等式的修正版而判签名FAIL。未编译或补证明。
原文版：Printed表达式忠实性PASS；有符号尾界疑误待导师。
修正版：单位质量、$`\sigma^2=2\gamma\theta`$下生成元与绝对值尾界签名网站PASS，非遍历性。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：[ERRATUM?][SOURCE_LYAPUNOV_SIGNED_BOUND] 原页390以$`\xi_1`$有界推出固定有符号$`K\xi_2`$全局上界，未区分$`\xi_2`$正负。需保留原文并由人工确认勘误；绝对值修正版正确。；[SOURCE_ERGODICITY_GAP] 原页还提出周期/有界配置、约束及候选测度在开集上为正等全局条件，并援引其他论证；当前局部Lean声明没有遍历性结论，不能将其当作完整遍历性证明。；已目视核对原页PDF390：原印有符号$`K\xi_2`$界不能统一控制正负两侧。单位质量$`Q1=Q2=1`$、$`\sigma^2=2\gamma\theta`$下修正版为$`-\gamma\xi_2^2+\theta\lvert\xi_2\rvert+\gamma\theta`$；仅为局部生成元和约束界，不推出遍历性。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页389–390。

### 7. 状态与证明位置

- `MD.Ch08.sinGenerator`：定义
- `MD.Ch08.sinGenerator_lyapunov`：未证；缺大型理论
- `MD.Ch08.sinConstraint_bathBound`：已证
- `MD.Ch08.sinLyapunovTailPrinted`：定义
- `MD.Ch08.sinLyapunovTail_corrected`：未证；缺大型理论；传递依赖未证陈述

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.3-SINForceSplitting

印刷页 370–371 / PDF页 391–392。

### 1. 原文陈述

> $`U=U_S+U_F`$ and $`F=F_S+F_F`$. The generators split into kinetic, isokinetic fast force, isokinetic slow force, Nosé and OU terms; each preserves $`\Lambda=p^2+\mu_1\xi_1^2/2`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinKField (z : Vec 4) : Vec 4 := ![z 1,0,0,0]
def sinForceField (Q1 F : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,F-z 1^2*F/sinConstraint Q1 z,-z 1*z 2*F/sinConstraint Q1 z,0]
def sinNField (Q1 Q2 θ : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,Q1*z 2^2*z 3*z 1/(2*sinConstraint Q1 z),
    Q1*z 2^3*z 3/(2*sinConstraint Q1 z)-z 3*z 2,(Q1*z 2^2-θ)/Q2]
def sinOField (γ : ℝ) (z : Vec 4) : Vec 4 := ![0,0,0,-γ*z 3]
theorem sinSplit_fields (Q1 Q2 θ γ : ℝ) (FF FS : ℝ → ℝ) (z : Vec 4)
    (hK : sinConstraint Q1 z ≠ 0) :
    sinDrift Q1 Q2 θ γ (fun q ↦ FF q+FS q) z =
      sinKField z+sinForceField Q1 (FF (z 0)) z+
      sinForceField Q1 (FS (z 0)) z+sinNField Q1 Q2 θ z+sinOField γ z := by
  ext i; fin_cases i <;> simp [sinDrift,sinMultiplier,sinKField,sinForceField,sinNField,sinOField]
    <;> field_simp <;> ring
theorem sinForce_constraintBalance (Q1 F : ℝ) (z : Vec 4)
    (hK : sinConstraint Q1 z ≠ 0) :
    2*z 1*(sinForceField Q1 F z) 1+Q1*z 2*(sinForceField Q1 F z) 2=0 := by
  change 2*z 1*(F-z 1^2*F/sinConstraint Q1 z)+
    Q1*z 2*(-z 1*z 2*F/sinConstraint Q1 z)=0
  generalize hd : sinConstraint Q1 z = lam at *
  field_simp [hK]
  rw [← hd]
  dsimp [sinConstraint]
  ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 五个子场及其实际和分解、力子场瞬时约束平衡；不含整体方法阶数。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`Q_1,Q_2,\theta\gt 0`$且$`\Lambda=\theta`$为物理域，总化场保留作辅助；本条含完整漂移和分解及力子场瞬时约束平衡，其他子场的流存在/保约束列缺口。
- 覆盖缺口：五个子场及其实际和分解、力子场瞬时约束平衡；不含整体方法阶数。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页391–392。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinKField`：定义
- `MD.Ch08.sinForceField`：定义
- `MD.Ch08.sinNField`：定义
- `MD.Ch08.sinOField`：定义
- `MD.Ch08.sinSplit_fields`：已证
- `MD.Ch08.sinForce_constraintBalance`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.3-SINRAlgorithm

印刷页 371 / PDF页 392。

### 1. 原文陈述

> The SIN(R) algorithm uses $`\tilde h=h/r`$, $`r-2`$ repeated inner blocks, outer Nosé half-steps, combined fast/slow force half-steps and independent OU substeps.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
inductive SINStage where
  | kinetic | fast | slow | nose | ou
  deriving DecidableEq
def sinRStages (h : ℝ) (r : ℕ) : List (List (SINStage × ℝ)) :=
  let a := h/(r:ℝ)
  [[(.nose,h/2)],[(.fast,a/2),(.slow,h/2)],[(.kinetic,a)],[(.ou,a)],[(.fast,a/2)]] ++
  List.flatten (List.replicate (r-2)
    [[(.fast,a/2)],[(.kinetic,a/2)],[(.ou,a)],[(.kinetic,a/2)],[(.fast,a/2)]]) ++
  [[(.fast,a/2)],[(.ou,a)],[(.kinetic,a)],[(.fast,a/2),(.slow,h/2)],[(.nose,h/2)]]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印算法的阶段顺序与步长；不声称构造了各非线性子流。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 算法有效域$`h\gt 0`$、$`r\ge2`$；一组中多个场表示同一次合并传播，并非擅自换为两个非交换流。每次OU用独立标准正态新噪声。
- 这里只记录精确阶段表，具体随机核实现、保约束及全局误差/阶数列覆盖缺口。
- 覆盖缺口：原印算法的阶段顺序与步长；不声称构造了各非线性子流。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页392。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinRStages`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.3-SINNoseSubsplitting

印刷页 372 / PDF页 393。

### 1. 原文陈述

> $`L_N=L_N^{(1)}+L_N^{(2)}`$. The first term acts on $`p,\xi_1`$, the second has $`\mu_2^{-1}(\mu_1\xi_1^2-\beta^{-1})\partial_{\xi_2}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinN1Field (Q1 : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,Q1*z 2^2*z 3*z 1/(2*sinConstraint Q1 z),
    Q1*z 2^3*z 3/(2*sinConstraint Q1 z)-z 3*z 2,0]
def sinN2Field (Q1 Q2 θ : ℝ) (z : Vec 4) : Vec 4 := ![0,0,0,(Q1*z 2^2-θ)/Q2]
theorem sinN_split (Q1 Q2 θ : ℝ) (z : Vec 4) :
    sinNField Q1 Q2 θ z=sinN1Field Q1 z+sinN2Field Q1 Q2 θ z := by
  ext i; fin_cases i <;> simp [sinNField,sinN1Field,sinN2Field]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | Nosé场的两项分解恒等式。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 正质量、温度及$`\Lambda\gt 0`$作为物理资格；高阶Yoshida/Suzuki组合的系数和误差阶未在原页给出，列覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页393。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinN1Field`：定义
- `MD.Ch08.sinN2Field`：定义
- `MD.Ch08.sinN_split`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.3-SINForceExactPrinted

印刷页 372 / PDF页 393。

### 1. 原文陈述

> $`\dot p=F-p^2F/\Lambda`$, $`\dot\xi_1=p\xi_1F/\Lambda`$. The printed solution is $`p(h)=(p(0)+(F/m)s(h))/\dot s(h)`$, $`\xi_1(h)=\xi_1(0)/\dot s(h)`$, with $`s(t)=b^{-1/2}\sinh(t\sqrt b)+(a/b)(\cosh(t\sqrt b)-1)`$, $`a=Fp(0)/\Lambda`$, $`b=F^2/\Lambda`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinForceAux (a b t : ℝ) : ℝ :=
  if b=0 then t+a*t^2/2 else Real.sinh (t*Real.sqrt b)/Real.sqrt b+a/b*(Real.cosh (t*Real.sqrt b)-1)
def sinForceFlow (Q1 F t : ℝ) (z : Vec 4) : Vec 4 :=
  let lam := sinConstraint Q1 z
  let s := sinForceAux (F*z 1/lam) (F^2/lam)
  ![z 0,(z 1+F*s t)/deriv s t,z 2/deriv s t,z 3]
def sinForceODEPrinted (Q1 F : ℝ) (z : Vec 4) : Vec 4 :=
  ![0,F-z 1^2*F/sinConstraint Q1 z,z 1*z 2*F/sinConstraint Q1 z,0]
def sinForceODE_corrected (Q1 F : ℝ) : Vec 4 → Vec 4 := sinForceField Q1 F
theorem sinForceFlow_solution_corrected (Q1 F : ℝ) (z : Vec 4)
    (hQ1 : 0 < Q1) (hK : 0 < sinConstraint Q1 z) (t : ℝ)
    (hden : deriv (sinForceAux (F*z 1/sinConstraint Q1 z) (F^2/sinConstraint Q1 z)) t ≠ 0) :
    HasDerivAt (fun s ↦ sinForceFlow Q1 F s z)
      (sinForceField Q1 F (sinForceFlow Q1 F t z)) t := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印子场、显式候选与校正ODE的局部导数目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 质量按本节假设取1；$`Q_1`$、Λ正，排除$`\dot s=0`$；$`F=0`$用$`b=0`$的解析延拓，避免总化除法假装极限。
- 只声明候选流在有效域满足校正ODE，不证明全局流、组合方法精度或遍历性。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed正号ODE忠实性PASS；与候选导数冲突。
修正版：原送审负号_corrected及局部解签名PASS；限$`m=1`$与非零分母。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF393：所印$`\dot\xi_1`$为正号，与前页力子场及$`\xi_1(h)=\xi_1(0)/\dot s(h)`$的负号导数冲突。保留原印和负号工作修正版。；[ERRATUM?] 保留Printed，给$`\xi_1`$负号版添加[ERRATUM?]；保留$`m=1`$的[EXTRA]，不要把工作修正版回填为原文。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页393。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinForceAux`：定义
- `MD.Ch08.sinForceFlow`：定义
- `MD.Ch08.sinForceODEPrinted`：定义
- `MD.Ch08.sinForceODE_corrected`：定义
- `MD.Ch08.sinForceFlow_solution_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.4-SINThreeLevelPotential

印刷页 373 / PDF页 394。

### 1. 原文陈述

> $`U_{Total}=U_{bonds}+U_{s.r.}+U_{l.r.}`$; $`h_{outer}`$ and $`h_{mid}`$ are integer multiples of the next smaller stepsizes.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def threeLevelPotential (bond short long : Vec n → ℝ) : Vec n → ℝ := bond+short+long
def nestedTimeSteps (inner middle outer : ℝ) : Prop :=
  0 < inner ∧ ∃ r s : ℕ, 0 < r ∧ 0 < s ∧ middle=r*inner ∧ outer=s*middle
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 三层势与步长嵌套的定义。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 仅保留势的三项分解和整数时标嵌套；SPME实现、99fs稳定性及水分子径向分布等属于数值观察，逐项排除。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页394。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.threeLevelPotential`：定义
- `MD.Ch08.nestedTimeSteps`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7-GeneralizedLangevin

印刷页 374 / PDF页 395。

### 1. 原文陈述

> $`dq=M^{-1}p\,dt`$, $`dp=-\nabla U(q)dt-\int_0^t\Gamma(t-s)p(s)ds\,dt+dB`$, $`q(0)=q_0,p(0)=p_0`$. $`\Gamma`$ is the memory kernel and $`B`$ is colored noise. (8.57)–(8.58).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def memoryDrag (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (p : ℝ → Vec n) (t : ℝ) : Vec n :=
  -∫ s in (0 : ℝ)..t, Γ (t-s) *ᵥ p s
def generalizedLangevin (P : Measure Ω) (invm : Vec n) (U : Vec n → ℝ)
    (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (B : ℝ → Ω → Vec n)
    (X : ℝ → Ω → Phase n) (x0 : Phase n) : Prop :=
  IsProbabilityMeasure P ∧ (∀ i, 0 < invm i) ∧ ContDiff ℝ 1 U ∧ ContinuousOn Γ (Ici 0) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧
    ContinuousOn (fun t ↦ B t sample) (Ici 0)) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ B s sample) inferInstance] (X t)) ∧
  ∀ t, 0 ≤ t →
    (∀ᵐ sample ∂P, IntervalIntegrable
      (fun s ↦ -gradient U (X s sample).1+memoryDrag Γ (fun r ↦ (X r sample).2) s) volume 0 t) ∧
    ∀ᵐ sample ∂P,
      (X t sample).1=x0.1+∫ s in (0 : ℝ)..t, (fun i ↦ invm i*(X s sample).2 i) ∧
      (X t sample).2=x0.2+(∫ s in (0 : ℝ)..t,
        -gradient U (X s sample).1+memoryDrag Γ (fun r ↦ (X r sample).2) s)+B t sample-B 0 sample
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 连续矩阵记忆核下的卷积及GLE积分解类定义。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- B不是Wiener；这里是加性有色噪声增量的积分方程，未把R(t)dt当作白噪声的普通导数。
- 本条取非负时间连续记忆核以保证内部卷积可积；自然历史适应和正质量为选定强解范围。一般粗糙核与解存在唯一性列缺口。
- [EXTRA] generalizedLangevin仅为给定B的方程规格；未在此谓词约束有色性、非Gaussian性或涨落耗散关系。
- 已目视核对原页PDF395：colored-noise后的non-Gaussian不是同义解释。有色Gaussian过程存在（如平稳OU）；原句保留，修正说明为“有色性指跨时相关，Gaussian性另定”。此处属文字修正，不引入无关定理。
- [EXTRA] generalizedLangevin仅为给定加性驱动B的积分方程，噪声分布、有色性及FD未在本定义内强制，由另条规格给出。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：原送审给定B的积分方程规格可接受；有色/非Gaussian同义说法待导师。
修正版：本轮文字修正：有色Gaussian可以存在；不新增分布或FD结论。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：[ERRATUM?] 保留原句并加[ERRATUM?]；注明generalizedLangevin仅为给定加性驱动的积分方程，噪声分布及FD在其他规格中另行约束。；已目视核对原页PDF395：colored-noise后的non-Gaussian不是同义解释。有色Gaussian过程存在（如平稳OU）；原句保留，修正说明为“有色性指跨时相关，Gaussian性另定”。此处属文字修正，不引入无关定理。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页395。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.memoryDrag`：定义
- `MD.Ch08.generalizedLangevin`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7-GLEFluctuationDissipationPrinted

印刷页 374 / PDF页 395。

### 1. 原文陈述

> $`\langle R_i(t+s)R_j(t)\rangle=k_B T\gamma_{ij}(s)\delta_{ij}`$, $`s\ge0`$. $`\Gamma(t)=\gamma(t)I`$ in the scalar-kernel specialization. (8.59).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def randomForceQualification (P : Measure Ω) (R : ℝ → Ω → Vec n) : Prop :=
  IsProbabilityMeasure P ∧ ∀ t, 0 ≤ t → ∀ i, MemLp (fun sample ↦ R t sample i) 2 P ∧
    (∫ sample, R t sample i ∂P)=0
def gleFDPrinted (P : Measure Ω) (R : ℝ → Ω → Vec n)
    (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (θ : ℝ) : Prop :=
  0 < θ ∧ randomForceQualification P R ∧ ∀ t s, 0 ≤ t → 0 ≤ s → ∀ i j,
    (∫ sample, R (t+s) sample i*R t sample j ∂P)=if i=j then θ*Γ s i j else 0
def gleFD_corrected (P : Measure Ω) (R : ℝ → Ω → Vec n)
    (Γ : ℝ → Matrix (Fin n) (Fin n) ℝ) (θ : ℝ) : Prop :=
  0 < θ ∧ randomForceQualification P R ∧ ∀ t s, 0 ≤ t → 0 ≤ s → ∀ i j,
    (∫ sample, R (t+s) sample i*R t sample j ∂P)=θ*Γ s i j
def scalarMemoryMatrix (γ : ℝ → ℝ) (t : ℝ) : Matrix (Fin n) (Fin n) ℝ :=
  Matrix.diagonal (fun _ ↦ γ t)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | Printed与一般矩阵协方差目标及标量核定义；不包含涨落耗散定理的物理推导。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 修正版作为单位质量下的一般矩阵协方差目标，不声称任意Γ均可实现为随机过程；正定协方差/核存在性列缺口。
- 覆盖缺口：修正版作为单位质量下的一般矩阵协方差目标，不声称任意Γ均可实现为随机过程；正定协方差/核存在性列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed的δ忠实于原页；一般矩阵解释有疑。
修正版：原送审去δ的矩阵协方差目标PASS；可实现性另需正定资格。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF395：一般矩阵核后额外乘$`\delta_{ij}`$会消掉交叉相关，只在对角核/独立分量解释下成立；标量核特化没有此问题。颜色与非Gaussian不是同义条件。；[ERRATUM?] 保留Printed并加[ERRATUM?]；一般矩阵版删除δ或把适用域限制为对角核，注明核可实现性另需正定条件。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页395。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.randomForceQualification`：定义
- `MD.Ch08.gleFDPrinted`：定义
- `MD.Ch08.gleFD_corrected`：定义
- `MD.Ch08.scalarMemoryMatrix`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7-PronyKernel

印刷页 375 / PDF页 396。

### 1. 原文陈述

> $`\gamma(t)=\sum_k(c_k/\tau_k)\exp(-t/\tau_k)`$, $`t\ge0`$. (8.60).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pronyKernel {K : ℕ} (c τ : Fin K → ℝ) (t : ℝ) : ℝ :=
  ∑ k, c k/τ k*Real.exp (-t/τ k)
def pronyQualification {K : ℕ} (c τ : Fin K → ℝ) : Prop :=
  ∀ k, 0 < c k ∧ 0 < τ k
theorem pronyKernel_nonneg {K : ℕ} (c τ : Fin K → ℝ)
    (h : pronyQualification c τ) (t : ℝ) : 0 ≤ pronyKernel c τ t := by
  apply Finset.sum_nonneg
  intro k hk
  exact mul_nonneg (le_of_lt (div_pos (h k).1 (h k).2)) (le_of_lt (Real.exp_pos _))
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 正指数系数/记忆时间资格、Prony核定义及非负性；不包含过程极限。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 正$`c_k`$、$`\tau_k`$为后文OU实现所用域；此处只定义Prony核并证明非负，不声称任意记忆核的逼近误差。
- 覆盖缺口：正$`c_k`$、$`\tau_k`$为后文OU实现所用域；此处只定义Prony核并证明非负，不声称任意记忆核的逼近误差。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页396。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pronyKernel`：定义
- `MD.Ch08.pronyQualification`：定义
- `MD.Ch08.pronyKernel_nonneg`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7.1-PronyMemoryODE

印刷页 375 / PDF页 396。

### 1. 原文陈述

> $`\eta_{ik}(t)=-\int_0^t(c_k/\tau_k)\exp(-(t-s)/\tau_k)p_i(s)ds`$, $`d\eta_{ik}=-\eta_{ik}dt/\tau_k-c_kp_i\,dt/\tau_k`$. Equations (8.61)–(8.64) remove the convolution history.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pronyMemory (c τ : ℝ) (p : ℝ → ℝ) (t : ℝ) : ℝ :=
  -∫ s in (0 : ℝ)..t, c/τ*Real.exp (-(t-s)/τ)*p s
theorem pronyMemory_derivative (c τ : ℝ) (hτ : 0 < τ)
    (p : ℝ → ℝ) (hp : Continuous p) (t : ℝ) :
    HasDerivAt (pronyMemory c τ p) (-pronyMemory c τ p t/τ-c/τ*p t) t := by
  sorry
def pronyMomentumDrift {K : ℕ} (F : Vec n) (η : Fin K → Vec n) (R : Vec n) : Vec n :=
  F+(∑ k, η k)+R
theorem pronyMemory_sum {K : ℕ} (c τ : Fin K → ℝ) (p : ℝ → Vec n)
    (hq : pronyQualification c τ) (hp : Continuous p) (t : ℝ) :
    (∑ k, fun i ↦ pronyMemory (c k) (τ k) (fun s ↦ p s i) t) =
      memoryDrag (scalarMemoryMatrix (n:=n) (pronyKernel c τ)) p t := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 卷积辅助定义、微分关系和有限和等式；与扩展随机解的完整等价列缺口。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- p连续、τ正保证有限区间卷积合法；仅消去有限Prony历史，未声称无限Prony极限或解分布等价。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页396。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pronyMemory`：定义
- `MD.Ch08.pronyMemory_derivative`：未证；缺大型理论
- `MD.Ch08.pronyMomentumDrift`：定义
- `MD.Ch08.pronyMemory_sum`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7.1-PronyOUStationarity

印刷页 376 / PDF页 397。

### 1. 原文陈述

> $`dR_{ik}=-R_{ik}dt/\tau_k+\sqrt{2\theta c_k}dW_{ik}/\tau_k`$；原印$`E[R_{ik}(t)]=0`$、$`E[R_{ik}(t+s)R_{ik}(t)]=(\theta c_k/\tau_k)\exp(-s/\tau_k)`$，$`t,s\ge0`$；$`R_i=\sum_{k\in\mathrm{Fin}\,K}R_{ik}`$（书中$`k=1,\ldots,k_{max}`$，$`K=k_{max}`$）。[EXTRA] 两个Lean相关式均补平稳初态及独立性，不是无条件原印结论。

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def stationaryPronyOU (P : Measure Ω) (W : ℝ → Ω → Vec 1) (R : ℝ → Ω → ℝ)
    (c τ θ : ℝ) : Prop :=
  independentWiener P 1 W ∧ 0 < c ∧ 0 < τ ∧ 0 < θ ∧
  HasLaw (R 0) (gaussianReal 0 (Real.toNNReal (θ*c/τ))) P ∧
  IndepFun (R 0) (fun sample t ↦ W t sample) P ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ R t sample) (Ici 0)) ∧
  (∀ t, 0 ≤ t → MemLp (R t) 2 P) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    R t sample=R 0 sample+(∫ s in (0 : ℝ)..t, -R s sample/τ)+
      Real.sqrt (2*θ*c)/τ*(W t sample 0-W 0 sample 0)
theorem pronyOU_covariance (P : Measure Ω) (W : ℝ → Ω → Vec 1)
    (R : ℝ → Ω → ℝ) (c τ θ : ℝ) (hR : stationaryPronyOU P W R c τ θ)
    (t s : ℝ) (ht : 0 ≤ t) (hs : 0 ≤ s) :
    (∫ sample, R t sample ∂P)=0 ∧
      (∫ sample, R (t+s) sample*R t sample ∂P)=θ*c/τ*Real.exp (-s/τ) := by
  sorry
def totalPronyRandomForce {K : ℕ} (R : Fin K → ℝ → Ω → ℝ) (t : ℝ) (sample : Ω) : ℝ :=
  ∑ k, R k t sample

/-- 修正版显式使用已定义的平稳Gaussian初态及与W独立资格；原印未写该前提。 -/
theorem pronyOU_covariance_corrected (P : Measure Ω) (W : ℝ → Ω → Vec 1)
    (R : ℝ → Ω → ℝ) (c τ θ : ℝ) (hR : stationaryPronyOU P W R c τ θ)
    (t s : ℝ) (ht : 0 ≤ t) (hs : 0 ≤ s) :
    (∫ sample, R t sample ∂P)=0 ∧
      (∫ sample, R (t+s) sample*R t sample ∂P)=θ*c/τ*Real.exp (-s/τ) := pronyOU_covariance P W R c τ θ hR t s ht hs
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | (8.65)–(8.67)的单分量OU方程、原印均值/相关式及有限和；Lean的两个covariance定理均为显式带平稳资格的修正版；保留原印缺省资格疑误。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] θ代表$`k_B T`$，c、τ、θ严格为正；W为一个实Brownian坐标（Vec 1）。
- [EXTRA] $`R(0)`$具有$`N(0,\theta c/\tau)`$律且与整条W独立；非负时间路径几乎处处连续，各非负时刻$`R(t)`$属于$`L^2`$；积分方程逐个非负时刻几乎处处成立。
- [EXTRA] 这里没有对多个模式的W作联合独立假设；totalPronyRandomForce仅为有限和定义，不声称总协方差公式。
- [EXTRA] $`t,s\ge0`$；totalPronyRandomForce的求和为$`k\in\mathrm{Fin}\,K`$（0,…,K−1，对应书中1,…,kmax）；没有跨模式独立或总协方差定理。
- 覆盖缺口：[EXTRA] 这里没有对多个模式的W作联合独立假设；totalPronyRandomForce仅为有限和定义，不声称总协方差公式。
- 覆盖缺口：[EXTRA] $`t,s\ge0`$；totalPronyRandomForce的求和为$`k\in\mathrm{Fin}\,K`$（0,…,K−1，对应书中1,…,kmax）；没有跨模式独立或总协方差定理。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：NEEDS_HUMAN；{"overall": "NEEDS_HUMAN仅针对原书缺省平稳初态及其解释；所列修正版签名在数学上合理，不因sorry判FAIL。", "objects_and_domains": "Ω为任意可测空间，P为Measure Ω；independentWiener在hR内保证P为概率测度。$`W:\mathbb R\to\Omega\to(\mathrm{Fin}\,1\to\mathbb R)`$，$`R:\mathbb R\to\Omega\to\mathbb R`$，c、τ、θ为实数且均严格正。只对$`t\ge0`$、$`s\ge0`$作结论，不断言负时间驻定。", "declarations": [{"lean_decl": "MD.Ch08.stationaryPronyOU", "verdict": "PASS", "explanation": "一维Brownian、方差$`\theta c/\tau`$的中心Gaussian初态、初态与整条W独立、非负时间连续与$`L^2`$、积分OU方程齐全。漂移$`-R/\tau`$及噪声$`\sqrt{2\theta c}/\tau`$与(8.65)吻合；Gaussian第二参数为方差且因正参数toNNReal不截断。此定义是补充资格，不是原印逐字前提。"}, {"lean_decl": "MD.Ch08.pronyOU_covariance", "verdict": "PASS", "explanation": "全称量化P,W,R,c,τ,θ及非负t,s；hR已包含全部平稳资格。完整结论同时给出$`E R(t)=0`$及$`E[R(t+s)R(t)]=(\theta c/\tau)e^{-s/\tau}`$，不是只给单边不等式或仅$`s=0`$。该陈述数学正确；没有Printed/literal标识，不要求它保留无资格的错误断言。"}, {"lean_decl": "MD.Ch08.totalPronyRandomForce", "verdict": "PASS", "explanation": "任意自然数K与$`R:\mathrm{Fin}\,K\to\mathbb R\to\Omega\to\mathbb R`$，在任意t、sample逐点有限求和。Fin K对应原书1至kmax的K个模式的重编号，$`K=0`$为自然空和扩展；未偷加独立性或总协方差结论。"}, {"lean_decl": "MD.Ch08.pronyOU_covariance_corrected", "verdict": "PASS", "explanation": "与前一定理完全相同的量词、hR、时间域及完整二联结论；通过引用前一定理复用补充资格，并非另行证明更强无条件断言。"}]}
原文版：原印无初态资格的(8.66)待导师。
修正版：pronyOU_covariance及_corrected均为[EXTRA]平稳初态版本，签名网站PASS；非无条件原印定理。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：[ERRATUM?] 原页(8.66)断言零均值及与t无关的二阶矩，页内未声明初始律；仅由(8.65)不能推出。原印原句必须保留，是否上下文已默认平稳解释需人工确认。；[EXTRA] stationaryPronyOU补充了正参数、平稳Gaussian初态、与整条W独立、路径连续及各非负时刻$`L^2`$资格；应显式标记其为修正版前提。pronyOU_covariance和_corrected签名相同，前者也已经是带补充资格的版本，不能当作无条件原印断言。；已目视核对原页PDF397：(8.66)印出$`s\ge0`$但未说明平稳初态。修正版另加[EXTRA]初态$`N(0,\theta c/\tau)`$且与整条W独立；$`t,s\ge0`$；有限和用$`k\in\mathrm{Fin}\,K`$，不宣称跨模式总协方差。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页397。

### 7. 状态与证明位置

- `MD.Ch08.stationaryPronyOU`：定义
- `MD.Ch08.pronyOU_covariance`：未证；缺大型理论
- `MD.Ch08.totalPronyRandomForce`：定义
- `MD.Ch08.pronyOU_covariance_corrected`：未证；缺大型理论；传递依赖未证陈述

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7.1-CombinedPronyVariable

印刷页 376 / PDF页 397。

### 1. 原文陈述

> $`\sigma_{ik}=\eta_{ik}+R_{ik}`$ yields $`d\sigma_{ik}=-\sigma_{ik}dt/\tau_k-c_kp_i\,dt/\tau_k+\sqrt{2k_B T c_k}dW_{ik}/\tau_k`$. (8.68)–(8.70).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
abbrev GLEState (n K : ℕ) := Phase n × (Fin K → Vec n)
def gleDrift {K : ℕ} (invm : Vec n) (U : Vec n → ℝ) (c τ : Fin K → ℝ)
    (z : GLEState n K) : GLEState n K :=
  ((fun i ↦ invm i*z.1.2 i,-gradient U z.1.1+∑ k, z.2 k),
   fun k i ↦ -z.2 k i/τ k-c k/τ k*z.1.2 i)
def gleNoise {K : ℕ} (c τ : Fin K → ℝ) (θ : ℝ)
    (e : Fin (K*n) ≃ Fin K × Fin n) (j : Fin (K*n)) : GLEState n K :=
  ((0,0),fun k i ↦ if (k,i)=e j then Real.sqrt (2*θ*c k)/τ k else 0)
def isExtendedGLESolution {K : ℕ} (invm : Vec n) (U : Vec n → ℝ)
    (c τ : Fin K → ℝ) (θ : ℝ) (e : Fin (K*n) ≃ Fin K × Fin n)
    (P : Measure Ω) (W : ℝ → Ω → Vec (K*n))
    (X : ℝ → Ω → GLEState n K) (x0 : GLEState n K) : Prop :=
  (∀ i, 0 < invm i) ∧ 0 < θ ∧ pronyQualification c τ ∧ ContDiff ℝ 1 U ∧
  additiveSDE P (K*n) W X x0 (gleDrift invm U c τ) (gleNoise c τ θ e)
theorem combinedProny_drift (η R c τ p : ℝ) :
    (-η/τ-c/τ*p)+(-R/τ)=-(η+R)/τ-c/τ*p := by ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 有限维扩展SDE完整积分规格及$`\sigma=\eta+R`$的漂移恒等式。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 额外变量取实数；正质量、c、τ、温度和独立标准向量Wiener写入解规格。e仅把有限噪声坐标编号为(k,i)。
- 本条实际是加性扩展SDE和漂移合并恒等式；Markov半群构造、解存在唯一及与非Markov GLE分布等价列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页397。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.GLEState`：定义
- `MD.Ch08.gleDrift`：定义
- `MD.Ch08.gleNoise`：定义
- `MD.Ch08.isExtendedGLESolution`：定义
- `MD.Ch08.combinedProny_drift`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7.1-PronyLangevinLimit

印刷页 376–377 / PDF页 397–398。

### 1. 原文陈述

> Formally $`\tau_k\to0`$ gives $`\sigma_{ik}dt=-c_kp_i\,dt+\sqrt{2k_B T c_k}dW_{ik}`$ and Langevin friction $`\hat\gamma=\sum_kc_k`$. Independent Gaussian variances add.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pronyEffectiveFriction {K : ℕ} (c : Fin K → ℝ) : ℝ := ∑ k, c k
theorem pronyLimit_drift {K : ℕ} (c : Fin K → ℝ) (F p : ℝ) :
    F-∑ k, c k*p=F-pronyEffectiveFriction c*p := by
  simp [pronyEffectiveFriction,Finset.sum_mul]
theorem independentGaussian_varianceSum {K : ℕ} (P : Measure Ω)
    (R : Ω → (Fin K → ℝ)) (c : Fin K → ℝ) (hc : ∀ k, 0 ≤ c k)
    (hR : HasLaw R (Measure.pi (fun _ : Fin K ↦ gaussianReal 0 1)) P) :
    HasLaw (fun sample ↦ ∑ k, Real.sqrt (c k)*R sample k)
      (gaussianReal 0 (Real.toNNReal (pronyEffectiveFriction c))) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 有效摩擦定义、合并漂移和有限Gaussian求和分布，不是小记忆时间极限定理。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 仅形式极限系数与真实有限个独立Gaussian线性组合；$`\tau\to0`$过程弱收敛、初始层、统一时间界不在本条声明，列覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页397–398。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pronyEffectiveFriction`：定义
- `MD.Ch08.pronyLimit_drift`：已证
- `MD.Ch08.independentGaussian_varianceSum`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7.1-GeneralizedLangevinIntegrator

印刷页 377 / PDF页 398。

### 1. 原文陈述

> The four-step method updates $`p_{half}`$, $`q_{new}`$, $`\sigma_{new,k}=\theta_k\sigma_k-(1-\theta_k)c_kp_{half}+\alpha_k\sqrt{2k_B T c_k}Z_k`$, then $`p_{new}`$ with the new force and new $`\sigma`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def gleIntegrator {K : ℕ} (invm : Vec n) (U : Vec n → ℝ) (c decay noise : Fin K → ℝ)
    (θ h : ℝ) (Z : Fin K → Vec n) (z : GLEState n K) : GLEState n K :=
  let ph := z.1.2+(h/2) • (-gradient U z.1.1+∑ k, z.2 k)
  let qn := z.1.1+(h • fun i ↦ invm i*ph i)
  let sn := fun k i ↦ decay k*z.2 k i-(1-decay k)*c k*ph i+
    noise k*Real.sqrt (2*θ*c k)*Z k i
  ((qn,ph+(h/2) • (-gradient U qn+∑ k, sn k)),sn)
def gleNormalSequence {K : ℕ} (P : Measure Ω) (Z : ℕ → Ω → Fin K → Vec n) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun Z P ∧ ∀ j,
    HasLaw (Z j) (Measure.pi (fun _ : Fin K ↦ Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1))) P
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 四个实际更新及其全部噪声资格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`h\gt 0`$，正质量/c/τ/温度下作物理解读；跨步、模式与空间分量的完整独立正态资格另列gleNormalSequence。
- 此处完整单步定义，不包含离散不变分布、全局弱阶或Langevin极限保持的定理。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页398。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.gleIntegrator`：定义
- `MD.Ch08.gleNormalSequence`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.7.1-GLEConsistentCoefficients

印刷页 377 / PDF页 398。

### 1. 原文陈述

> For consistency $`\theta_k=1-h/\tau_k+O(h^2)`$, $`\alpha_k=\sqrt h/\tau_k+O(h)`$. Choose $`\theta_k=\exp(-h/\tau_k)`$, $`\alpha_k=\sqrt{(1-\theta_k)^2/h}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def gleDecay (τ h : ℝ) : ℝ := Real.exp (-h/τ)
def gleNoiseCoefficient (τ h : ℝ) : ℝ := Real.sqrt ((1-gleDecay τ h)^2/h)
def gleCoefficientConsistency (τ : ℝ) (decay noise : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0)
    (fun h ↦ decay h-(1-h/τ)) (fun h ↦ h^2) ∧
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0)
    (fun h ↦ noise h-Real.sqrt h/τ) (fun h ↦ h)
theorem gleCoefficients_consistent (τ : ℝ) (hτ : 0 < τ) :
    gleCoefficientConsistency τ (gleDecay τ) (gleNoiseCoefficient τ) := by
  sorry
theorem gleCoefficient_smallMemory (h : ℝ) (hh : 0 < h) :
    Tendsto (fun τ ↦ (gleDecay τ h,gleNoiseCoefficient τ h))
      (𝓝[Set.Ioi (0 : ℝ)] 0) (𝓝 ((0 : ℝ),1/Real.sqrt h)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 两项一致性渐近和所选单步系数的$`\tau\to0`$极限。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- h从正侧趋0、τ固定正；小记忆极限另固定$`h\gt 0`$，只陈述单步系数极限，未把它当成随机过程极限或长期采样结论。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页398。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.gleDecay`：定义
- `MD.Ch08.gleNoiseCoefficient`：定义
- `MD.Ch08.gleCoefficientConsistency`：定义
- `MD.Ch08.gleCoefficients_consistent`：未证；缺大型理论
- `MD.Ch08.gleCoefficient_smallMemory`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8-NPTThermodynamics

印刷页 378 / PDF页 399。

### 1. 原文陈述

> $`P=-(\partial E/\partial V)_{S,N}`$; the Maxwell cyclic relation gives $`(\partial S/\partial V)_{E,N}=P/T`$ and $`(\partial S/\partial E)_{V,N}=1/T`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def thermodynamicPressure (E : ℝ → ℝ → ℝ → ℝ) (S V N : ℝ) : ℝ :=
  -deriv (fun v ↦ E S v N) V
def maxwellCycle (dSdE dEdV dVdS : ℝ) : Prop := dSdE*dEdV*dVdS = -1
theorem maxwellPressureRelation (T P dVdS : ℝ) (hT : T ≠ 0)
    (hcycle : maxwellCycle (1/T) (-P) dVdS) : dVdS⁻¹=P/T := by
  have hprod : P*dVdS=T := by
    dsimp [maxwellCycle] at hcycle
    field_simp [hT] at hcycle
    linarith
  have hz : dVdS ≠ 0 := by
    intro hz; rw [hz,mul_zero] at hprod; exact hT hprod.symm
  apply (eq_div_iff hT).2
  rw [← hprod]
  field_simp [hz]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 压力定义和给定非零温度/循环关系后的代数推论。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- E的熵、体积、粒子数参数固定顺序明示；Maxwell循环作为热力学可逆导数资格，并非从任意E无条件推出。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页399。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.thermodynamicPressure`：定义
- `MD.Ch08.maxwellCycle`：定义
- `MD.Ch08.maxwellPressureRelation`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8-NPTBathTaylor

印刷页 378 / PDF页 399。

### 1. 原文陈述

> $`S(N_2,V_2,E_2)=S(\tilde N-N,\tilde V-V,\tilde E-E)\approx S(N_2,\tilde V,\tilde E)-(E+PV)/T`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nptBathLinear (S0 T P E V : ℝ) : ℝ := S0-(E+P*V)/T
theorem nptEntropy_firstOrder (S : ℝ × ℝ → ℝ) (E0 V0 T P : ℝ) (hT : 0 < T)
    (hS : DifferentiableAt ℝ S (E0,V0))
    (hderiv : ∀ v : ℝ × ℝ, fderiv ℝ S (E0,V0) v=v.1/T+(P/T)*v.2) :
    Asymptotics.IsLittleO (𝓝 (0 : ℝ × ℝ))
      (fun z ↦ S (E0-z.1,V0-z.2)-nptBathLinear (S (E0,V0)) T P z.1 z.2)
      (fun z : ℝ × ℝ ↦ ‖z‖) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 线性熵近似与明确的一阶小o余项目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 固定粒子数参数，只对E,V的小扰动；显式Fréchet可微及热力学导数识别，不把原文≈当作精确等式。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页399。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.nptBathLinear`：定义
- `MD.Ch08.nptEntropy_firstOrder`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.8-NPTDensity

印刷页 378–379 / PDF页 399–400。

### 1. 原文陈述

> $`\rho_{NPT}=Z_{NPT}^{-1}\exp[-\beta(H+PV)]`$, $`\beta^{-1}=k_B T`$; physical volume $`V`$ is positive.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def volumeScale (V : ℝ) : ℝ := Real.rpow V (1/3 : ℝ)
def nptBox (n : ℕ) : Set (Phase n × ℝ) :=
  {z | 0 < z.2 ∧ ∀ i, |z.1.1 i| ≤ volumeScale z.2/2}
def nptWeight (H : Phase n × ℝ → ℝ) (β P : ℝ) (z : Phase n × ℝ) : ℝ :=
  Real.exp (-β*(H z+P*z.2))
def nptDensity (H : Phase n × ℝ → ℝ) (β P : ℝ) (z : Phase n × ℝ) : ℝ :=
  (∫ y, nptWeight H β P y ∂volume.restrict (nptBox n))⁻¹*nptWeight H β P z
theorem nptDensity_normalizes (H : Phase n × ℝ → ℝ) (β P : ℝ) (hβ : 0 < β)
    (hi : Integrable (nptWeight H β P) (volume.restrict (nptBox n)))
    (hZ : 0 < ∫ z, nptWeight H β P z ∂volume.restrict (nptBox n)) :
    probabilityDensity (volume.restrict (nptBox n)) (nptDensity H β P) := by
  refine ⟨fun z ↦ mul_nonneg (inv_nonneg.mpr (le_of_lt hZ))
    (le_of_lt (Real.exp_pos _)),hi.const_mul _,?_⟩
  simp only [nptDensity,integral_const_mul]
  exact inv_mul_cancel₀ (ne_of_gt hZ)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 正体积盒内NPT权重和有资格时的概率归一化。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 三维N粒子时$`n=3N`$；盒域明确依赖V，并用受限Lebesgue测度。正有限配分积分与可积性明示；没有由任意势假装得到NPT概率。
- 覆盖缺口：三维N粒子时$`n=3N`$；盒域明确依赖V，并用受限Lebesgue测度。正有限配分积分与可积性明示；没有由任意势假装得到NPT概率。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页399–400。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.volumeScale`：定义
- `MD.Ch08.nptBox`：定义
- `MD.Ch08.nptWeight`：定义
- `MD.Ch08.nptDensity`：定义
- `MD.Ch08.nptDensity_normalizes`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

