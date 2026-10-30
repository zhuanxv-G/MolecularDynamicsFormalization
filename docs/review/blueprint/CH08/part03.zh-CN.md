[上一部分](part02.zh-CN.md) / [目录](../../CH08_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

## MD-8.4.4-VelocityRescaling

印刷页 355 / PDF页 376。

### 1. 原文陈述

> $`dq=p\,dt`$, $`dp=-\nabla U\,dt-\Psi(K)p\,dt+\sqrt{2k_B T\Phi(K)}p\,dW`$; $`\Psi=(2K-(1+N_d)k_B T)\Phi-2k_B TK\Phi'`$. $`\Phi(K)=\gamma_{VR}/(2K)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def rescalingPsi (Φ : ℝ → ℝ) (θ K : ℝ) : ℝ :=
  (2*K-((n:ℝ)+1)*θ)*Φ K-2*θ*K*deriv Φ K
def rescalingDrift (U : Vec n → ℝ) (Φ : ℝ → ℝ) (θ : ℝ) (z : Phase n) : Phase n :=
  (z.2, fun i ↦ -gradient U z.1 i-rescalingPsi (n:=n) Φ θ ((∑ j, z.2 j^2)/2)*z.2 i)
def rescalingNoise (Φ : ℝ → ℝ) (θ : ℝ) (z : Phase n) : Phase n :=
  (0, fun i ↦ Real.sqrt (2*θ*Φ ((∑ j, z.2 j^2)/2))*z.2 i)
def originalRescalingPhi (γ K : ℝ) : ℝ := γ/(2*K)
def rescalingAdmissible (Φ : ℝ → ℝ) : Prop :=
  ContDiffOn ℝ ∞ Φ (Ioi 0) ∧ (∀ K, 0 < K → 0 < Φ K) ∧
  (∃ C ε : ℝ, 0 < ε ∧ ∀ K, 0 < K → K < ε → |K*Φ K| ≤ C) ∧
  ∃ C : ℝ, ∃ m : ℕ, ∀ K, 1 ≤ K → |Φ K| ≤ C*K^m
theorem rescalingPsi_original (γ θ K : ℝ) (hK : K ≠ 0) :
    rescalingPsi (n:=n) (originalRescalingPhi γ) θ K =
      (1-((n:ℝ)-1)*θ/(2*K))*γ := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际漂移扩散、Φ有效性和原始Φ对应Ψ的化简目标；没有完整乘性SDE解规格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- Φ在$`K\gt 0`$光滑正，$`K\Phi`$在0附近有界且多项式增长；原始Φ在$`K=0`$奇异，未声称全空间光滑扩散或遍历性。
- 覆盖缺口：实际漂移扩散、Φ有效性和原始Φ对应Ψ的化简目标；没有完整乘性SDE解规格。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页376。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.rescalingPsi`：定义
- `MD.Ch08.rescalingDrift`：定义
- `MD.Ch08.rescalingNoise`：定义
- `MD.Ch08.originalRescalingPhi`：定义
- `MD.Ch08.rescalingAdmissible`：定义
- `MD.Ch08.rescalingPsi_original`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.4-RescalingStationary

印刷页 355 / PDF页 376。

### 1. 原文陈述

> With these definitions, the method preserves the canonical probability density $`\rho_\beta`$. The book does not prove ergodicity.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem rescalingStationary (U : Vec n → ℝ) (Φ : ℝ → ℝ) (θ Z : ℝ)
    (hU : ContDiff ℝ 2 U) (hΦ : rescalingAdmissible Φ) (hθ : 0 < θ) (hZ : 0 < Z)
    (hρ : probabilityDensity volume (fun z : Phase n ↦
      Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z))
    (f : Phase n → ℝ) (hf : ContDiff ℝ ∞ f) (hc : HasCompactSupport f)
    (havoid : ∀ z ∈ tsupport f, z.2 ≠ 0) :
    (∫ z, (fderiv ℝ f z (rescalingDrift U Φ θ z) +
      fderiv ℝ (fun x ↦ fderiv ℝ f x (rescalingNoise Φ θ z)) z (rescalingNoise Φ θ z)/2) *
      (Real.exp (-(kineticTwice (fun _ ↦ 1) z.2/2+U z.1)/θ)/Z)) = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 闭包支撑tsupport避开零动量的光滑紧支撑测试函数弱驻定目标；零动量边界及半群不变性未覆盖。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] hU要求U为$`C^2`$；$`\theta,Z\gt 0`$且hρ完整要求正则概率密度归一与可积。Φ仅在$`K\gt 0`$上光滑、正，另有$`K\Phi`$在0附近有界及Φ无穷远至多多项式增长的原页条件。
- [EXTRA] f为$`C^\infty`$紧支撑测试函数；当前havoid已对闭包支撑`tsupport f`量化，要求其中每点$`p\ne0`$。有限维紧性确保非空闭包支撑与$`p=0`$分离，K在该支撑上具有严格正下界。
- 二阶项中rescalingNoise Φ θ z对内层变量x保持固定，得到Itô Hessian项的一半，不包含噪声方向的导数。
- 结论仅为$`\int Lf\cdot\rho_\beta=0`$的局部弱驻定目标；未断言随机解存在、零动量边界控制、Markov半群不变性或遍历性。
- 覆盖缺口：闭包支撑tsupport避开零动量的光滑紧支撑测试函数弱驻定目标；零动量边界及半群不变性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：FAIL。
网站复审结论：PASS；审查rescalingPsi、Drift、Noise、Admissible及完整rescalingStationary类型：$`M=I`$、$`n=N_d`$、$`\theta=k_B T`$，Ψ及漂移/扩散系数符号与因子正确；单个噪声给出秩一扩散。二阶项冻结噪声为正确Itô项。$`C^2`$势、Φ在$`K\gt 0`$的光滑正性与增长条件、正θ,Z、概率归一、$`C^\infty`$紧支撑及tsupport避零前提齐全。结论仅为$`\int Lf\rho_\beta=0`$；紧闭包支撑避零已修复旧报告的问题，Φ在$`K=0`$任意的总化值不妨碍该限定范围。完整不变性和遍历性缺口已明确。sorry不影响本次签名判定，未编译或补证明。
原文版：原书全文保留；当前有限平均/弱驻定资格已获网站复审PASS。
修正版：当前声明网站复审PASS，旧FAIL已解决；范围仍按实际覆盖限定。
当前：网站复审PASS（Lean未改）。
原书疑点：[RESOLVED] 旧issues及extra_assumptions中“havoid只量化Function.support f/尚未实现tsupport”的描述已过期；当前完整Lean与依赖规格均明确使用tsupport f。；[COVERAGE_GAP] 零动量边界、全局随机过程及半群不变性尚未形式化；此项是明确披露的覆盖限制，不是当前远离边界的弱驻定声明错误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页376。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.rescalingStationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.5-ThermostatEfficiency

印刷页 356–357 / PDF页 377–378。

### 1. 原文陈述

> efficiency = rate of convergence to equilibrium / rate of growth of perturbation of dynamics. Table 8.1 gives analytic lowest-order estimates; NHL has initially quadratic error.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def thermostatEfficiency (convergence perturbation : ℝ) : ℝ := convergence/perturbation
def langevinErrorEstimate (γ t : ℝ) : ℝ := γ*t
def rescalingRateEstimate (meanK2Phi θ : ℝ) (N : ℕ) : ℝ := 4*meanK2Phi/(θ*N)
def rescalingErrorEstimate (meanKPhi : ℝ) (N : ℕ) (t : ℝ) : ℝ := 2*meanKPhi/(N:ℝ)*t
def nhlRateEstimate (N : ℕ) (θ Q : ℝ) : ℝ := Real.sqrt ((N:ℝ)*θ/Q)
def nhlErrorEstimate (θ Q t : ℝ) : ℝ := θ/(2*Q)*t^2

def langevinRateEstimate (γ : ℝ) : ℝ := γ
def langevinEfficiencyEstimate : ℝ := 1
def originalRescalingRateEstimate (γVR : ℝ) : ℝ := γVR
def originalRescalingErrorEstimate (N : ℕ) (γVR t : ℝ) : ℝ := γVR/(N:ℝ)*t
def originalRescalingEfficiencyEstimate (N : ℕ) : ℝ := N
def nhlCriticalEfficiencyEstimate (N : ℕ) : ℝ := 2*N
def rescalingEfficiencyOrder (efficiency : ℕ → ℝ) : Prop :=
  efficiency =O[atTop] (fun N : ℕ ↦ (N : ℝ))
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 效率比值、表8.1四行解析速率/低阶误差/效率估计及一般VR的$`O(N)`$含义；外引估计定理未证，经验曲线排除。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 表8.1解析估计作为公式定义保留；其外引渐近推导、谱隙与误差阶不是已证定理，列覆盖缺口。
- $`\gamma\gt 0`$、$`\theta,Q\gt 0`$、$`N\gt 0`$用于物理解释；一般VR的$`O(N)`$给出确切渐近性质定义，没有声称任意Φ族满足它。
- 覆盖缺口：$`\gamma\gt 0`$、$`\theta,Q\gt 0`$、$`N\gt 0`$用于物理解释；一般VR的$`O(N)`$给出确切渐近性质定义，没有声称任意Φ族满足它。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页377–378。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.thermostatEfficiency`：定义
- `MD.Ch08.langevinErrorEstimate`：定义
- `MD.Ch08.rescalingRateEstimate`：定义
- `MD.Ch08.rescalingErrorEstimate`：定义
- `MD.Ch08.nhlRateEstimate`：定义
- `MD.Ch08.nhlErrorEstimate`：定义
- `MD.Ch08.langevinRateEstimate`：定义
- `MD.Ch08.langevinEfficiencyEstimate`：定义
- `MD.Ch08.originalRescalingRateEstimate`：定义
- `MD.Ch08.originalRescalingErrorEstimate`：定义
- `MD.Ch08.originalRescalingEfficiencyEstimate`：定义
- `MD.Ch08.nhlCriticalEfficiencyEstimate`：定义
- `MD.Ch08.rescalingEfficiencyOrder`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.5-SLS

印刷页 357–358 / PDF页 378–379。

### 1. 原文陈述

> $`dq=\xi M^{-1}p\,dt`$, $`dp=-\gamma p\,dt+\sigma M^{1/2}dW`$, $`d\xi=-[(M^{-1}p)\cdot\nabla U/\mu+\gamma'\xi]dt+\sigma'dZ`$; $`\sigma=\sqrt{2k_B T\gamma}`$, $`\sigma'=\sqrt{2k_B T\gamma'/\mu}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def slsDrift (invm : Vec n) (U : Vec n → ℝ) (Q γ γb : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.2*invm i*z.1.2 i, fun i ↦ -γ*z.1.2 i),
   -dot (fun i ↦ invm i*z.1.2 i) (gradient U z.1.1)/Q-γb*z.2)
def slsNoise (invm : Vec n) (β Q γ γb : ℝ) (j : Fin (n+1)) : Phase n × ℝ :=
  if hj : j.val < n then
    ((0, Pi.single ⟨j.val,hj⟩ (Real.sqrt (2*γ/(β*invm ⟨j.val,hj⟩)))), 0)
  else ((0,0), Real.sqrt (2*γb/(β*Q)))
def isSLSSolution (invm : Vec n) (U : Vec n → ℝ) (β Q γ γb : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec (n+1))
    (X : ℝ → Ω → Phase n × ℝ) (x0 : Phase n × ℝ) : Prop :=
  thermostatParameters invm β Q ∧ 0 < γ ∧ 0 < γb ∧
  additiveSDE P (n+1) W X x0 (slsDrift invm U Q γ γb) (slsNoise invm β Q γ γb)
def slsDeterministic (invm : Vec n) (U : Vec n → ℝ) (Q : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.2*invm i*z.1.2 i, 0), -dot (fun i ↦ invm i*z.1.2 i) (gradient U z.1.1)/Q)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 完整SLS加性SDE积分解规格、噪声方向与确定性子场定义。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 全部n+1个Wiener坐标独立，Q、质量、温度及两摩擦参数正；总漂移和常噪声用实际积分方程解释。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页378–379。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.slsDrift`：定义
- `MD.Ch08.slsNoise`：定义
- `MD.Ch08.isSLSSolution`：定义
- `MD.Ch08.slsDeterministic`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.5-SLSBracketPrinted

印刷页 358 / PDF页 379。

### 1. 原文陈述

> $`D=(\xi p,-p,-p\cdot\nabla U-\xi)`$, $`D'=[D,Y_{N_c+1}]=(p,0,1)`$, $`[D',Y_i]=e_i`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def slsBathNoise : Phase n × ℝ → Phase n × ℝ := fun _ ↦ ((0,0),1)
theorem slsBracketPrinted (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    VectorField.lieBracket ℝ (slsDrift (fun _ ↦ 1) U 1 1 1) slsBathNoise z = ((z.1.2,0),1) := by
  sorry
theorem slsBracket_corrected (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    VectorField.lieBracket ℝ (slsDrift (fun _ ↦ 1) U 1 1 1) slsBathNoise z = ((-z.1.2,0),1) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 第一漂移/热浴括号的原印与符号修正目标；二重括号在Hörmander另条处理。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只纠正第一括号；二次括号的整体符号不影响生成空间张成。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；括号首分量符号不一致。
修正版：原送审$`-p`$首分量_corrected签名PASS。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF379：沿用Proposition8.2所用括号约定$`[D,Y]=DY\cdot D-DD\cdot Y`$，q分量应为$`-p`$；整体反号也不能同时保留热浴分量+1。；{"codes": ["ERRATUM_LIE_BRACKET_SIGN"], "detail": "slsBracketPrinted逐字对应原书$`(p,0,1)`$，字面忠实性PASS；数学上在标准Lie括号约定下不正确。按$`\mathrm{VectorField.lieBracket}\,V\,W=DW\cdot V-DV\cdot W`$，常向量Yξ给$`[D,Y_\xi]=-\partial_\xi D=(-p,0,1)`$，故_corrected签名正确。反向括号会整体变为$`(p,0,-1)`$，不能仅靠约定得到原书$`(p,0,1)`$。二次括号的整体符号不影响张成。", "suggested_fix": "保留Printed原书字面版并加[ERRATUM?]；实际计算引用_corrected，第一分量应为$`-p`$。"}
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页379。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.slsBathNoise`：定义
- `MD.Ch08.slsBracketPrinted`：未证；原书疑误不证
- `MD.Ch08.slsBracket_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.5-SLSHormander

印刷页 357–358 / PDF页 378–379。

### 1. 原文陈述

> All basis vectors are in the Lie algebra generated by the drift and the N_c+1 noise directions, so Hörmander holds.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem slsHormander (U : Vec n → ℝ) (hU : ContDiff ℝ ∞ U) (z : Phase n × ℝ) :
    textbookHormanderAt
      (insert (slsDrift (fun _ ↦ 1) U 1 1 1)
        (Set.range (fun j : Fin (n+1) ↦ fun _ : Phase n × ℝ ↦ slsNoise (fun _ ↦ 1) 2 1 1 1 j))) z := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 单位参数实际SLS场与噪声方向的点态Lie张成目标；不含几何遍历性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 单位参数、常非零独立噪声；只陈述实际Lie张成，不将其直接称为几何遍历定理。
- 覆盖缺口：单位参数实际SLS场与噪声方向的点态Lie张成目标；不含几何遍历性。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页378–379。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.slsHormander`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.5-SLSConservation

印刷页 358 / PDF页 379。

### 1. 原文陈述

> The deterministic part preserves volume and $`U(q)+\mu\xi^2/2`$, and the full dynamics preserves the extended canonical measure.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem slsDeterministic_stationary (invm : Vec n) (U : Vec n → ℝ) (β Q : ℝ)
    (hp : thermostatParameters invm β Q) (hU : ContDiff ℝ 2 U) :
    textbookLiouvilleStationary (slsDeterministic invm U Q) (nhWeight invm U β Q) := by
  sorry
theorem slsDeterministic_divergence (invm : Vec n) (U : Vec n → ℝ) (Q : ℝ)
    (hU : ContDiff ℝ 2 U) (z : Phase n × ℝ) :
    textbookDivergence (slsDeterministic invm U Q) z = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 确定性SLS子场的局部驻定及零散度目标；完整SDE概率不变、独立第一积分未另证。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 完整权重含p高斯项，确定性p固定；只保留驻定及零散度，完整SDE概率不变和离散迭代收敛列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页379。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.slsDeterministic_stationary`：未证；缺大型理论
- `MD.Ch08.slsDeterministic_divergence`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.5-SLSLeapfrog

印刷页 358–359 / PDF页 379–380。

### 1. 原文陈述

> $`q=q_0+\eta M^{-1}p`$; $`\dot\eta=\xi`$, $`\dot\xi=-\partial_\eta U(q_0+\eta M^{-1}p)`$. Leapfrog: $`\xi_{1/2}=\xi-h(M^{-1}p)\cdot\nabla U(q)/(2\mu)`$, $`q'=q+h\xi_{1/2}M^{-1}p`$, $`\xi'=\xi_{1/2}-h(M^{-1}p)\cdot\nabla U(q')/(2\mu)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def slsBathKick (invm : Vec n) (U : Vec n → ℝ) (Q h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (z.1, z.2-h*dot (fun i ↦ invm i*z.1.2 i) (gradient U z.1.1)/Q)
def slsDriftStep (invm : Vec n) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((fun i ↦ z.1.1 i+h*z.2*invm i*z.1.2 i,z.1.2),z.2)
def slsLeapfrog (invm : Vec n) (U : Vec n → ℝ) (Q h : ℝ) : Phase n × ℝ → Phase n × ℝ :=
  slsBathKick invm U Q (h/2) ∘ slsDriftStep invm h ∘ slsBathKick invm U Q (h/2)
def slsCoordinateField (i : Fin n) (invm : Vec n) (U : Vec n → ℝ) (Q : ℝ)
    (z : Phase n × ℝ) : Phase n × ℝ :=
  ((Pi.single i (z.2*invm i*z.1.2 i),0), -invm i*z.1.2 i*gradient U z.1.1 i/Q)

/-- 原印η约化方程，ξ导数未含μ⁻¹；保留原书字面式。 -/
def slsReducedPrinted (invm : Vec n) (U : Vec n → ℝ) (q0 p : Vec n)
    (z : ℝ × ℝ) : ℝ × ℝ :=
  (z.2, -deriv (fun η : ℝ ↦ U (q0+η • (fun i ↦ invm i*p i))) z.1)

/-- 修正版：恢复热浴质量因子1/Q，对应(8.36)的η方向导数。 -/
def slsReduced_corrected (invm : Vec n) (U : Vec n → ℝ) (q0 p : Vec n)
    (Q : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  (z.2, -deriv (fun η : ℝ ↦ U (q0+η • (fun i ↦ invm i*p i))) z.1/Q)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原有半kick–drift–半kick与坐标场定义，另列原印η约化场和恢复1/Q的修正版；体积保持、误差阶及η变换推导未证明。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [ERRATUM?] 原页379的η约化式确实印为$`\dot\xi=-\partial_\eta U`$，漏写了同页(8.36)及下一页kick公式中的$`\mu^{-1}`$；Printed版逐字保留，`_corrected`版单独恢复$`1/Q`$。
- 本条仅定义半kick–drift–半kick、逐坐标场及两种约化场；OU耦合、体积保持、二阶不变分布误差、精确求积与坐标变换定理均未形式化。
- [EXTRA] 物理域与总化导数/除法的区别见context_notation；这些限制不是现有def的Lean参数前提。
- [EXTRA] 物理解释另需$`Q=\mu\gt 0`$、各$`invm_i\gt 0`$及U可微；现有def不强制这些资格。
- 覆盖缺口：原有半kick–drift–半kick与坐标场定义，另列原印η约化场和恢复1/Q的修正版；体积保持、误差阶及η变换推导未证明。
- 覆盖缺口：本条仅定义半kick–drift–半kick、逐坐标场及两种约化场；OU耦合、体积保持、二阶不变分布误差、精确求积与坐标变换定理均未形式化。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：NEEDS_HUMAN；六个def逐一审查均通过：slsBathKick、slsDriftStep、slsLeapfrog、slsCoordinateField对应原页算法，p始终固定；slsReducedPrinted忠实保留原印漏因子式，slsReduced_corrected恢复1/Q，符合(8.36)的方向导数。物理解释以$`Q\gt 0`$、正对角逆质量及相关可微性为域，def本身为全域总函数，无物理域或误差结论的量词断言。原印版忠实性PASS、修正版合理性PASS、算法定义PASS；条目总体NEEDS_HUMAN仅因原书$`\mu^{-1}`$遗漏待人工确认，不是这些Lean定义FAIL。
原文版：Printed忠实性PASS；一般μ下约化式漏$`\mu^{-1}`$待导师。
修正版：算法定义及恢复1/Q的_corrected网站PASS。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：[ERRATUM?][SOURCE_MISSING_MU_IN_REDUCTION] 原页η约化式缺$`\mu^{-1}`$，和(8.36)及两次kick不一致。原文及statement_latex保持不动，勘误须人工确认。；[DOMAIN_CLARIFICATION] $`Q\gt 0`$、正质量及可微性只是物理解释域说明，没有作为Lean def的前提；不把总函数误读为所有参数上的经典动力学定理。；已目视核对原页PDF379：η约化式确实漏$`\mu^{-1}`$，一般μ下应为$`\dot\xi=-\mu^{-1}\partial_\eta U`$；原印与Printed保留，_corrected恢复1/Q。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页379–380。

### 7. 状态与证明位置

- `MD.Ch08.slsBathKick`：定义
- `MD.Ch08.slsDriftStep`：定义
- `MD.Ch08.slsLeapfrog`：定义
- `MD.Ch08.slsCoordinateField`：定义
- `MD.Ch08.slsReducedPrinted`：定义
- `MD.Ch08.slsReduced_corrected`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.5-SLSDoubleWell

印刷页 359 / PDF页 380。

### 1. 原文陈述

> The one-dimensional example has $`U(q)=(q^2-1)^2`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def slsDoubleWell (q : ℝ) : ℝ := (q^2-1)^2
theorem slsDoubleWell_nonneg (q : ℝ) : 0 ≤ slsDoubleWell q := sq_nonneg _
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 一维双阱势定义与非负性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 保留试验中的数学势函数；轨迹、直方图和采样优劣是经验观测，另列排除。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页380。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.slsDoubleWell`：定义
- `MD.Ch08.slsDoubleWell_nonneg`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6-IsokineticField

印刷页 361–362 / PDF页 382–383。

### 1. 原文陈述

> $`\dot q=M^{-1}p`$, $`\dot p=F(q)-[p^{\mathsf T}M^{-1}F(q)/(p^{\mathsf T}M^{-1}p)]p`$; $`K(p)=p^{\mathsf T}M^{-1}p`$ is constant.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def isoMultiplier (invm p F : Vec n) : ℝ :=
  (∑ i, invm i*p i*F i)/kineticTwice invm p
def isoField (invm : Vec n) (F : Vec n → Vec n) (z : Phase n) : Phase n :=
  (fun i ↦ invm i*z.2 i, fun i ↦ F z.1 i-isoMultiplier invm z.2 (F z.1)*z.2 i)
theorem isoKinetic_balance (invm p F : Vec n) (hK : kineticTwice invm p ≠ 0) :
    (∑ i, invm i*p i*(F i-isoMultiplier invm p F*p i)) = 0 := by
  simp only [mul_sub, Finset.sum_sub_distrib]
  have hsum : (∑ i, invm i*p i*(isoMultiplier invm p F*p i)) =
      isoMultiplier invm p F*kineticTwice invm p := by
    simp only [kineticTwice, Finset.mul_sum]
    apply Finset.sum_congr rfl; intro i hi; ring
  rw [hsum, isoMultiplier, div_mul_cancel₀ _ hK, sub_self]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 无约束向量场与瞬时动能导数的代数消去；沿解的完整第一积分列缺口。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 正质量、$`K\gt 0`$作为物理有效域；本条实际证明瞬时动能平衡，不将之扩大为全局解存在性。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页382–383。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.isoMultiplier`：定义
- `MD.Ch08.isoField`：定义
- `MD.Ch08.isoKinetic_balance`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6-IsokineticProjector

印刷页 362 / PDF页 383。

### 1. 原文陈述

> $`H=p(p^{\mathsf T}M^{-1}p)^{-1}p^{\mathsf T}M^{-1}`$; $`H^2=H`$, $`Hp=p`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def isoProjection (invm p : Vec n) (v : Vec n) : Vec n :=
  fun i ↦ p i*((∑ j, invm j*p j*v j)/kineticTwice invm p)
theorem isoProjection_self (invm p : Vec n) (hK : kineticTwice invm p ≠ 0) :
    isoProjection invm p p = p := by
  have hs : (∑ j, invm j*p j*p j) = kineticTwice invm p := by
    simp only [kineticTwice]; apply Finset.sum_congr rfl; intro i hi; ring
  ext i; simp [isoProjection, hs, hK]
theorem isoProjection_idempotent (invm p : Vec n) (hK : kineticTwice invm p ≠ 0)
    (v : Vec n) : isoProjection invm p (isoProjection invm p v) = isoProjection invm p v := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际投影定义、固定p及幂等性目标；完整像空间刻画未覆盖。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 分母K非零；范围为span(p)的完整线性映射子空间等式列覆盖缺口。
- 覆盖缺口：实际投影定义、固定p及幂等性目标；完整像空间刻画未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页383。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.isoProjection`：定义
- `MD.Ch08.isoProjection_self`：已证
- `MD.Ch08.isoProjection_idempotent`：未证；时间盒止

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6-IsokineticDivergencePrinted

印刷页 362–363 / PDF页 383–384。

### 1. 原文陈述

> $`\rho=e^{-w(q,p)}\Phi(K(p))`$; $`\operatorname{div}f_{iso}=(N_c-1)p^{\mathsf T}M^{-1}F/(p^{\mathsf T}M^{-1}p)`$, $`w=(N_c-1)U/K`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def isoAnsatz (w : Phase n → ℝ) (Φ : ℝ → ℝ) (invm : Vec n) (z : Phase n) : ℝ :=
  Real.exp (-w z)*Φ (kineticTwice invm z.2)
theorem isoDivergencePrinted (invm : Vec n) (F : Vec n → Vec n)
    (hF : ContDiff ℝ 1 F) (z : Phase n) (hK : kineticTwice invm z.2 ≠ 0) :
    textbookDivergence (isoField invm F) z = ((n:ℝ)-1)*isoMultiplier invm z.2 (F z.1) := by
  sorry
theorem isoDivergence_corrected (invm : Vec n) (F : Vec n → Vec n)
    (hF : ContDiff ℝ 1 F) (z : Phase n) (hK : kineticTwice invm z.2 ≠ 0) :
    textbookDivergence (isoField invm F) z = -((n:ℝ)-1)*isoMultiplier invm z.2 (F z.1) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 一般光滑力的原印/符号修正散度目标及权重ansatz；w方程和概率不变另列缺口。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- Φ为正光滑非零函数时称权重；使用$`K\ne0`$域上的实际散度。
- 已目视核对原页PDF383–384：散度与$`\nabla w\cdot f`$等式须同时改负号，$`w=(n-1)U/K`$的正号保留。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；原印散度正号有误。
修正版：原送审负号_corrected签名PASS；w本身保留正号。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF383–384：$`\dot p=F-\lambda p`$的散度应为$`-(N_c-1)\lambda`$，所印正号与后续$`w=(N_c-1)U/K`$也冲突。；PDF383确实印正号$`\operatorname{div}f=(N_c-1)\lambda`$，PDF384随后仍用正号的$`\nabla w\cdot f`$等式并给$`w=(N_c-1)U/K`$；原文逐字内容应保留。；已目视核对原页PDF383–384：散度与$`\nabla w\cdot f`$等式须同时改负号，$`w=(n-1)U/K`$的正号保留。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页383–384。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.isoAnsatz`：定义
- `MD.Ch08.isoDivergencePrinted`：未证；原书疑误不证
- `MD.Ch08.isoDivergence_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6-IsokineticGibbsShell

印刷页 363 / PDF页 384。

### 1. 原文陈述

> $`\rho=Z^{-1}\exp(-(N_c-1)U/K)\delta[K-K_0]`$; $`K_0=\beta^{-1}(N_c-1)`$ gives the configurational Gibbs distribution.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def isokineticShell (invm : Vec n) (K0 : ℝ) : Set (Phase n) := {z | kineticTwice invm z.2=K0}
def isoShellWeight (U : Vec n → ℝ) (invm : Vec n) (z : Phase n) : ℝ :=
  Real.exp (-((n:ℝ)-1)*U z.1/kineticTwice invm z.2)
theorem isoShell_gibbsFactor (U : Vec n → ℝ) (invm : Vec n) (β : ℝ)
    (hn : 1 < n) (hβ : 0 < β) (z : Phase n)
    (hz : z ∈ isokineticShell invm (((n:ℝ)-1)/β)) :
    isoShellWeight U invm z = Real.exp (-β*U z.1) := by
  have hnR : (1 : ℝ) < (n : ℝ) := by exact_mod_cast hn
  have hn' : (n:ℝ)-1 ≠ 0 := ne_of_gt (sub_pos.mpr hnR)
  change kineticTwice invm z.2 = ((n:ℝ)-1)/β at hz
  unfold isoShellWeight
  rw [hz]
  congr 1
  field_simp [hn', ne_of_gt hβ]
  <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 动能壳与Gibbs因子的逐点关系；不声称完整曲面概率测度定理。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- δ是曲面测度的广义记号，未把Dirac分布写成Lebesgue密度；本条只证明壳面上构型权重化简，曲面测度归一/边缘分布不变性列覆盖缺口。
- 覆盖缺口：动能壳与Gibbs因子的逐点关系；不声称完整曲面概率测度定理。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页384。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.isokineticShell`：定义
- `MD.Ch08.isoShellWeight`：定义
- `MD.Ch08.isoShell_gibbsFactor`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.1-StochasticIsokinetic

印刷页 364–365 / PDF页 385–386。

### 1. 原文陈述

> $`dq=p\,dt`$, $`dp=(F-\lambda p)dt`$, $`d\xi_1=(-\lambda\xi_1-\xi_2\xi_1)dt`$, $`d\xi_2=\mu_2^{-1}(\mu_1\xi_1^2-k_B T)dt-\gamma\xi_2\,dt+\sigma\,dW`$; $`p^2+\mu_1\xi_1^2/2=k_B T`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinConstraint (Q1 : ℝ) (z : Vec 4) : ℝ := z 1^2+Q1*z 2^2/2
def sinMultiplier (Q1 : ℝ) (F : ℝ → ℝ) (z : Vec 4) : ℝ :=
  (z 1*F (z 0)-Q1*z 2^2*z 3/2)/sinConstraint Q1 z
def sinDrift (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ) (z : Vec 4) : Vec 4 :=
  let lam := sinMultiplier Q1 F z
  ![z 1, F (z 0)-lam*z 1, -lam*z 2-z 3*z 2, (Q1*z 2^2-θ)/Q2-γ*z 3]
def isSINSolution (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Vec 4) (x0 : Vec 4) : Prop :=
  0 < Q1 ∧ 0 < Q2 ∧ 0 < θ ∧ 0 < γ ∧ sinConstraint Q1 x0=θ ∧
  additiveSDE P 1 W X x0 (sinDrift Q1 Q2 θ γ F)
    (fun _ ↦ ![0,0,0,Real.sqrt (2*γ*θ/Q2)])
theorem sinConstraint_balance (Q1 Q2 θ γ : ℝ) (F : ℝ → ℝ) (z : Vec 4)
    (hK : sinConstraint Q1 z ≠ 0) :
    2*z 1*(sinDrift Q1 Q2 θ γ F z) 1+Q1*z 2*(sinDrift Q1 Q2 θ γ F z) 2=0 := by
  have hden : 2*z 1^2+Q1*z 2^2 ≠ 0 := by
    intro h
    apply hK
    dsimp [sinConstraint]
    linarith
  simp [sinDrift, sinMultiplier, sinConstraint]
  field_simp [hden]
  <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际SIN漂移、正参数Wiener积分解和瞬时约束平衡；约束沿全路径保持未另证。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 热浴变量$`\xi_1,\xi_2\in\mathbb R`$，各质量、温度、摩擦正；随机噪声只在$`\xi_2`$；约束正值排除奇点。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页385–386。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinConstraint`：定义
- `MD.Ch08.sinMultiplier`：定义
- `MD.Ch08.sinDrift`：定义
- `MD.Ch08.isSINSolution`：定义
- `MD.Ch08.sinConstraint_balance`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.1-SINWeightPrinted

印刷页 365 / PDF页 386。

### 1. 原文陈述

> $`w=(U+\xi_2^2/2)/(p^2+\mu_1\xi_1^2/2)`$; integration over the isokinetic surface gives the Gibbs configurational density.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinWeightPrinted (U : ℝ → ℝ) (Q1 : ℝ) (z : Vec 4) : ℝ :=
  Real.exp (-(U (z 0)+z 3^2/2)/sinConstraint Q1 z)
def sinWeight_corrected (U : ℝ → ℝ) (Q1 Q2 : ℝ) (z : Vec 4) : ℝ :=
  Real.exp (-(U (z 0)+Q2*z 3^2/2)/sinConstraint Q1 z)
theorem sinWeight_stationary_corrected (U : ℝ → ℝ) (Q1 Q2 θ : ℝ)
    (hU : ContDiff ℝ 2 U) (hQ1 : 0 < Q1) (hQ2 : 0 < Q2) (hθ : 0 < θ)
    (z : Vec 4) (hz : sinConstraint Q1 z=θ) :
    textbookDivergence
      (fun x ↦ sinWeight_corrected U Q1 Q2 x • sinDrift Q1 Q2 θ 0 (fun q ↦ -deriv U q) x) z = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印及补热浴质量的权重、正约束面局部驻定目标；曲面边缘分布及遍历性未覆盖。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 仅证明正约束面处的实际通量散度陈述；曲面概率测度、边缘分布和遍历性列缺口。
- 覆盖缺口：原印及补热浴质量的权重、正约束面局部驻定目标；曲面边缘分布及遍历性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；原印二次项缺$`\mu_2`$。
修正版：原送审补Q2的权重与壳面局部驻定签名PASS，非曲面测度不变性。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF386：$`\xi_2`$方程含$`\mu_2^{-1}`$，而w的$`\xi_2`$二次项缺$`\mu_2`$；一般$`\mu_2`$时应为$`\mu_2\xi_2^2/2`$。；PDF386确实印$`w=(U+\xi_2^2/2)/(p^2+\mu_1\xi_1^2/2)`$，未含$`\mu_2`$；statement_latex忠实，不能静默把原印式改成修正式。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页386。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinWeightPrinted`：定义
- `MD.Ch08.sinWeight_corrected`：定义
- `MD.Ch08.sinWeight_stationary_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.2-SINHarmonic

印刷页 366 / PDF页 387。

### 1. 原文陈述

> For $`\mu_1=\mu_2=1`$, $`dq=p\,dt`$, $`dp=(-q-\lambda p)dt`$, $`d\xi_1=(-\lambda\xi_1-\xi_2\xi_1)dt`$, $`d\xi_2=(\xi_1^2-k_B T-\gamma\xi_2)dt+\sigma\,dW`$, $`\lambda=(-qp-\xi_2\xi_1^2/2)/(p^2+\xi_1^2/2)`$, $`\sigma=\sqrt{2\gamma k_B T}`$. (8.45)–(8.47).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinHarmonicF (θ γ : ℝ) : Vec 4 → Vec 4 := sinDrift 1 1 θ γ (fun q ↦ -q)
def sinHarmonicG (θ γ : ℝ) : Vec 4 := ![0,0,0,Real.sqrt (2*γ*θ)]
def isSINHarmonicSolution (θ γ : ℝ) (P : Measure Ω) (W : ℝ → Ω → Vec 1)
    (X : ℝ → Ω → Vec 4) (x0 : Vec 4) : Prop :=
  isSINSolution 1 1 θ γ (fun q ↦ -q) P W X x0
def sinExceptional (θ : ℝ) : Set (Vec 4) :=
  {z | z 0=0 ∧ z 1=0 ∧ z 2^2=2*θ}
def sinHalfCylinder (θ : ℝ) (positive : Bool) : Set (Vec 4) :=
  {z | sinConstraint 1 z=θ ∧ (if positive then 0 < z 2 else z 2 < 0)}
theorem sinHalfCylinder_disjoint (θ : ℝ) :
    Disjoint (sinHalfCylinder θ true) (sinHalfCylinder θ false) := by
  apply Set.disjoint_left.mpr
  intro z hpos hneg
  exact (not_lt_of_ge (le_of_lt hpos.2)) hneg.2
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 谐振SIN实际SDE、例外直线和半柱定义及半柱不交；不含全局遍历定理。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`\theta=k_B T\gt 0`$、$`\gamma\gt 0`$、标量Wiener由isSINSolution给全；零$`\xi_1`$面不变和两个半柱的轨道符号保持需要ODE唯一性，列覆盖缺口。
- 覆盖缺口：谐振SIN实际SDE、例外直线和半柱定义及半柱不交；不含全局遍历定理。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页387。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinHarmonicF`：定义
- `MD.Ch08.sinHarmonicG`：定义
- `MD.Ch08.isSINHarmonicSolution`：定义
- `MD.Ch08.sinExceptional`：定义
- `MD.Ch08.sinHalfCylinder`：定义
- `MD.Ch08.sinHalfCylinder_disjoint`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.2-SINProjectedBracketsPrinted

印刷页 367 / PDF页 388。

### 1. 原文陈述

> $`u_0=\Pi f`$, $`u_1=\Pi[f,g]`$, $`u_2=\Pi[f,[f,g]]`$, $`u_3=\Pi[f,[f,[f,g]]]`$. The displayed equations (8.48)–(8.53) give their components, with $`D=2p^2+\xi_1^2`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def bracket4 (f g : Vec 4 → Vec 4) (z : Vec 4) : Vec 4 :=
  fderiv ℝ g z (f z)-fderiv ℝ f z (g z)
def sinBracket (θ γ : ℝ) : ℕ → Vec 4 → Vec 4
  | 0 => sinHarmonicF θ γ
  | 1 => bracket4 (sinHarmonicF θ γ) (fun _ ↦ sinHarmonicG θ γ)
  | k+2 => bracket4 (sinHarmonicF θ γ) (sinBracket θ γ (k+1))
def projectFirstThree (z : Vec 4) : Vec 3 := ![z 0,z 1,z 2]
def sinD (z : Vec 4) : ℝ := 2*z 1^2+z 2^2
def sinU0Printed (z : Vec 4) : Vec 3 :=
  ![z 1,z 2^2*(-z 0+z 1*z 3)/sinD z,-2*z 2*z 1*(-z 0+z 1*z 3)/sinD z]
def sinU1Printed (z : Vec 4) : Vec 3 := sinU0Printed z
def sinU2Printed (σ : ℝ) (z : Vec 4) : Vec 3 :=
  ![0,-σ*z 2^2*z 1/sinD z,2*σ*z 2*z 1^2/sinD z]
def sinU1DerivativePrinted (σ : ℝ) (z : Vec 4) : Vec 3 :=
  let d := fderiv ℝ (sinMultiplier 1 (fun q ↦ -q)) z (Pi.single 3 1)
  ![0,σ*z 1*d,z 2*(1+d)]
def sinProjected_corrected (θ γ : ℝ) (j : Fin 4) (z : Vec 4) : Vec 3 :=
  projectFirstThree (sinBracket θ γ j z)
def sinU2LongPrinted (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  let a := (2*γ*z 1^3+γ*z 2^2*z 1-z 2^2*z 0)/(sinD z)^2
  ![σ*z 2^2*z 1/sinD z,-σ*a,2*σ*z 2*z 1*a]
theorem sinU2Long_at_p0 (σ γ : ℝ) (z : Vec 4) (hp : z 1=0) :
    sinU2LongPrinted σ γ z = ![0,σ*z 2^2*z 0/(sinD z)^2,0] := by
  ext i; fin_cases i <;> simp [sinU2LongPrinted,hp] <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印(8.48)–(8.53)的主要分量与实际交换子定义，(8.49)导数写法保存在逐字原页；未把错标指标视为已证恒等式。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 总化分式只在$`\theta\gt 0`$的约束面$`D=2\theta\gt 0`$使用；实际交换子先在四维完整计算再投影。
- 本条记录原印显式式和真实微分定义；显式式与真实二/三重交换子的等式尚未证明，列覆盖缺口。
- 已目视核对原页PDF388：(8.49)–(8.53)及“any pair”/平行论据需导师核查；修正版仅以完整四维真实括号再投影为准，不把改下标当作长式校正。
- 覆盖缺口：本条记录原印显式式和真实微分定义；显式式与真实二/三重交换子的等式尚未证明，列覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed各表达式忠实性PASS；(8.49)–(8.53)疑误待导师。
修正版：原送审完整四维真实括号再投影定义PASS，长式未声称等于真实括号。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF388：(8.50)的$`u_1`$公式实际重写$`u_0`$，(8.51)的$`u_2`$公式实际为首交换子；(8.49)第三分量似缺共同σ。原印与真实迭代交换子独立保留。；PDF388逐式核对：(8.48)为u0；(8.49)$`\xi_1`$分量前确无共同σ；(8.50)印u1却重复u0展开式；(8.51)印u2却是首交换子的投影。(8.52)的p分量确为$`-\sigma a`$而非$`-\sigma\xi_1^2a`$，故Lean忠实保留了原印式，不应替书改系数。；已目视核对原页PDF388：(8.49)–(8.53)及“any pair”/平行论据需导师核查；修正版仅以完整四维真实括号再投影为准，不把改下标当作长式校正。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页388。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.bracket4`：定义
- `MD.Ch08.sinBracket`：定义
- `MD.Ch08.projectFirstThree`：定义
- `MD.Ch08.sinD`：定义
- `MD.Ch08.sinU0Printed`：定义
- `MD.Ch08.sinU1Printed`：定义
- `MD.Ch08.sinU2Printed`：定义
- `MD.Ch08.sinU1DerivativePrinted`：定义
- `MD.Ch08.sinProjected_corrected`：定义
- `MD.Ch08.sinU2LongPrinted`：定义
- `MD.Ch08.sinU2Long_at_p0`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.2-SINThirdBracketPrinted

印刷页 368 / PDF页 389。

### 1. 原文陈述

> The third projected commutator is displayed in (8.54), with polynomial $`\eta`$ in (8.55); its $`p=0`$ specialization is printed as $`u_3=-2\sigma q\partial_q-\sigma q(-\gamma+\xi_2)\partial_p`$ in (8.56).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def sinEtaPrinted (γ : ℝ) (z : Vec 4) : ℝ :=
  4*z 1^5*γ^2-8*z 1^5*z 2^2-4*z 2^2*z 1^3+4*z 1^3*γ^2*z 2^2-4*z 1^3*z 2^4-
  2*γ*z 2^2*z 1^2*z 0+4*z 1^2*z 0*z 3*z 2^2-4*z 2^2*z 0^2*z 1-
  2*z 2^4*z 1+z 1*γ^2*z 2^4-z 0*γ*z 2^4+z 2^4*z 3*z 0
def sinU3Printed (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  ![σ*(2*γ*z 1^3-4*z 1^3*z 3+4*z 1^2*z 0+z 2^2*z 1*z 3+γ*z 2^2*z 1-2*z 2^2*z 0)/(sinD z)^2,
    -σ*z 2^2*sinEtaPrinted γ z/(sinD z)^3,2*σ*z 2*z 1*sinEtaPrinted γ z/(sinD z)^3]
def sinU3ZeroPrinted (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  ![-2*σ*z 0,-σ*z 0*(-γ+z 3),0]
def sinU3Zero_corrected (σ γ : ℝ) (z : Vec 4) : Vec 3 :=
  ![-2*σ*z 0/z 2^2,-σ*z 0*(-γ+z 3),0]
theorem sinU3Zero_specialize (σ γ : ℝ) (z : Vec 4) (hp : z 1=0) (hξ : z 2 ≠ 0) :
    sinU3Printed σ γ z = sinU3Zero_corrected σ γ z := by
  ext i; fin_cases i <;> simp [sinU3Printed,sinU3Zero_corrected,sinEtaPrinted,sinD,hp]
    <;> field_simp [hξ] <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印三重交换子候选及$`p=0`$内部代数核对；真实三重交换子等式列覆盖缺口。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`\xi_1\ne0`$用于分式化简；此处只核对原印(8.54)与(8.56)内部的代数关系，不声称(8.54)已被确认为实际三重交换子。
- `_corrected`只修正(8.54)在$`p=0`$的内部代数特化，不能据此声称Printed长式等于真实三重括号。
- 覆盖缺口：$`\xi_1\ne0`$用于分式化简；此处只核对原印(8.54)与(8.56)内部的代数关系，不声称(8.54)已被确认为实际三重交换子。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；(8.54)/(8.56)内部不一致。
修正版：原送审_corrected及specialize在内部代数特化意义下PASS，非真实三重括号校正。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF389：(8.54)q分量代$`p=0`$得到$`-2\sigma q/\xi_1^2`$，(8.56)遗漏$`\xi_1^2`$分母；原印多项式的其他系数仍待独立微分核对。；PDF389的(8.54)q分量分母为$`D^2`$，(8.55)的13项多项式逐项与sinEtaPrinted一致；(8.56)原印q分量为$`-2\sigma q`$，确无$`\xi_1^2`$分母。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页389。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinEtaPrinted`：定义
- `MD.Ch08.sinU3Printed`：定义
- `MD.Ch08.sinU3ZeroPrinted`：定义
- `MD.Ch08.sinU3Zero_corrected`：定义
- `MD.Ch08.sinU3Zero_specialize`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.6.2-SINBracketRank

印刷页 366–368 / PDF页 387–389。

### 1. 原文陈述

> For $`\theta\gt 0`$, $`\gamma\gt 0`$, on $`p^2+\xi_1^2/2=\theta`$ with $`\xi_1\ne0`$ and outside $`M_0`$, the fields $`f,g,[f,g],[f,[f,g]],[f,[f,[f,g]]]`$ span the three-dimensional tangent space of the isokinetic cylinder.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem sinBracket_tangentSpan (θ γ : ℝ) (hθ : 0 < θ) (hγ : 0 < γ)
    (z : Vec 4) (hz : sinConstraint 1 z=θ) (hξ : z 2 ≠ 0)
    (hout : z ∉ sinExceptional θ) :
    Submodule.span ℝ ({sinHarmonicG θ γ} ∪
      Set.range (fun j : Fin 4 ↦ sinBracket θ γ j z)) =
      LinearMap.ker (fderiv ℝ (sinConstraint 1) z).toLinearMap := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 例外直线外的有限括号张成目标；非完整遍历性定理。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- θ,γ正，$`\xi_1\ne0`$且在正约束面；仅声明有限向量族张成实际切空间，Hörmander理论推出平滑密度或遍历性未覆盖。
- 覆盖缺口：θ,γ正，$`\xi_1\ne0`$且在正约束面；仅声明有限向量族张成实际切空间，Hörmander理论推出平滑密度或遍历性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：PDF387–389列出的五个场和M0吻合。原页先说明运动限制在$`\xi_1\gt 0`$或$`\xi_1\lt 0`$半空间；statement_latex应显式带上这一域，避免把“除M0外”误读为包含$`\xi_1=0`$的整个圆柱。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页387–389。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.sinBracket_tangentSpan`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

