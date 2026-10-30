[上一部分](part01.zh-CN.md) / [目录](../../CH08_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

## MD-8.2.2-NHChains

印刷页 339–340 / PDF页 360–361。

### 1. 原文陈述

> The Nosé–Hoover chain (8.16)–(8.21) preserves $`\rho_\beta\exp(-\beta\sum\mu_i\xi_i^2/2)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nhChainField (k : ℕ) (invm : Vec n) (U : Vec n → ℝ) (β : ℝ)
    (Q : Fin k → ℝ) (z : Phase n × (Fin k → ℝ)) : Phase n × (Fin k → ℝ) :=
  ((fun i ↦ invm i*z.1.2 i,
    fun i ↦ -gradient U z.1.1 i - (if hk : 0 < k then z.2 ⟨0,hk⟩ else 0)*z.1.2 i),
   fun j ↦ (if hj : j.val = 0 then (kineticTwice invm z.1.2-(n : ℝ)/β)/Q j
     else (Q ⟨j.val-1,by omega⟩ * z.2 ⟨j.val-1,by omega⟩ ^2 - 1/β)/Q j) -
     (if hj : j.val+1 < k then z.2 j * z.2 ⟨j.val+1,hj⟩ else 0))
theorem nhChain_stationary (k : ℕ) (hk : 0 < k) (invm : Vec n) (U : Vec n → ℝ)
    (β : ℝ) (Q : Fin k → ℝ) (hβ : 0 < β) (hQ : ∀ j, 0 < Q j)
    (hm : ∀ i, 0 < invm i) (hU : ContDiff ℝ 2 U) :
    textbookLiouvilleStationary (nhChainField k invm U β Q)
      (fun z ↦ Real.exp (-β*(kineticTwice invm z.1.2/2+U z.1.1+(∑ j, Q j*z.2 j^2)/2))) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 任意正链长、正对角质量且无约束的NH链场与未归一Gaussian权的局部Liouville驻定；不含一般非对角M、约束流形、唯一不变概率或遍历性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 链长$`k\gt 0`$，各热质量$`Q_j\gt 0`$、$`\beta\gt 0`$，实辅助变量；未归一Gaussian权重不声称唯一不变概率或遍历性。
- [EXTRA] $`M^{-1}=\operatorname{diag}(invm)`$，$`\forall i,invm_i\gt 0`$，$`N_d=n`$；$`U\in C^2`$。仅形式化正对角质量、无约束情形。
- 覆盖缺口：任意正链长、正对角质量且无约束的NH链场与未归一Gaussian权的局部Liouville驻定；不含一般非对角M、约束流形、唯一不变概率或遍历性。
- 覆盖缺口：链长$`k\gt 0`$，各热质量$`Q_j\gt 0`$、$`\beta\gt 0`$，实辅助变量；未归一Gaussian权重不声称唯一不变概率或遍历性。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页360–361。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.nhChainField`：定义
- `MD.Ch08.nhChain_stationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.3-ArrheniusRate

印刷页 342 / PDF页 363。

### 1. 原文陈述

> $`k\sim A e^{-\Delta E/(k_B T)}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def arrheniusRate (A ΔE kB T : ℝ) : ℝ := A*Real.exp (-ΔE/(kB*T))
theorem arrheniusRate_nonneg (A ΔE kB T : ℝ) (hA : 0 ≤ A) :
    0 ≤ arrheniusRate A ΔE kB T := mul_nonneg hA (Real.exp_pos _).le
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | Arrhenius指数速率公式定义及$`A\ge0`$时非负性；不含亚稳跃迁率渐近定理或温度单调性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`A\ge0,k_B\gt 0,T\gt 0`$为速率解释域；只定义原页模型，不声称一般能垒动力学服从此经验律。
- 覆盖缺口：Arrhenius指数速率公式定义及$`A\ge0`$时非负性；不含亚稳跃迁率渐近定理或温度单调性。
- 覆盖缺口：$`A\ge0,k_B\gt 0,T\gt 0`$为速率解释域；只定义原页模型，不声称一般能垒动力学服从此经验律。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页363。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.arrheniusRate`：定义
- `MD.Ch08.arrheniusRate_nonneg`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4-AdditiveThermostatSDE

印刷页 342–343 / PDF页 363–364。

### 1. 原文陈述

> $`dq=M^{-1}p\,dt`$; $`dp=-\nabla U\,dt-\Phi(\xi,z)-\Gamma p\,dt+\sqrt{2k_B T}M^{1/2}\Gamma^{1/2}dW`$; $`d\xi=g\,dt-\hat\Gamma\xi\,dt+\sqrt{2k_B T}\hat M^{1/2}\hat\Gamma^{1/2}d\hat W`$. All Wiener coordinates are independent.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def independentWiener (P : Measure Ω) (k : ℕ) (W : ℝ → Ω → Vec k) : Prop :=
  IsProbabilityMeasure P ∧ (∀ j, IsBrownianReal (fun t sample ↦ W t sample j) P) ∧
    iIndepFun (fun j sample ↦ fun t : ℝ ↦ W t sample j) P
def additiveSDE {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [MeasurableSpace E]
    (P : Measure Ω) (k : ℕ) (W : ℝ → Ω → Vec k)
    (X : ℝ → Ω → E) (x0 : E) (a : E → E) (B : Fin k → E) : Prop :=
  independentWiener P k W ∧ (∀ᵐ sample ∂P, Continuous (fun t ↦ X t sample)) ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  ∀ t : ℝ, 0 ≤ t →
    (∀ᵐ sample ∂P, IntervalIntegrable (fun s ↦ a (X s sample)) volume 0 t) ∧
    ∀ᵐ sample ∂P, X t sample = x0 + (∫ s in 0..t, a (X s sample)) +
      ∑ j, (W t sample j-W 0 sample j) • B j
def stochasticThermostatDrift {k : ℕ} (invm : Vec n) (U : Vec n → ℝ)
    (Φ : Phase n × Vec k → Vec n) (g : Phase n × Vec k → Vec k)
    (Γ : Matrix (Fin n) (Fin n) ℝ) (Γhat : Matrix (Fin k) (Fin k) ℝ)
    (z : Phase n × Vec k) : Phase n × Vec k :=
  ((fun i ↦ invm i*z.1.2 i, fun i ↦ -gradient U z.1.1 i-Φ z i-(Γ *ᵥ z.1.2) i),
   g z - Γhat *ᵥ z.2)
def fluctuationDissipation (M Γ B : Matrix (Fin n) (Fin n) ℝ) (β : ℝ) : Prop :=
  0 < β ∧ M.PosDef ∧ Γ.PosSemidef ∧ B*B.transpose = (2/β) • (Γ*M)

/-- 两组噪声共用一个n+k维独立Wiener过程，分块只作用于p和ξ。 -/
def thermostatBlockNoise {k : ℕ}
    (B : Matrix (Fin n) (Fin n) ℝ) (Bhat : Matrix (Fin k) (Fin k) ℝ)
    (j : Fin (n+k)) : Phase n × Vec k :=
  if hj : j.val < n then
    ((0,fun i ↦ B i ⟨j.val,hj⟩),0)
  else ((0,0),fun i ↦ Bhat i ⟨j.val-n,by omega⟩)

/-- 正对角物理质量特例的统一积分解规格；两组协方差与实际漂移使用同一质量。
不含一般非对角物理质量，也不声称由此已证明存在、唯一或不变分布。 -/
def stochasticThermostatSolution {k : ℕ} (P : Measure Ω)
    (W : ℝ → Ω → Vec (n+k)) (X : ℝ → Ω → Phase n × Vec k)
    (x0 : Phase n × Vec k) (invm : Vec n) (U : Vec n → ℝ)
    (Φ : Phase n × Vec k → Vec n) (g : Phase n × Vec k → Vec k)
    (Γ B : Matrix (Fin n) (Fin n) ℝ)
    (Mhat Γhat Bhat : Matrix (Fin k) (Fin k) ℝ) (β : ℝ) : Prop :=
  (∀ i, 0 < invm i) ∧ ContDiff ℝ 1 U ∧
  fluctuationDissipation (Matrix.diagonal (fun i ↦ (invm i)⁻¹)) Γ B β ∧
  fluctuationDissipation Mhat Γhat Bhat β ∧
  additiveSDE P (n+k) W X x0 (stochasticThermostatDrift invm U Φ g Γ Γhat)
    (thermostatBlockNoise B Bhat)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 已组装的对角物理质量、交换涨落耗散特例：同一$`n+k`$维独立Wiener、分块噪声、两组同β协方差与漂移质量已绑定。未覆盖一般非对角模型、存在唯一性或不变律。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] $`M^{-1}=\operatorname{diag}(invm)`$，所有$`invm_i\gt 0`$，$`N_c=N_d=n`$；U为$`C^1`$。$`\beta^{-1}=k_B T`$。
- [EXTRA] stochasticThermostatSolution已用同一$`n+k`$维独立Wiener过程、thermostatBlockNoise和实际漂移组装完整积分解规格。物理质量明确绑定$`\operatorname{diag}(invm^{-1})`$，热浴质量为Mhat，两组使用同β。
- [EXTRA] fluctuationDissipation要求$`\beta\gt 0`$、M正定、Γ半正定及$`BB^{\mathsf T}=(2/\beta)\Gamma M`$。实对称矩阵下由左右对称性强制$`\Gamma M=M\Gamma`$，属于明确限制后的充分相容条件。热浴同理。
- [ERRATUM?] 原印$`-\Phi`$未附$`dt`$；漂移按$`-\Phi\,dt`$解释。原印对称性条件不足以保证矩阵平方根噪声的Gibbs相容性。
- 未要求或证明确定性Φ,g部分保权；未构造矩阵平方根，未证明完整解存在、唯一、不变分布或遍历性。
- [EXTRA] additiveSDE要求几乎处处全实时间连续；每个$`t\ge0`$的X t对W在[0,t]历史可测，漂移在[0,t]几乎处处可积，且逐个t的积分方程几乎处处成立；x0固定而非随机。
- [EXTRA] 对一般矩阵的匹配应为$`BB^{\mathsf T}=(\Gamma M+M\Gamma^{\mathsf T})/\beta`$并须协方差可实现；当前采用$`BB^{\mathsf T}=(2/\beta)\Gamma M`$，在实对称条件下限制为$`\Gamma M=M\Gamma`$的充分特例，不扩充Lean模型。
- 覆盖缺口：已组装的对角物理质量、交换涨落耗散特例：同一$`n+k`$维独立Wiener、分块噪声、两组同β协方差与漂移质量已绑定。未覆盖一般非对角模型、存在唯一性或不变律。
- 覆盖缺口：未要求或证明确定性Φ,g部分保权；未构造矩阵平方根，未证明完整解存在、唯一、不变分布或遍历性。

### 6. 审计结论（含网站复审结论）

网站首轮：FAIL。
网站复审结论：NEEDS_HUMAN；independentWiener对每个Fin k坐标要求IsBrownianReal，并对整个路径随机变量iIndepFun，P为概率测度，故跨组独立性由统一$`n+k`$坐标给出。additiveSDE的对象E、固定x0、常因子B、几乎处处连续、自然噪声历史可测、$`t\ge0`$逐时可积及积分恒等式全部明确；不是存在性定理。stochasticThermostatDrift在$`(q,p,\xi)`$上恰为$`(\operatorname{diag}(invm)p,-\nabla U-\Phi-\Gamma p,g-\hat\Gamma\xi)`$，把原书缺失dt解释为漂移。thermostatBlockNoise前n列只作用p，后k列只作用ξ，q噪声为零。stochasticThermostatSolution已将该漂移、分块噪声、同一个独立W、同β两组资格及实际对角物理质量绑定，旧未组装/未绑定指控不成立。fluctuationDissipation为充分但较强的交换情形，不能冒充原印仅对称的一般模型。没有确定性保权前提，因而不能从该解谓词推出Gibbs不变性；声明本身未作此结论，故不是签名错误。原书dt和矩阵条件疑误总体保留NEEDS_HUMAN。
原文版：原印缺dt及矩阵噪声相容疑误待导师。
修正版：已组装的对角物理质量、交换涨落耗散特例网站PASS；不代表一般矩阵模型。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：[ERRATUM?] 原印(8.23)的−Φ缺dt。；[ERRATUM?] 原印矩阵对称性不足以保证实噪声及Gibbs相容；当前Lean是半正定、交换资格下的限制模型。；已目视核对原页PDF364：(8.23)的−Φ缺dt；矩阵仅对称不足以保证所印噪声与目标Gibbs协方差相容。当前模型已组装，是对角物理质量、交换涨落耗散特例。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页363–364。

### 7. 状态与证明位置

- `MD.Ch08.independentWiener`：定义
- `MD.Ch08.additiveSDE`：定义
- `MD.Ch08.stochasticThermostatDrift`：定义
- `MD.Ch08.fluctuationDissipation`：定义
- `MD.Ch08.thermostatBlockNoise`：定义
- `MD.Ch08.stochasticThermostatSolution`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4-OUStationarityPrinted

印刷页 343–344 / PDF页 364–365。

### 1. 原文陈述

> The OU momentum process with drift $`-\Gamma p`$ and noise $`\sqrt{2k_B T}M^{1/2}\Gamma^{1/2}`$ preserves $`\exp(-\beta p^{\mathsf T}M^{-1}p/2)`$. The displayed diffusion term is $`\beta^{-1}\operatorname{Tr}(\Gamma^{1/2}M^{1/2}[\beta M^{-1}pp^{\mathsf T}M^{-1}-M^{-1}]M^{1/2}\Gamma^{1/2})\bar\rho=-\text{drift}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def ouFokkerPlanck (A C : Matrix (Fin n) (Fin n) ℝ) (ρ : Vec n → ℝ) (p : Vec n) : ℝ :=
  textbookDivergence (fun x ↦ ρ x • (A *ᵥ x)) p +
    (∑ i, ∑ j, C i j * fderiv ℝ (fun x ↦ gradient ρ x j) p (Pi.single i 1))/2
theorem ouStationarity_corrected (M Γ B : Matrix (Fin n) (Fin n) ℝ) (β : ℝ)
    (hf : fluctuationDissipation M Γ B β) :
    ∀ p, ouFokkerPlanck Γ (B*B.transpose)
      (fun x ↦ Real.exp (-β * dot x (M⁻¹ *ᵥ x)/2)) p = 0 := by
  sorry
theorem diffusionPrinted (β : ℝ) (hβ : 0 < β) : (1/β)*(-1) = -(1 : ℝ) := by
  sorry
theorem diffusionPrinted_counterexample : ¬ ((1/(2:ℝ))*(-1) = -(1:ℝ)) := by norm_num
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 协方差匹配的完整OU局部驻定目标；所印扩散抵消的标量特例及数值反例。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- Printed保留显示抵消式的$`M=\Gamma=1,p=0`$标量特例；修正版为完整匹配协方差后的OU驻定式；不将转移分布存在性作为已证。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：diffusionPrinted忠实性PASS；原印β因子和矩阵相容性待导师。
修正版：原送审ouStationarity_corrected及标量反例PASS；仅局部算子恒零。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF364–365：一般M与Γ仅对称不足保证原噪声协方差匹配，应加$`\Gamma M=M\Gamma`$或直接给涨落耗散关系；PDF365将Hessian的β提取后仍留$`\beta^{-1}`$，标量$`\beta=2`$,$`p=0`$已反例。；[ERRATUM?]保留原所印等式及$`\beta=2`$反例；修正版的$`BB^{\mathsf T}=(2/\beta)\Gamma M`$为明确额外资格，在对称情形蕴含交换性。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页364–365。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.ouFokkerPlanck`：定义
- `MD.Ch08.ouStationarity_corrected`：未证；缺大型理论
- `MD.Ch08.diffusionPrinted`：未证；原书疑误不证
- `MD.Ch08.diffusionPrinted_counterexample`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4-LiftedThermostat

印刷页 344–345 / PDF页 365–366。

### 1. 原文陈述

> $`dz=F(z)\,dt+\xi G(z)\,dt`$, $`d\xi=g(z)\,dt-\gamma\xi\,dt+\sigma\,dW`$. The lifted fields are $`b_0=(F+\xi G,g-\gamma\xi)`$, $`b_1=(0,\sigma)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def liftedThermostat (F G : Vec n → Vec n) (g : Vec n → ℝ) (γ σ : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Vec n × ℝ)
    (x0 : Vec n × ℝ) : Prop :=
  additiveSDE P 1 W X x0 (textbookThermostatDrift F G g γ)
    (fun _ ↦ (0, σ))
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 一般单热浴提升场的实际加性Wiener积分解规格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 真实Wiener、适应性和可积性由additiveSDE给出；$`\sigma\ne0`$在Hörmander结论中单列。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页365–366。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.liftedThermostat`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4-Proposition82

印刷页 344–345 / PDF页 365–366。

### 1. 原文陈述

> If the Lie algebra generated by $`F`$ and $`G`$ in (8.25) spans $`\mathbb R^m`$, then the Hörmander condition holds for (8.25)–(8.26).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem proposition82Printed (F G : Vec n → Vec n) (g : Vec n → ℝ) (γ σ : ℝ)
    (hF : ContDiff ℝ ∞ F) (hG : ContDiff ℝ ∞ G) (hg : ContDiff ℝ ∞ g)
    (w : Vec n × ℝ) (hspan : textbookHormanderAt {F,G} w.1) :
    textbookHormanderAt (textbookThermostatSeed F G g γ σ) w := by
  sorry
theorem proposition82_corrected (F G : Vec n → Vec n) (g : Vec n → ℝ) (γ σ : ℝ)
    (hF : ContDiff ℝ ∞ F) (hG : ContDiff ℝ ∞ G) (hg : ContDiff ℝ ∞ g)
    (hσ : σ ≠ 0) (w : Vec n × ℝ) (hspan : textbookHormanderAt {F,G} w.1) :
    textbookHormanderAt (textbookThermostatSeed F G g γ σ) w := by
  exact textbookThermostatHormanderLift F G g γ σ hF hG hg hσ w hspan
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 所印及补$`\sigma\ne0`$后的真实Lie括号张成命题；不含解存在、平滑转移核或遍历性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- Printed版保留未要求非零σ的原文强度，不证明；修正版完整使用真实迭代Lie括号张成定义。
- 覆盖缺口：所印及补$`\sigma\ne0`$后的真实Lie括号张成命题；不含解存在、平滑转移核或遍历性。
- 覆盖缺口：Printed版保留未要求非零σ的原文强度，不证明；修正版完整使用真实迭代Lie括号张成定义。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；$`\sigma=0`$使原结论失效。
修正版：原送审$`C^\infty`$且$`\sigma\ne0`$的_corrected签名PASS。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF365–366：证明除以σ，定理需$`\sigma\ne0`$；光滑向量场资格明确补足。；[ERRATUM?]$`\sigma=0`$反例；Printed仅作忠实记录，corrected在$`\sigma\ne0`$下通过。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页365–366。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.proposition82Printed`：未证；原书疑误不证
- `MD.Ch08.proposition82_corrected`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-NHL

印刷页 345–346 / PDF页 366–367。

### 1. 原文陈述

> $`dq=M^{-1}p\,dt`$, $`dp=-\nabla U\,dt-\xi p\,dt`$, $`d\xi=\mu^{-1}[p^{\mathsf T}M^{-1}p-N_d k_B T]dt-\gamma\xi\,dt+\sqrt{2k_B T\gamma\mu^{-1}}dW`$. Quadratic specialization: $`U=q^{\mathsf T}Aq/2`$, $`M=I`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nhlDrift (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (nhField invm U β Q z).1 |> fun physical ↦ (physical, (nhField invm U β Q z).2-γ*z.2)
def isNHLSolution (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → Phase n × ℝ)
    (x0 : Phase n × ℝ) : Prop :=
  thermostatParameters invm β Q ∧ 0 < γ ∧
    additiveSDE P 1 W X x0 (nhlDrift invm U β Q γ)
      (fun _ ↦ (0, Real.sqrt (2*γ/(β*Q))))
def harmonicPotential (A : Matrix (Fin n) (Fin n) ℝ) (q : Vec n) : ℝ := dot q (A *ᵥ q)/2
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 仅正对角质量、无约束$`N_d=n`$的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] $`M^{-1}=\operatorname{diag}(invm)`$，$`N_d=n`$；$`invm_i,\beta,Q,\gamma`$均正；$`\beta^{-1}=k_B T`$，$`Q=\mu`$。一般非对角物理质量未覆盖。
- isNHLSolution采用一个实Wiener坐标，噪声只作用ξ，幅度$`\sqrt{2\gamma/(\beta Q)}`$；解的可测、连续、可积与固定初值规格由additiveSDE给出。
- harmonicPotential对任意实方阵A定义$`q^{\mathsf T}Aq/2`$；没有在该def中要求A对称正定，也未把isNHLSolution绑定到该二次势或$`M=I`$。
- 不含原页定理8.1、特征值互异、D的模态排除及Hörmander/遍历性结论；不得由本条声明推断这些性质。
- [ERRATUM?] 原印质量重缩放方向有误，保留原文，正确方向须同步变换势。
- [ERRATUM?] 正确重缩放为$`\tilde q=M^{1/2}q`$、$`\tilde p=M^{-1/2}p`$；$`\tilde U(\tilde q)=U(M^{-1/2}\tilde q)`$，二次势矩阵变为$`M^{-1/2}AM^{-1/2}`$。这里只给修正解释，未新增重缩放定理；harmonicPotential没有对称正定资格，也没有绑定单位质量NHL。
- 覆盖缺口：仅正对角质量、无约束$`N_d=n`$的NHL漂移与单ξ噪声积分解规格；harmonicPotential仅定义二次函数。一般矩阵质量、单位质量二次专门化声明及原书重缩放均未覆盖。
- 覆盖缺口：[EXTRA] $`M^{-1}=\operatorname{diag}(invm)`$，$`N_d=n`$；$`invm_i,\beta,Q,\gamma`$均正；$`\beta^{-1}=k_B T`$，$`Q=\mu`$。一般非对角物理质量未覆盖。
- 覆盖缺口：harmonicPotential对任意实方阵A定义$`q^{\mathsf T}Aq/2`$；没有在该def中要求A对称正定，也未把isNHLSolution绑定到该二次势或$`M=I`$。
- 覆盖缺口：不含原页定理8.1、特征值互异、D的模态排除及Hörmander/遍历性结论；不得由本条声明推断这些性质。
- 覆盖缺口：[ERRATUM?] 正确重缩放为$`\tilde q=M^{1/2}q`$、$`\tilde p=M^{-1/2}p`$；$`\tilde U(\tilde q)=U(M^{-1/2}\tilde q)`$，二次势矩阵变为$`M^{-1/2}AM^{-1/2}`$。这里只给修正解释，未新增重缩放定理；harmonicPotential没有对称正定资格，也没有绑定单位质量NHL。

### 6. 审计结论（含网站复审结论）

网站首轮：FAIL。
网站复审结论：NEEDS_HUMAN；展开nhField可得$`nhlDrift=((invm\cdot p,-\nabla U-\xi p),(\sum invm_i p_i^2-n/\beta)/Q-\gamma\xi)`$，故三个漂移分量对应(8.27)–(8.29)。isNHLSolution在任意带可测空间Ω上量化概率测度P、单坐标W、状态过程X及固定x0，要求全部逆质量、β,Q、γ正；常噪声向量的物理Phase分量为0，热浴分量$`\sqrt{2\gamma/(\beta Q)}`$，与原印根号覆盖范围完全一致。additiveSDE的完整积分解前提已核对，不声称存在、不变性或遍历性。harmonicPotential对任意A只定义二次函数；只有A对称时梯度才是Aq，不能凭def推断正定或定理8.1。原页D用于后续Hörmander结论，本条未形式化它，不应将此归为一般NHL漂移错误。当前明确缩小范围的三个声明本身可PASS，原书重缩放疑误使条目总体NEEDS_HUMAN。
原文版：原印质量重缩放方向疑误待导师。
修正版：正对角质量NHL漂移及单噪声积分解规格网站PASS；harmonicPotential仅定义函数，不含(8.30)–(8.32)特化或定理8.1。
当前：修正版/限定声明网站认可；原文疑误待导师（NEEDS_HUMAN）。
原书疑点：已目视核对原页PDF367：原印$`\tilde q=M^{-1/2}q`$、$`\tilde p=M^{1/2}p`$不产生单位质量方程；正确方向相反并须同步变换势。；[ERRATUM?]原书所印质量重缩放方向有误，原文保留待人工处理。；已目视核对原页PDF367：原印$`\tilde q=M^{-1/2}q`$、$`\tilde p=M^{1/2}p`$方向有误。正确为$`\tilde q=M^{1/2}q`$、$`\tilde p=M^{-1/2}p`$，势变为$`\tilde U(\tilde q)=U(M^{-1/2}\tilde q)`$；若$`U(q)`$=$`q^{\mathsf T}Aq/2`$，则$`\tilde A=M^{-1/2}AM^{-1/2}`$。
32号本轮已目视核对原页；记录见blueprint/ch08/closeout32/PDF_VISUAL_CHECKS.json；原书PDF页366–367。

### 7. 状态与证明位置

- `MD.Ch08.nhlDrift`：定义
- `MD.Ch08.isNHLSolution`：定义
- `MD.Ch08.harmonicPotential`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-Lemma81

印刷页 347 / PDF页 368。

### 1. 原文陈述

> $`C_k=(A^{k-1}p,A^kq)`$, $`D_k=(A^kq,-A^kp)`$ belong to the Lie algebra generated by $`F=(p,-Aq)`$, $`G=(0,p)`$, $`k=1,2,\ldots`$

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> The proof of this is straightforward by induction on k. (See exercises.)

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem lemma81 (A : Matrix (Fin n) (Fin n) ℝ) (k : ℕ) :
    textbookThermostatC A k ∈ textbookThermostatLieSpan A ∧
    textbookThermostatD A k ∈ textbookThermostatLieSpan A := by
  exact textbookThermostat_C_D_mem_lieSpan A k
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 线性向量场C、D在实际Lie生成空间中的归属；Lean零起始索引对应原文正索引。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- Lean索引$`k=0`$对应原文$`k=1`$；完整实际线性场、导数括号与End括号约定均摘录；生成子代数在相反括号下相同。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页368。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.lemma81`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-Proposition83

印刷页 347–348 / PDF页 368–369。

### 1. 原文陈述

> If $`A`$ is symmetric positive definite with distinct eigenvalues, the $`2N_c`$ vectors $`C_1,D_1,\ldots,C_{N_c},D_{N_c}`$ are linearly independent on $`D=\mathbb R^{2N_c}\setminus\bigcup V_k`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem proposition83 (A : Matrix (Fin n) (Fin n) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (z : textbookThermostatPhase n)
    (hz : z ∈ textbookThermostatModeDomain hA.1) :
    LinearIndependent ℝ (textbookThermostatFamily A z) := by
  exact textbookThermostatFamily_linearIndependent A hA hdist z hz
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 指定模态域内的2n个实际线性场值线性无关；不扩大到例外零模态。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- D的每个特征模态中q、p不能同时为0；有限族用Fin n⊕Fin n索引；完整证明消去两组系数。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：[ERRATUM?]原证明下标、模态标量式及第二组系数消去需核对；命题与Lean签名正确。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页368–369。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.proposition83`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-Theorem81

印刷页 346–348 / PDF页 367–369。

### 1. 原文陈述

> If $`A`$ is symmetric positive definite with distinct eigenvalues, (8.30)–(8.32) satisfies the Hörmander condition on $`D\times\mathbb R`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem theorem81Printed (A : Matrix (Fin n) (Fin n) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (Q θ γ σ : ℝ)
    (w : textbookThermostatPhase n × ℝ) (hw : w.1 ∈ textbookThermostatModeDomain hA.1) :
    textbookHormanderAt {textbookNHLDrift A Q θ γ, textbookThermostatNoise σ} w := by
  sorry
theorem theorem81_corrected (A : Matrix (Fin n) (Fin n) ℝ) (hA : A.PosDef)
    (hdist : Function.Injective hA.1.eigenvalues) (Q θ γ σ : ℝ) (hQ : 0 < Q)
    (hθ : 0 < θ) (hγ : 0 < γ) (hσ : σ ≠ 0)
    (w : textbookThermostatPhase n × ℝ) (hw : w.1 ∈ textbookThermostatModeDomain hA.1) :
    textbookHormanderAt {textbookNHLDrift A Q θ γ, textbookThermostatNoise σ} w := by
  exact textbookNHL_hormander A hA hdist Q θ γ σ hσ w hw
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 所印及补参数资格后的NHL点态Hörmander条件；不含由其推出全局几何遍历性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- D严格采用每个特征模态q、p不同时为零；正温度、质量、摩擦及非零噪声明确写出。
- [EXTRA]$`\theta=k_B T`$，$`Q=\mu`$；corrected的$`Q,\theta,\gamma\gt 0`$是物理资格，括号结论本身只额外需要$`\sigma\ne0`$。σ在此是独立实参数，未声明满足NHL涨落耗散幅度。
- [EXTRA] 当前`_corrected`为σ独立非零的括号结论；如解释为物理NHL，还须$`\sigma^2=2\gamma\theta/Q`$。未推到全局遍历性。
- 覆盖缺口：所印及补参数资格后的NHL点态Hörmander条件；不含由其推出全局几何遍历性。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；缺非零噪声资格。
修正版：原送审正参数与$`\sigma\ne0`$的_corrected点态括号结论PASS，非全局遍历性。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF367–369：继承Proposition8.2证明，必须排除$`\sigma=0`$；只证明Hörmander张成，不自动获得全局几何遍历性。；[ERRATUM?]字面版含$`\sigma=0`$反例；物理上下文的参数资格与字面版分开。原质量重缩放与所引证明的局部排印/推导疑误亦应保留。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页367–369。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.theorem81Printed`：未证；原书疑误不证
- `MD.Ch08.theorem81_corrected`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-ZeroModeInvariant

印刷页 346 / PDF页 367。

### 1. 原文陈述

> $`V_k=\{(q,p)\mid u_k\cdot q=0,\ u_k\cdot p=0\}`$ is an invariant submanifold. $`D=\mathbb R^{2N_c}\setminus\bigcup V_k`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem modeDomain_complement {A : Matrix (Fin n) (Fin n) ℝ} (hA : A.IsHermitian) :
    textbookThermostatModeDomain hA = (⋃ i, textbookNHLZeroMode hA i)ᶜ :=
  textbookThermostatModeDomain_eq_compl_zeroModes hA
theorem zeroMode_invariant {A : Matrix (Fin n) (Fin n) ℝ} (hA : A.IsHermitian)
    (i : Fin n) {a b : ℝ} (q p : ℝ → Vec n) (ξ : ℝ → ℝ)
    (hcq : ContinuousOn q (Icc a b)) (hcp : ContinuousOn p (Icc a b))
    (hξ : ContinuousOn ξ (Icc a b))
    (hq : ∀ t ∈ Ico a b, HasDerivWithinAt q (p t) (Ici t) t)
    (hp : ∀ t ∈ Ico a b, HasDerivWithinAt p (-(A *ᵥ q t)-ξ t • p t) (Ici t) t)
    (hzero : (q a,p a) ∈ textbookNHLZeroMode hA i) :
    ∀ t ∈ Icc a b, (q t,p t) ∈ textbookNHLZeroMode hA i := by
  exact textbookNHL_zeroMode_invariant hA i q p ξ hcq hcp hξ hq hp hzero
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 模态域的补集表达及连续热浴路径驱动的模态ODE零模态不变。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 任意紧时间区间上的实际模态ODE；连续随机热浴路径可逐路径应用，不额外声称SDE解存在。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页367。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.modeDomain_complement`：已证
- `MD.Ch08.zeroMode_invariant`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-NHLGenerator

印刷页 348 / PDF页 369。

### 1. 原文陈述

> $`L_{NHL}f=M^{-1}p\cdot\nabla_q f-\nabla U\cdot\nabla_p f-\xi p\cdot\nabla_p f+[\mu^{-1}(p^{\mathsf T}M^{-1}p-N_d k_B T)-\gamma\xi]\partial_\xi f+k_B T\gamma\mu^{-1}\partial_\xi^2f`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def additiveGenerator {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → E) (B : E) (f : E → ℝ) (z : E) : ℝ :=
  fderiv ℝ f z (F z) + fderiv ℝ (fun x ↦ fderiv ℝ f x B) z B / 2
def nhlGenerator (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (f : Phase n × ℝ → ℝ) (z : Phase n × ℝ) : ℝ :=
  additiveGenerator (nhlDrift invm U β Q γ) (0, Real.sqrt (2*γ/(β*Q))) f z
def nhlLyapunov (U : Vec n → ℝ) (Q a : ℝ) (z : Phase n × ℝ) : ℝ :=
  (∑ i, z.1.2 i^2)/2 + U z.1.1 + Q*(z.2-a)^2/2
def geometricDriftBound {E : Type*} (L : (E → ℝ) → E → ℝ) (V : E → ℝ) : Prop :=
  (∀ z, 0 < V z) ∧ ∃ α δ : ℝ, 0 < α ∧ 0 < δ ∧ ∀ z, L V z ≤ -α*V z+δ
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际加性扩散的Fréchet形式生成元、Lyapunov候选及漂移界性质的定义。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 采用实际一阶、二阶Fréchet导数；原文省略f的$`-\xi p\cdot\nabla_p`$理解为作用于f；Q,β,γ须正。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页369。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.additiveGenerator`：定义
- `MD.Ch08.nhlGenerator`：定义
- `MD.Ch08.nhlLyapunov`：定义
- `MD.Ch08.geometricDriftBound`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-LyapunovCalculation

印刷页 348–349 / PDF页 369–370。

### 1. 原文陈述

> For $`M=I`$, $`\varphi=\lVert p\rVert^2/2+U+\mu(\xi-a)^2/2`$, $`L\varphi=-a\lVert p\rVert^2-\gamma\mu\xi(\xi-a)-N_d k_B T(\xi-a)+k_B T\gamma`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nhlLyapunovExpression (P2 U ξ Q θ γ a N : ℝ) : ℝ :=
  -a*P2-γ*Q*ξ*(ξ-a)-N*θ*(ξ-a)+θ*γ
theorem nhlLyapunov_calculation (U : Vec n → ℝ) (β Q γ a : ℝ)
    (hU : ContDiff ℝ 2 U) (hβ : 0 < β) (hQ : 0 < Q) (hγ : 0 < γ)
    (z : Phase n × ℝ) :
    nhlGenerator (fun _ ↦ 1) U β Q γ (nhlLyapunov U Q a) z =
      nhlLyapunovExpression (∑ i, z.1.2 i^2) (U z.1.1) z.2 Q (1/β) γ a n := by
  sorry
theorem shiftedSquare_bound (ξ a : ℝ) : -ξ^2-a^2 ≤ -(ξ-a)^2/2 := by
  nlinarith [sq_nonneg (ξ+a)]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际NHL生成元作用于平移二次能量的目标及标量平方不等式；未据此证明遍历。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- U下界$`\gt 1`$且上界有限用于后续Lyapunov正性/漂移估计；本条计算本身只需$`C^2`$。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页369–370。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.nhlLyapunovExpression`：定义
- `MD.Ch08.nhlLyapunov_calculation`：未证；缺大型理论
- `MD.Ch08.shiftedSquare_bound`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-LyapunovRatePrinted

印刷页 349 / PDF页 370。

### 1. 原文陈述

> Choose $`a\gamma\mu-N_d k_B T=0`$, $`\alpha=\min(2a,\gamma\mu)`$, $`\delta=\alpha U_{max}+\gamma\mu a^2+aN_d k_B T+k_B T\gamma`$; then $`L\varphi\le-\alpha\varphi+\delta`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def lyapunovAlphaPrinted (a γ Q : ℝ) : ℝ := min (2*a) (γ*Q)
def lyapunovAlpha_corrected (a γ : ℝ) : ℝ := min (2*a) γ
theorem lyapunovRatePrinted (P2 U Umax ξ Q θ γ a N : ℝ)
    (hP : 0 ≤ P2) (hU : U ≤ Umax) (hQ : 0 < Q) (hθ : 0 < θ)
    (hγ : 0 < γ) (ha : 0 < a) (hbalance : a*γ*Q=N*θ) :
    nhlLyapunovExpression P2 U ξ Q θ γ a N ≤
      -lyapunovAlphaPrinted a γ Q * (P2/2+U+Q*(ξ-a)^2/2) +
      (lyapunovAlphaPrinted a γ Q*Umax+γ*Q*a^2+a*N*θ+θ*γ) := by
  sorry
theorem lyapunovRate_counterexample :
    ¬ (nhlLyapunovExpression 0 2 10 4 1 1 2 8 ≤
      -lyapunovAlphaPrinted 2 1 4 * ((0:ℝ)/2+2+4*(10-2)^2/2) +
      (lyapunovAlphaPrinted 2 1 4*2+1*4*2^2+2*8*1+1*1)) := by
  norm_num [nhlLyapunovExpression, lyapunovAlphaPrinted]
theorem lyapunovRate_corrected (P2 U Umax ξ Q θ γ a N : ℝ)
    (hP : 0 ≤ P2) (hU : U ≤ Umax) (hQ : 0 < Q) (hθ : 0 < θ)
    (hγ : 0 < γ) (ha : 0 < a) (hbalance : a*γ*Q=N*θ) :
    nhlLyapunovExpression P2 U ξ Q θ γ a N ≤
      -lyapunovAlpha_corrected a γ * (P2/2+U+Q*(ξ-a)^2/2) +
      (lyapunovAlpha_corrected a γ*Umax+γ*Q*a^2+a*N*θ+θ*γ) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 所印与修正衰减系数、两版漂移界目标及所印界的正参数数值反例。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 修正为$`\min(2a,\gamma)`$，仅修正漂移代数估计；几何遍历还需完整概率半群、小集条件和解理论，未声称已证。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；$`\min(2a,\gamma\mu)`$一般不正确。
修正版：原送审$`\min(2a,\gamma)`$修正版及反例PASS。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF370：与φ热浴项$`\mu(\xi-a)^2/2`$比较时衰减系数应$`\le\gamma`$，所印$`\min(2a,\gamma\mu)`$对一般μ不足；正参数数值反例已列。；{"codes": ["ERRATUM_LYAPUNOV_RATE"], "detail": "lyapunovAlphaPrinted与lyapunovRatePrinted忠实保留原书$`\alpha=\min(2a,\gamma\mu)`$及δ，按字面忠实性PASS，不能作为正确漂移定理使用。_counterexample的正参数满足全部前提；_corrected改为$`\min(2a,\gamma)`$合理且正确：ξ能量的系数是Q/2，故须$`\alpha\le\gamma`$；结合平方不等式及$`U\le U_{max}`$得所写δ。修正版没有额外宣称几何遍历。", "suggested_fix": "原书字面版保留并加[ERRATUM?]，不以sorry假装其数学正确；正式使用_corrected版本，$`\alpha=\min(2a,\gamma)`$。"}
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页370。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.lyapunovAlphaPrinted`：定义
- `MD.Ch08.lyapunovAlpha_corrected`：定义
- `MD.Ch08.lyapunovRatePrinted`：未证；原书疑误不证
- `MD.Ch08.lyapunovRate_counterexample`：已证
- `MD.Ch08.lyapunovRate_corrected`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.2-NHLTimestep

印刷页 350 / PDF页 371。

### 1. 原文陈述

> The symmetric NHL splitting uses kick, drift, feedback, damping, exact OU, damping, feedback, drift, kick. $`\zeta=\sqrt{k_B T\mu^{-1}(1-e^{-2\gamma h})}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nhlOU (β Q γ h R : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  (z.1, Real.exp (-γ*h)*z.2 + Real.sqrt ((1-Real.exp (-2*γ*h))/(β*Q))*R)
def forceKick (U : Vec n → ℝ) (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ z.1.2 i-h*gradient U z.1.1 i), z.2)
def bathDamping (h : ℝ) (z : Phase n × ℝ) : Phase n × ℝ :=
  ((z.1.1, fun i ↦ Real.exp (-h*z.2)*z.1.2 i), z.2)
def nhlStep (invm : Vec n) (U : Vec n → ℝ) (β Q γ h R : ℝ) : Phase n × ℝ → Phase n × ℝ :=
  forceKick U (h/2) ∘ nhDrift invm (h/2) ∘ nhFeedback invm β Q (h/2) ∘ bathDamping (h/2) ∘
  nhlOU β Q γ h R ∘ bathDamping (h/2) ∘ nhFeedback invm β Q (h/2) ∘ nhDrift invm (h/2) ∘ forceKick U (h/2)
def standardNormalSequence (P : Measure Ω) (R : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure P ∧ iIndepFun R P ∧ ∀ k, HasLaw (R k) (gaussianReal 0 1) P
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际九阶段NHL单步映射、OU随机输入及独立标准正态序列资格；不含整体稳定性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- $`R_n`$独立标准正态；$`h\ge0`$、$`\beta,Q\gt 0`$、$`\gamma\ge0`$用于OU噪声解释；所谓无限摩擦稳定性没有扩大成完整算法无条件稳定定理。
- 覆盖缺口：实际九阶段NHL单步映射、OU随机输入及独立标准正态序列资格；不含整体稳定性。
- 覆盖缺口：$`R_n`$独立标准正态；$`h\ge0`$、$`\beta,Q\gt 0`$、$`\gamma\ge0`$用于OU噪声解释；所谓无限摩擦稳定性没有扩大成完整算法无条件稳定定理。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页371。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.nhlOU`：定义
- `MD.Ch08.forceKick`：定义
- `MD.Ch08.bathDamping`：定义
- `MD.Ch08.nhlStep`：定义
- `MD.Ch08.standardNormalSequence`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.1-NHLWeakStationary

印刷页 345–346 / PDF页 366–367。

### 1. 原文陈述

> The NHL method preserves the extended canonical distribution $`\rho_\beta\exp(-\beta\mu\xi^2/2)`$, by adding an OU thermostat in $`\xi`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def weakStationaryNHL (invm : Vec n) (U : Vec n → ℝ) (β Q γ : ℝ)
    (ρ : Phase n × ℝ → ℝ) : Prop :=
  probabilityDensity volume ρ ∧ ∀ f : Phase n × ℝ → ℝ,
    ContDiff ℝ ∞ f → HasCompactSupport f →
    (∫ z, nhlGenerator invm U β Q γ f z * ρ z) = 0
theorem nhlWeakStationary (invm : Vec n) (U : Vec n → ℝ) (β Q γ Z : ℝ)
    (hp : thermostatParameters invm β Q) (hγ : 0 < γ) (hZ : 0 < Z)
    (hU : ContDiff ℝ 2 U) (hi : Integrable (nhWeight invm U β Q))
    (hpart : ∫ z, nhWeight invm U β Q z = Z) :
    weakStationaryNHL invm U β Q γ (fun z ↦ nhWeight invm U β Q z/Z) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 归一概率密度的弱驻定积分式目标；Markov半群不变性、唯一性和遍历性未覆盖。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只覆盖归一概率密度的弱驻定积分式；Markov半群不变性、唯一性及遍历结论需要额外解理论，明确列覆盖缺口。
- 覆盖缺口：归一概率密度的弱驻定积分式目标；Markov半群不变性、唯一性和遍历性未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页366–367。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.weakStationaryNHL`：定义
- `MD.Ch08.nhlWeakStationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.4.3-PreEquilibriumMeans

印刷页 354–355 / PDF页 375–376。

### 1. 原文陈述

> $`\bar\theta(t)=\int 2K\rho(q,p,\xi,t)\,d\omega\,d\xi`$, $`\bar\xi(t)=\int\xi\rho(q,p,\xi,t)\,d\omega\,d\xi`$, with normalized pre-equilibrium density $`\rho`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def meanKineticTwice (invm : Vec n) (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ :=
  ∫ z, kineticTwice invm z.1.2 * ρ t z
def meanBath (ρ : ℝ → Phase n × ℝ → ℝ) (t : ℝ) : ℝ := ∫ z, z.2 * ρ t z
def preEquilibriumDensity (invm : Vec n) (ρ : ℝ → Phase n × ℝ → ℝ) : Prop :=
  (∀ i, 0 < invm i) ∧ ∀ t, 0 ≤ t →
    probabilityDensity volume (ρ t) ∧
    Integrable (fun z : Phase n × ℝ ↦ kineticTwice invm z.1.2 * ρ t z) volume ∧
    Integrable (fun z : Phase n × ℝ ↦ z.2 * ρ t z) volume
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 任意随时间概率密度的两项有限平均与正质量、加权可积资格；preEquilibriumDensity仅是历史名称，未要求或覆盖NHL Fokker–Planck演化、闭合方程及局部稳定性。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- [EXTRA] preEquilibriumDensity要求所有逆质量严格为正，且对每个$`t\ge0`$，$`\rho\,t`$逐点非负、可积、积分为1，两项加权函数均Integrable。正质量与有限矩资格均已在当前Lean定义中出现。
- meanKineticTwice和meanBath本身是任意实数t上的总化积分定义；仅在上述资格及$`t\ge0`$下解释为有限平均。
- preEquilibriumDensity为历史名称：不要求NHL Fokker–Planck演化；本条范围仅为两平均的定义与资格。闭合动力学和局部稳定性不在所列Lean声明中。
- 覆盖缺口：任意随时间概率密度的两项有限平均与正质量、加权可积资格；preEquilibriumDensity仅是历史名称，未要求或覆盖NHL Fokker–Planck演化、闭合方程及局部稳定性。

### 6. 审计结论（含网站复审结论）

网站首轮：FAIL。
网站复审结论：PASS；逐一审查meanKineticTwice、meanBath、preEquilibriumDensity：任意n，状态$`z=((q,p),\xi)`$，标准体积积分，动能权重$`\sum invm_i p_i^2`$与浴权重ξ均忠实。均值def对任意实数t总化；资格def仅对$`t\ge0`$要求概率密度、正逆质量和两项矩可积。已在范围内明确未形式化原页NHL Fokker–Planck演化及稳定性，因此不将定义误称完整动力学资格。旧issues是元数据过期，当前声明无该缺陷。未编译或补证明。
原文版：原书全文保留；当前有限平均/弱驻定资格已获网站复审PASS。
修正版：当前声明网站复审PASS，旧FAIL已解决；范围仍按实际覆盖限定。
当前：网站复审PASS（Lean未改）。
原书疑点：[RESOLVED] 旧issues中的MISSING_MOMENT_INTEGRABILITY与当前摘录不符：两项Integrable及正逆质量均已补入；不能沿用旧缺失判定。；[COVERAGE_GAP] 原页明确要求ρ按扩展NHL系统的Fokker–Planck方程演化；当前定义未表达该演化，已按statement_scope缩限为任意随时间概率密度的有限平均，不将其称作完整预平衡动力学形式化。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页375–376。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.meanKineticTwice`：定义
- `MD.Ch08.meanBath`：定义
- `MD.Ch08.preEquilibriumDensity`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

