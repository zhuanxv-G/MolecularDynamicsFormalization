[上一部分](part06.zh-CN.md) / [目录](../../CH07_BLUEPRINT.zh-CN.md) / [下一部分](part08.zh-CN.md)

## MD-7.10-MomentumRedrawLimit

印刷页 306 / PDF页 327。

### 1. 原文陈述

> We now consider schemes in the limit $`\gamma\to\infty`$, where the exact solution of the vector OU process reduces to redrawing momenta from the canonical distribution, so $`p_{n+1}=\sqrt{k_BT}M^{1/2}R`$, where $`R`$ is a vector of i.i.d. normal random numbers.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def redrawMomentum (m : V n) (θ : ℝ) (R : V n) : V n := fun i ↦ Real.sqrt θ*Real.sqrt (m i)*R i
def redrawStep (m : V n) (θ : ℝ) (R : V n) (x : Phase n) : Phase n := (x.1,redrawMomentum m θ R)
theorem momentumRedrawLimit (m : V n) (θ h : ℝ) (p R : V n) (hm : ∀ i, 0 < m i) (hh : 0 < h) (hθ : 0 < θ) :
    Filter.Tendsto (fun γ : ℝ ↦ ouMomentum m γ θ h p R) Filter.atTop (𝓝 (redrawMomentum m θ R)) := by
  sorry

theorem redrawMomentum_law (P : Measure Ω) (m : V n) (θ : ℝ) (R : Ω → V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ)
    (hR : HasLaw R (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)) P) :
    HasLaw (fun sample ↦ redrawMomentum m θ (R sample)) (momentumGibbs m θ⁻¹) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 固定正h和实际独立Gaussian R的逐噪声路径极限；分布收敛可由连续映射桥得到，未额外宣称。质量趋零与速度摩擦的不同极限仅原文提示，相关重标度定理尚缺。
- 29号覆盖限定：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。
- 覆盖缺口：29号覆盖限定：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：固定h>0、θ>0，对任意固定p,R的逐噪声路径极限正确，有限维逐坐标拓扑也匹配。m不需正值即可使这个经Real.sqrt截断的纯实函数极限成立；但要忠实表达M正质量与canonical重抽，应加∀i m\_i>0，并给随机R及独立标准Gaussian的分布对象。当前R只是确定向量，无P、HasLaw或随机变量资格；extra\_assumptions称“实际独立Gaussian R”超出了签名。此FAIL是原文分布结论缺失，不否认现有确定性极限定理。
网站复审结论：PASS。ouMomentum完整公式exp(−γh)p+√[θ(1−exp(−2γh))]√m R；固定h>0、正质量、θ>0，γ→∞逐坐标极限正好为√θ√m R。law声明的标准Gaussian乘积分布是独立坐标，输出momentumGibbs m θ⁻¹的方差为m/(θ⁻¹)=mθ，正确。HasLaw使用给定P，不额外把任意确定R声称为随机Gaussian。位置未改变；质量零极限及弱收敛未冒充已证内容。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：正质量下固定噪声的确定性大摩擦极限，以及标准Gaussian向量重抽的实际momentumGibbs分布；随机变量的弱收敛未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.redrawMomentum`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.redrawStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentumRedrawLimit`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.redrawMomentum_law`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.10-OBABOOverdampedEuler

印刷页 307 / PDF页 328。

### 1. 原文陈述

> For the method denoted $`[OBABO]`$, we have the limiting scheme

$$
p_{n+1/2}=\sqrt{k_BT}M^{1/2}R_n,\quad \widehat p_{n+1/2}=p_{n+1/2}-(h/2)\nabla U(q_n),
$$



$$
q_{n+1}=q_n+hM^{-1}\widehat p_{n+1/2},\quad \widehat p_{n+1}=\widehat p_{n+1/2}-(h/2)\nabla U(q_{n+1}),\quad p_{n+1}=\sqrt{k_BT}M^{1/2}R_{n+1/2}.
$$



$$
q_{n+1}=q_n-\tfrac{h^2}{2}M^{-1}\nabla U(q_n)+h\sqrt{k_BT}M^{-1/2}R_n.\tag{7.38}
$$


> Denoting $`\tau=h^2/2`$, the update scheme (7.38) becomes the Euler-Maruyama scheme

$$
q_{n+1}=q_n-\tau M^{-1}\nabla U(q_n)+\sqrt{2\tau k_BT}M^{-1/2}R_n.\tag{7.39}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def obaboInfinite (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  redrawStep m θ S ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) ∘ redrawStep m θ R
def overdampedEulerH (m : V n) (U : V n → ℝ) (θ h : ℝ) (R q : V n) : V n :=
  fun i ↦ q i-h^2/2/m i*gradient U q i+h/m i*redrawMomentum m θ R i
def overdampedEuler (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R q : V n) : V n :=
  fun i ↦ q i-τ/m i*gradient U q i+Real.sqrt (2*τ*θ)/Real.sqrt (m i)*R i
theorem obaboInfinite_position (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S : V n) (x : Phase n) :
    (obaboInfinite m U θ h R S x).1 = overdampedEulerH m U θ h R x.1 := by
  funext i
  dsimp [obaboInfinite,redrawStep,kickStep,driftStep,overdampedEulerH,Function.comp_def]
  ring
theorem overdampedEuler_rescale (m : V n) (U : V n → ℝ) (θ h : ℝ) (R q : V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 ≤ θ) (hh : 0 ≤ h) :
    overdampedEulerH m U θ h R q = overdampedEuler m U θ (h^2/2) R q := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 obaboInfinite, overdampedEulerH, overdampedEuler, obaboInfinite\_position, overdampedEuler\_rescale 所列对象、量词、前提和结论。范围说明：C：组合按右至左执行redraw R、半kick、全drift、半kick、redraw S，位置消元不依赖原动量或尾噪声。overdampedEulerH及overdampedEuler各坐标质量因子正确；rescale显式要求m\_i>0、θ≥0、h≥0，恰好保证√(h²θ)=h√θ，等式成立。普遍实参数的position定理仅是代数恒等式，不宣称其全域为物理算法。[EXTRA]正质量及非负温度/步长合理；R/S的随机独立资格未进入纯代数式，不将该定理解释为随机弱误差结论。原摘录未包含长期O(τ)断言，故不将其列为本条签名缺项。sorry不影响PASS。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整保留五段极限更新和位置消元；τ=h²/2。长期平均O(τ)=O(h²)另需稳定势和遍历弱误差理论，未由代数消元得到。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：组合按右至左执行redraw R、半kick、全drift、半kick、redraw S，位置消元不依赖原动量或尾噪声。overdampedEulerH及overdampedEuler各坐标质量因子正确；rescale显式要求m\_i>0、θ≥0、h≥0，恰好保证√(h²θ)=h√θ，等式成立。普遍实参数的position定理仅是代数恒等式，不宣称其全域为物理算法。[EXTRA]正质量及非负温度/步长合理；R/S的随机独立资格未进入纯代数式，不将该定理解释为随机弱误差结论。原摘录未包含长期O(τ)断言，故不将其列为本条签名缺项。sorry不影响PASS。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 obaboInfinite, overdampedEulerH, overdampedEuler, obaboInfinite\_position, overdampedEuler\_rescale 所列对象、量词、前提和结论。范围说明：C：组合按右至左执行redraw R、半kick、全drift、半kick、redraw S，位置消元不依赖原动量或尾噪声。overdampedEulerH及overdampedEuler各坐标质量因子正确；rescale显式要求m\_i>0、θ≥0、h≥0，恰好保证√(h²θ)=h√θ，等式成立。普遍实参数的position定理仅是代数恒等式，不宣称其全域为物理算法。[EXTRA]正质量及非负温度/步长合理；R/S的随机独立资格未进入纯代数式，不将该定理解释为随机弱误差结论。原摘录未包含长期O(τ)断言，故不将其列为本条签名缺项。sorry不影响PASS。

### 7. 状态与证明位置

- `MD.Ch07.obaboInfinite`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.overdampedEulerH`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.overdampedEuler`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.obaboInfinite_position`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.overdampedEuler_rescale`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.10-BAOABLimitMethod

印刷页 307–308 / PDF页 328–329。

### 1. 原文陈述


$$
p_{n+1/2}=p_n-(h/2)\nabla U(q_n),\quad q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},
$$



$$
\widehat p_{n+1/2}=\sqrt{k_BT}M^{1/2}R_n,\quad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\widehat p_{n+1/2},\quad p_{n+1}=\widehat p_{n+1/2}-(h/2)\nabla U(q_{n+1}).
$$


> Expressing this as an update solely for the configurations, we obtain

$$
q_{n+1}=q_n-\tfrac{h^2}{2}M^{-1}\nabla U(q_n)+\tfrac h2\sqrt{k_BT}M^{-1/2}(R_n+R_{n-1}),
$$


> and substituting $`\tau=h^2/2`$ gives the BAOAB Limit Method (Leimkuhler-Matthews method)

$$
q_{n+1}=q_n-\tau M^{-1}\nabla U(q_n)+\sqrt{2\tau k_BT}M^{-1/2}\left(\tfrac{R_n+R_{n-1}}2\right).\tag{7.40}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def baoabInfinite (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U (h/2) ∘ driftStep m (h/2) ∘ redrawStep m θ R ∘ driftStep m (h/2) ∘ kickStep U (h/2)
def lmStepH (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n) : V n :=
  fun i ↦ q i-h^2/(2*m i)*gradient U q i+h/(2*m i)*(redrawMomentum m θ R i+redrawMomentum m θ S i)
def lmStep (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R S q : V n) : V n :=
  fun i ↦ q i-τ/m i*gradient U q i+Real.sqrt (2*τ*θ)/Real.sqrt (m i)*((R i+S i)/2)
theorem baoabInfinite_position (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n) :
    (baoabInfinite m U θ h R (q,fun i ↦ redrawMomentum m θ S i-h/2*gradient U q i)).1 =
      lmStepH m U θ h R S q := by
  funext i
  dsimp [baoabInfinite,lmStepH,kickStep,driftStep,redrawStep,Function.comp_def]
  ring

theorem lmStepH_rescale (m : V n) (U : V n → ℝ) (θ h : ℝ) (R S q : V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 ≤ θ) (hh : 0 ≤ h) :
    lmStepH m U θ h R S q = lmStep m U θ (h^2/2) R S q := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 消元需当前p已满足上一步尾kick关系；此初始关系显式，不能对任意初始动量声称位置闭合。
- 完整五段更新、h形式及τ形式都定义；两种根号系数识别参见上条重标度，尚未另证明。
- 29号覆盖限定：带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：组合次序正确；baoabInfinite\_position显式把初始p写为上一步redraw S减半kick，恰好避免对任意初始p错误地声称位置闭合。lmStepH与lmStep的两个公式正确；但只证明/声明了h形式消元，没有在正质量、θ≥0、h≥0下声明lmStepH=lmStep(τ=h²/2)。前条rescale只作用单噪声Euler，不能自动成为此双噪声声明。该完整结论缺项已在extra\_assumptions承认，但未给目标签名。
网站复审结论：PASS。函数复合从右至左是kick、drift、redraw、drift、kick，符合五段原文。position定理明确以p=redraw(S)−h∇U(q)/2为初值，因此第一个kick后p=redraw(S)−h∇U(q)，消元得到−h²∇U/(2m)及h(redraw R+redraw S)/(2m)。该代数恒等式对所有实参数在Lean总化下成立；rescale另加m>0、θ≥0、h≥0以正确识别√(h²θ)=h√θ，和τ=h²/2一致。没有无条件对任意初始动量声称闭合，也没有声称长期精度。 在明示覆盖范围内PASS；本结论为只读语义签名审校，不是Lean编译或证明通过报告。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：带显式尾kick初值的BAOAB位置消元及双噪声LM在τ=h²/2的重标度等式；不含长期精度。

### 7. 状态与证明位置

- `MD.Ch07.baoabInfinite`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmStepH`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.baoabInfinite_position`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.lmStepH_rescale`：未证；时间盒止；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.10-ColoredNoiseAndExtension

印刷页 308 / PDF页 329。

### 1. 原文陈述

> We can think of the noise process in (7.40) as corresponding to a colored noise which has characteristics that directly depend on the stepsize, although the noise decorrelates in just a couple of timesteps. This is therefore no longer a Markov process, however it can be reformulated as such if one considers the appropriate extended space (or keeping the momenta $`p_n`$).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def coloredNoise (R : ℕ → Ω → ℝ) (k : ℕ) (sample : Ω) : ℝ := (R k sample+R (k+1) sample)/2
theorem coloredNoise_covariance (P : Measure Ω) [IsProbabilityMeasure P] (R : ℕ → Ω → ℝ)
    (hind : iIndepFun R P) (hlaw : ∀ k, HasLaw (R k) (gaussianReal 0 1) P) (j k : ℕ) :
    (∫ sample, coloredNoise R j sample*coloredNoise R k sample ∂P) =
      if j = k then 1/2 else if j+1 = k ∨ k+1 = j then 1/4 else 0 := by
  sorry
def lmExtendedStep (m : V n) (U : V n → ℝ) (θ τ : ℝ) (R : V n) (x : V n × V n) : V n × V n :=
  (lmStep m U θ τ R x.2 x.1,R)

def lmExtendedKernel (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (hstep : Measurable (fun z : (V n × V n) × V n ↦
      lmExtendedStep m U θ τ z.2 z.1)) : Kernel (V n × V n) (V n × V n) :=
  (Kernel.id.prod (Kernel.const (V n × V n) (Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)))).map
    (fun z ↦ lmExtendedStep m U θ τ z.2 z.1)

def lmExtendedChain (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (R : ℕ → Ω → V n) (X0 : Ω → V n × V n) : ℕ → Ω → V n × V n
  | 0 => X0
  | k+1 => fun sample ↦ lmExtendedStep m U θ τ (R k sample)
      (lmExtendedChain m U θ τ R X0 k sample)

/-- 每次新噪声独立于初始状态及所有先前噪声；集合积分式给出扩展过程的Markov条件分布。 -/
theorem lmExtendedChain_markov (P : Measure Ω) (m : V n) (U : V n → ℝ) (θ τ : ℝ)
    (R : ℕ → Ω → V n) (X0 : Ω → V n × V n)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ) (hτ : 0 < τ)
    (hR : vectorNormalSequence P R) (hX0 : Measurable X0)
    (hfresh : ∀ k, IndepFun (R k)
      (fun sample ↦ (X0 sample,fun j : Fin k ↦ R j sample)) P)
    (hstep : Measurable (fun z : (V n × V n) × V n ↦ lmExtendedStep m U θ τ z.2 z.1)) :
    let X := lmExtendedChain m U θ τ R X0
    ∀ k (A : Set (V n × V n)) (hA : MeasurableSet A) (B : Set Ω),
    MeasurableSet[⨆ j : Fin (k+1), MeasurableSpace.comap (X j) inferInstance] B →
    P (B ∩ (X (k+1)) ⁻¹' A) =
      ∫⁻ sample in B, lmExtendedKernel m U θ τ hstep (X k sample) A ∂P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。
- 覆盖缺口：一般位置过程非Markov需额外非退化参数与初态；此处未作无条件断言。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：coloredNoise采用相邻标准独立Gaussian平均，索引(R\_k,R_{k+1})与原页(R\_n,R_{n−1})仅差移位；covariance对概率P、iIndepFun和HasLaw量化，方差1/2、邻接协方差1/4、其余0正确，应标[EXTRA]推导结论。lmExtendedStep把(q,R旧)映射到(lmStep(R新,R旧,q),R新)正确。但未有新噪声独立于过去的过程条件、Markov核/条件分布或扩展Markov性声明；只给一个确定性状态映射不能覆盖原页的核心Markov断言。一般位置过程非Markov也不宜无条件量化。
网站复审结论：NEEDS\_HUMAN。coloredNoise=(Rk+Rk+1)/2是对原文相邻噪声的移位记号；独立标准正态使其均值零，二阶矩分别为1/2、1/4、0，故covariance名虽结论写E[ηjηk]仍正确。这是[EXTRA]协方差结论。extendedStep输入状态(q,旧噪声)，输出(lmStep(新,旧,q),新)，Kernel为δ状态×标准Gaussian的可测推前，确为转移核。chain递归k=0起，markov的hfresh要求Rk独立于X0及R0,…,Rk−1，hstep、hX0与vectorNormalSequence足以保证对X0,…,Xk历史中所有可测B的集合积分恒等式；索引Fin(k+1)正确。metadata却仍称Markov定理未覆盖，须订正。原书由有色噪声直接推非Markov也须保留例外资格。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：fresh独立性下Markov集合积分式签名PASS；删去过时的同名缺口。协方差为额外推论，位置非Markov仍需限定。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：邻接噪声协方差（额外推论）、扩展状态映射和真实Gaussian转移核；给定可测性及每步新噪声对初态/全部过去独立时，扩展过程的Markov集合积分式。位置过程非Markov仅作一般情形说明，不作无例外全称定理。

### 7. 状态与证明位置

- `MD.Ch07.coloredNoise`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.coloredNoise_covariance`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.lmExtendedStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmExtendedKernel`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmExtendedChain`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.lmExtendedChain_markov`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.10-LimitMethodAccuracy

印刷页 308 / PDF页 329。

### 1. 原文陈述

> We would expect that this scheme should have an $`O(h^4)=O(\tau^2)`$ error in configurational averages. For averages computed in finite time, work in [224] has shown that (7.40) does indeed give a first order error, albeit one that vanishes exponentially fast in time as the simulation progresses. Hence for suitably long simulations, the observed error will be $`O(h^2)`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def lmTransientErrorBound (error : ℝ → ℝ → ℝ) : Prop :=
  ∃ C > 0, ∃ multiplier > 0, ∃ δ > 0, ∀ τ ∈ Set.Ioo 0 δ, ∀ T ≥ 0,
    |error τ T| ≤ C*(Real.exp (-multiplier*T)*τ+τ^2)
def limitAccuracyPrinted (error : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0) error (fun h ↦ h^2)

def limitAccuracyPrinted_corrected (error : ℝ → ℝ) : Prop :=
  Asymptotics.IsBigO (𝓝[Set.Ioi (0 : ℝ)] 0) error (fun h ↦ h^4)

theorem limitAccuracy_rescale (h : ℝ) : (h^2/2)^2 = h^4/4 := by ring

def limitAccuracyInfiniteTime_corrected (error : ℝ → ℝ → ℝ) (longtime : ℝ → ℝ) : Prop :=
  (∀ h, 0 < h → Tendsto (fun T ↦ error (h^2/2) T) atTop (𝓝 (longtime h))) ∧
  limitAccuracyPrinted_corrected longtime
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 用显式瞬态上界命题保留指数衰减的一阶项和二阶项，不宣称该命题已对任意势成立；其成立所需的增长/耗散与正则条件及真实分布误差识别尚缺。
- 原文称all values of h and τ亦不能由局部渐近展开推出全步长阶数结论。
- 29号覆盖限定：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。
- 覆盖缺口：29号覆盖限定：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：Printed忠实保留h²幂次，PASS；_corrected给h⁴合理对应无限时间不变平均，但必须限定该error为长期误差，不能直接用于固定有限T。lmTransientErrorBound正确记录C(e^(−aT)τ+τ²)的一种充分界，正C/a/δ及所有小τ、T≥0的量词明确，属于[EXTRA]精确定量目标；原书文字本身不保证该统一界。rescale恒等式正确。缺少LM真实平均误差与error的联系、势/观测/初值条件和实际误差满足该界的签名。
网站复审结论：NEEDS\_HUMAN。瞬态界的量词是存在统一C>0、衰减率>0、δ>0，∀0<τ<δ及∀T≥0，界C(e^(−λT)τ+τ²)；它只是error的性质定义。Printed保留h→0正侧的O(h²)，corrected改为O(h⁴)，rescale代数式τ²=h⁴/4正确。InfiniteTime\_corrected显式把固定h先T→∞的longtime接到O(h⁴)，防止把固定有限T误判四阶。任何声明都未证明真实LM误差满足瞬态界。原书末句符号歧义保留，孤立corrected定义应仅在长期语境中解释。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：限定定义和长期极限连接签名PASS；h⁴仅在先取长期极限的解释下适用，不表示固定有限时间四阶或真实LM误差界已证。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：瞬态界只是量化目标；h⁴修正版明确指先T→∞所得误差，固定有限T仍可能仅h²；实际LM误差及其满足界的定理未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.lmTransientErrorBound`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.limitAccuracyPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.limitAccuracyPrinted_corrected`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.limitAccuracy_rescale`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.limitAccuracyInfiniteTime_corrected`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.9.3-ZeroFrictionVerlet

印刷页 306 / PDF页 327。

### 1. 原文陈述

> An exact Ornstein-Uhlenbeck solve can be added where it is required in the scheme in order to effectively integrate Langevin dynamics: then setting $`\gamma=0`$ reduces the integrator to a standard Verlet scheme, integrating deterministic Newtonian dynamics.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem zeroFrictionOU (m : V n) (θ h : ℝ) (R : V n) (x : Phase n) : ouStep m 0 θ h R x = x := by
  ext i <;> simp [ouStep,ouMomentum]
theorem zeroFrictionBAOAB (m : V n) (U : V n → ℝ) (θ h : ℝ) (R : V n) :
    baoab m U 0 θ h R = kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) := by
  funext x
  have ha : driftStep m (h/2) (driftStep m (h/2) (kickStep U (h/2) x)) =
      driftStep m h (kickStep U (h/2) x) := by
    ext i <;> dsimp [driftStep] <;> ring
  simp only [baoab,Function.comp_apply,zeroFrictionOU]
  rw [ha]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 zeroFrictionOU, zeroFrictionBAOAB 所列对象、量词、前提和结论。范围说明：C：ouStep使用exp(−γh)及√(θ(1−exp(−2γh)))，γ=0时前者为1、后者为0，对任意实m/θ/h及R的函数等式都成立。BAOAB组合中OU成为恒等，两个半drift合成全drift，得到B(h/2)A(h)B(h/2)的velocity Verlet，次序及步长正确。签名专指BAOAB，extra\_assumptions说明其他排列可得到ABA/BAB，没有把所有排列冒称同一版本。无新增物理结论或遗漏本句核心结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- OU为恒等映射及BAOAB合并成BAB的函数恒等式；其他字母排列得到ABA或BAB，不一概声称同一种Verlet。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：ouStep使用exp(−γh)及√(θ(1−exp(−2γh)))，γ=0时前者为1、后者为0，对任意实m/θ/h及R的函数等式都成立。BAOAB组合中OU成为恒等，两个半drift合成全drift，得到B(h/2)A(h)B(h/2)的velocity Verlet，次序及步长正确。签名专指BAOAB，extra\_assumptions说明其他排列可得到ABA/BAB，没有把所有排列冒称同一版本。无新增物理结论或遗漏本句核心结论。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 zeroFrictionOU, zeroFrictionBAOAB 所列对象、量词、前提和结论。范围说明：C：ouStep使用exp(−γh)及√(θ(1−exp(−2γh)))，γ=0时前者为1、后者为0，对任意实m/θ/h及R的函数等式都成立。BAOAB组合中OU成为恒等，两个半drift合成全drift，得到B(h/2)A(h)B(h/2)的velocity Verlet，次序及步长正确。签名专指BAOAB，extra\_assumptions说明其他排列可得到ABA/BAB，没有把所有排列冒称同一版本。无新增物理结论或遗漏本句核心结论。

### 7. 状态与证明位置

- `MD.Ch07.zeroFrictionOU`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.zeroFrictionBAOAB`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.11.1-TemperatureObservables

印刷页 310 / PDF页 331。

### 1. 原文陈述

> Indeed, calculating the temperature of the system from an average of kinetic energy by

$$
N_dk_BT=\langle p^TM^{-1}p\rangle,\tag{7.41}
$$


> gives a similar problem. Using Proposition 6.1 we may formulate many alternative functions whose averages are proportional to the system temperature. In the following experiments we shall use the configurational temperature

$$
N_dk_BT=\langle q\cdot\nabla U(q)\rangle.\tag{7.42}
$$


> Were one able to solve the dynamics exactly, the kinetic and configurational temperatures would of course be equal.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def kineticTemperatureObservable (m : V n) (x : Phase n) : ℝ := ∑ i, x.2 i^2/m i
def configurationTemperatureObservable (U : V n → ℝ) (q : V n) : ℝ := ∑ i, q i*gradient U q i
theorem kineticTemperature (m : V n) (U : V n → ℝ) (β : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hprob : IsProbabilityMeasure (positionGibbs U β)) :
    (∫ x, kineticTemperatureObservable m x ∂productGibbs m U β) = (n : ℝ)/β := by
  sorry
theorem configurationTemperature (U : V n → ℝ) (β : ℝ) (hβ : 0 < β)
    (hU : ContDiff ℝ 1 U)
    (hw : Integrable (fun q ↦ Real.exp (-β*U q)) volume)
    (hZ : 0 < ∫ q, Real.exp (-β*U q))
    (hint : ∀ i, Integrable (fun q ↦ q i*gradient U q i*Real.exp (-β*U q)) volume)
    (hb : ∀ q i, Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atTop (𝓝 0) ∧
      Filter.Tendsto (fun r : ℝ ↦ r*Real.exp (-β*U (Function.update q i r))) Filter.atBot (𝓝 0)) :
    (∫ q, configurationTemperatureObservable U q ∂positionGibbs U β) = (n : ℝ)/β := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 kineticTemperatureObservable, configurationTemperatureObservable, kineticTemperature, configurationTemperature 所列对象、量词、前提和结论。范围说明：C：无约束n维、θ=1/β时，kinetic观测∑p\_i²/m\_i及configuration观测∑q\_i∂iU正确。kinetic定理要求正质量、β>0和位置Gibbs概率，动量Gaussian为概率且二阶矩有限，结论n/β成立。configuration定理要求C¹、权重可积、正配分积分、各q\_i∂iU权重可积、各坐标r exp(−βU)两端消失，足够积分分部得到n/β；这些合理[EXTRA]明确限制为ℝⁿ非约束情形。原页周期边界的提醒不等于这些ℝⁿ公式可直接用于任意周期坐标。两式在实际Gibbs下成立，未冒称离散链自动满足。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 无约束n个独立坐标时Nd=n，θ=1/β；约束减少自由度时不能直接用此n公式。
- 构型温度需真实归一位置Gibbs、可积和边界通量条件；数值分布下两种温度不必一致，不声称该等式对离散链自动成立。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：无约束n维、θ=1/β时，kinetic观测∑p\_i²/m\_i及configuration观测∑q\_i∂iU正确。kinetic定理要求正质量、β>0和位置Gibbs概率，动量Gaussian为概率且二阶矩有限，结论n/β成立。configuration定理要求C¹、权重可积、正配分积分、各q\_i∂iU权重可积、各坐标r exp(−βU)两端消失，足够积分分部得到n/β；这些合理[EXTRA]明确限制为ℝⁿ非约束情形。原页周期边界的提醒不等于这些ℝⁿ公式可直接用于任意周期坐标。两式在实际Gibbs下成立，未冒称离散链自动满足。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 kineticTemperatureObservable, configurationTemperatureObservable, kineticTemperature, configurationTemperature 所列对象、量词、前提和结论。范围说明：C：无约束n维、θ=1/β时，kinetic观测∑p\_i²/m\_i及configuration观测∑q\_i∂iU正确。kinetic定理要求正质量、β>0和位置Gibbs概率，动量Gaussian为概率且二阶矩有限，结论n/β成立。configuration定理要求C¹、权重可积、正配分积分、各q\_i∂iU权重可积、各坐标r exp(−βU)两端消失，足够积分分部得到n/β；这些合理[EXTRA]明确限制为ℝⁿ非约束情形。原页周期边界的提醒不等于这些ℝⁿ公式可直接用于任意周期坐标。两式在实际Gibbs下成立，未冒称离散链自动满足。

### 7. 状态与证明位置

- `MD.Ch07.kineticTemperatureObservable`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.configurationTemperatureObservable`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.kineticTemperature`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.configurationTemperature`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.11.1-VelocityAutocorrelationDefinition

印刷页 310 / PDF页 331。

### 1. 原文陈述

> The self-diffusion coefficient gives a metric quantifying the diffusion rate. It is often used as a way to compare the rate of phase space exploration between methods, and is typically calculated using the integral of the velocity auto-correlation function. However, in theory one can construct arbitrary methods to artificially scale the velocity auto-correlation function, hence giving inaccurate diffusion constants: the momentum sampled may not be the momentum we use to propagate the position with.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def velocityAutocorrelation (P : Measure Ω) (v : ℝ → Ω → V n) (t : ℝ) : ℝ :=
  ∫ sample, ∑ i, v 0 sample i*v t sample i ∂P
def greenKuboDiffusion (P : Measure Ω) (v : ℝ → Ω → V n) : ℝ :=
  (n : ℝ)⁻¹*∫ t in Set.Ioi (0 : ℝ), velocityAutocorrelation P v t
theorem autocorrelation_rescale (P : Measure Ω) (v : ℝ → Ω → V n) (c t : ℝ) :
    velocityAutocorrelation P (fun t sample i ↦ c*v t sample i) t = c^2*velocityAutocorrelation P v t := by
  simp only [velocityAutocorrelation]
  have heq : ∀ sample, (∑ i, (c*v 0 sample i)*(c*v t sample i)) = c^2*(∑ i, v 0 sample i*v t sample i) := by
    intro sample
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i _
    ring
  simp_rw [heq]
  rw [integral_const_mul]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 velocityAutocorrelation, greenKuboDiffusion, autocorrelation\_rescale 所列对象、量词、前提和结论。范围说明：C：velocityAutocorrelation定义v(0)·v(t)的期望，autocorrelation\_rescale对任意测度、任意函数和实c给出c²缩放，是合法Bochner积分标量提取，结论不需额外可积性假设也成立。greenKuboDiffusion中1/n为各向同性平均每坐标的惯例，是[EXTRA]而非原书逐字公式；其被定义为实数不自动保证物理意义。extra\_assumptions已正确限定概率、平稳、中心化、自相关可积等解释条件；还应注明n>0，n=0的Lean逆元为0仅是总定义。未声称或证明Einstein关系，故不把该理论算作签名漏项。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文未给常数因子的显式Green–Kubo式；此处按各向同性n维标准归一记录1/n，仅在P概率、速度平稳、中心化且自相关可积等资格下解释为物理扩散率。
- 已证的缩放恒等式说明动量观测被缩放时自相关改变；扩散系数与Einstein关系的等价仍需混合与积分极限理论，未证明。
- 覆盖缺口：已证的缩放恒等式说明动量观测被缩放时自相关改变；扩散系数与Einstein关系的等价仍需混合与积分极限理论，未证明。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。C：velocityAutocorrelation定义v(0)·v(t)的期望，autocorrelation\_rescale对任意测度、任意函数和实c给出c²缩放，是合法Bochner积分标量提取，结论不需额外可积性假设也成立。greenKuboDiffusion中1/n为各向同性平均每坐标的惯例，是[EXTRA]而非原书逐字公式；其被定义为实数不自动保证物理意义。extra\_assumptions已正确限定概率、平稳、中心化、自相关可积等解释条件；还应注明n>0，n=0的Lean逆元为0仅是总定义。未声称或证明Einstein关系，故不把该理论算作签名漏项。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 velocityAutocorrelation, greenKuboDiffusion, autocorrelation\_rescale 所列对象、量词、前提和结论。范围说明：C：velocityAutocorrelation定义v(0)·v(t)的期望，autocorrelation\_rescale对任意测度、任意函数和实c给出c²缩放，是合法Bochner积分标量提取，结论不需额外可积性假设也成立。greenKuboDiffusion中1/n为各向同性平均每坐标的惯例，是[EXTRA]而非原书逐字公式；其被定义为实数不自动保证物理意义。extra\_assumptions已正确限定概率、平稳、中心化、自相关可积等解释条件；还应注明n>0，n=0的Lean逆元为0仅是总定义。未声称或证明Einstein关系，故不把该理论算作签名漏项。

### 7. 状态与证明位置

- `MD.Ch07.velocityAutocorrelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.greenKuboDiffusion`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.autocorrelation_rescale`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12-ConstrainedLangevin

印刷页 317 / PDF页 338。

### 1. 原文陈述


$$
dq=M^{-1}pdt,\tag{7.43}
$$



$$
dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\tag{7.44}
$$



$$
0=g(q).\tag{7.45}
$$


> The vector of $`l`$ constraints is given by $`g:\mathbb R^{N_c}\to\mathbb R^l`$ and $`\lambda`$ is an $`l`$-dimensional vector of Lagrange multipliers. $`W`$ is a vector of standard Wiener processes, with the usual friction parameter $`\gamma\gt 0`$. Permissible phase points lie in the co-tangent bundle defined by the constraint and hidden constraint

$$
g(q)=0,\qquad g'(q)M^{-1}p=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def constraintJacobian {l : ℕ} (g : V n → V l) (q : V n) (j : Fin l) (i : Fin n) : ℝ :=
  coordDerivative (fun x ↦ g x j) q i
def constraintReaction {l : ℕ} (g : V n → V l) (q : V n) (multiplier : V l) : V n :=
  fun i ↦ ∑ j, constraintJacobian g q j i*multiplier j
def hiddenConstraint {l : ℕ} (m : V n) (g : V n → V l) (x : Phase n) : Prop :=
  ∀ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i)) = 0
def cotangentConstraint {l : ℕ} (m : V n) (g : V n → V l) : Set (Phase n) :=
  {x | g x.1 = 0 ∧ hiddenConstraint m g x}
def constrainedLangevin {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l) (U : V n → ℝ)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (Λ : ℝ → Ω → V l)
    (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 g ∧
  x0 ∈ cotangentConstraint m g ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t) ∧
    Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (Λ t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  (∀ sample i T, 0 ≤ T →
    IntervalIntegrable (fun s ↦ (X s sample).2 i/m i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -gradient U (X s sample).1 i-γ*(X s sample).2 i-
      constraintReaction g (X s sample).1 (Λ s sample) i) volume 0 T) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    X t sample ∈ cotangentConstraint m g ∧
    (∀ i, (X t sample).1 i = x0.1 i+∫ s in (0 : ℝ)..t, (X s sample).2 i/m i) ∧
    (∀ i, (X t sample).2 i = x0.2 i+
      (∫ s in (0 : ℝ)..t, -gradient U (X s sample).1 i-γ*(X s sample).2 i-
        constraintReaction g (X s sample).1 (Λ s sample) i)+
      Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i))

/-- 限制到单位质量、常正交投影的线性约束修正版；未声称一般非线性情形。 -/
def constrainedLangevin_corrected {l : ℕ} (P : Measure Ω) (C : Matrix (Fin l) (Fin n) ℝ)
    (proj : Matrix (Fin n) (Fin n) ℝ) (U : V n → ℝ) (γ θ : ℝ)
    (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n) (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 U ∧
  proj*proj=proj ∧ proj.transpose=proj ∧ C*proj=0 ∧
  (∀ v : V n, C *ᵥ v=0 → proj *ᵥ v=v) ∧
  C *ᵥ x0.1=0 ∧ C *ᵥ x0.2=0 ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample=x0) ∧
  (∀ sample i T, 0 ≤ T →
    IntervalIntegrable (fun s ↦ (X s sample).2 i) volume 0 T ∧
    IntervalIntegrable (fun s ↦ -(proj *ᵥ gradient U (X s sample).1) i-γ*(X s sample).2 i) volume 0 T) ∧
  ∀ t, 0 ≤ t → ∀ᵐ sample ∂P,
    C *ᵥ (X t sample).1=0 ∧ C *ᵥ (X t sample).2=0 ∧
    (∀ i, (X t sample).1 i=x0.1 i+∫ s in (0 : ℝ)..t, (X s sample).2 i) ∧
    ∀ i, (X t sample).2 i=x0.2 i+
      (∫ s in (0 : ℝ)..t, -(proj *ᵥ gradient U (X s sample).1) i-γ*(X s sample).2 i)+
      Real.sqrt (2*γ*θ)*(proj *ᵥ (W t sample-W 0 sample)) i
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 实际多维Wiener坐标独立、正质量/温度/摩擦、C²约束、积分可积明示；常系数噪声用真实W增量。
- 定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。
- 29号覆盖限定：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。
- 覆盖缺口：定义保留存在给定乘子过程的积分解，不证明一般约束SDE存在唯一。状态及乘子适应W自然历史，状态路径连续与初值完整；一般强解存在唯一仍未证明。
- 覆盖缺口：29号覆盖限定：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：Jacobian、反力求和、g′M⁻¹p=0和约束相空间定义正确；vectorWiener确含概率、联合Gaussian、标准协方差、连续路径和坐标过程独立。积分式的m\_i、γ、θ、W增量及初值无误。[EXTRA]正质量/温度、C²约束、自然W历史适应、确定初值及逐sample可积都是对解类的额外限制，非原页已给定全部资格。关键问题：Λ被限定为普通时间可积过程，反力只有有限变差∫g′ᵀΛds，无法抵消标准环境W的法向Brownian分量而保持隐藏约束；若原书λdt意指随机冲量，当前定义就不忠实于通常约束Langevin。若严格照字面则继承原印问题，不能据此断言有解。
网站复审结论：NEEDS\_HUMAN。V n、V l、Jacobian(j,i)、Reaction=JacobianᵀΛ及hiddenConstraint中的p\_i/m\_i均对应原式；θ=kBT，质量为正对角质量而非一般非对角矩阵，是[EXTRA]范围限制。vectorWiener的联合Gaussian、零均值、min协方差、连续路径和坐标独立规格确为标准向量Wiener。原版限定正时间，X和Λ适应W的自然历史、X路径连续/确定初值几乎处处，漂移逐路径可积，∀t≥0几乎处处满足完整约束和两个积分方程；λ确以dt积分，仅保留原印解类，不宣称存在。corrected仅单位质量、线性齐次约束Cq=0：proj自伴幂等、Cproj=0且恒等于ker C，故正是到ker C的正交投影；投影力和噪声、摩擦−γp与两条约束一致，修正合理。原印一般非退化噪声与有限变差反作用难以保持隐藏约束，应加[ERRATUM?]。 原印/修正版逐项结论：字面转写PASS；合理修正的签名PASS；本条总体因原书数学资格或记号疑点NEEDS\_HUMAN。
按版本登记：单位质量线性约束投影修正版签名PASS；原印有限变差乘子模型不声称一般存在。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：原印λdt的有限变差解类独立保留，不声称存在；修正版只覆盖单位质量线性约束和常正交投影噪声，非线性随机乘子/几何漂移理论未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.constraintJacobian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constraintReaction`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.hiddenConstraint`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.cotangentConstraint`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedLangevin`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.constrainedLangevin_corrected`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12-ConstrainedCanonicalErgodicity

印刷页 317 / PDF页 338。

### 1. 原文陈述

> In the infinite time limit, we have that solution trajectories of constrained Langevin (7.43)–(7.45) sample $`\widetilde\rho_\beta`$ ergodically, such that

$$
\lim_{T\to\infty}\frac1T\int_0^T\phi(q(t),p(t))dt=\int_{\mathcal D}\phi(q,p)\widetilde\rho_\beta d\omega,
$$


> where $`\widetilde\rho_\beta`$ is the normalized constrained canonical distribution

$$
\widetilde\rho_\beta=Z^{-1}\exp(-\beta H(q,p))\delta[g(q)]\delta[g'(q)M^{-1}p],
$$


> for normalizing constant $`Z`$ and where $`\delta[z]:=\prod_i\delta[z_i]`$ for a vector $`z`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def constrainedCanonical (ν : Measure (Phase n)) (m : V n) (U : V n → ℝ) (β : ℝ) : Measure (Phase n) :=
  ν.withDensity (fun x ↦ ENNReal.ofReal (gibbsWeight m U β x/(∫ y, gibbsWeight m U β y ∂ν)))
def constrainedReference {l : ℕ} (ν : Measure (Phase n)) (m : V n) (g : V n → V l) : Prop :=
  ν (cotangentConstraint m g)ᶜ = 0 ∧
  ∀ φ : Phase n → ℝ, Continuous φ → HasCompactSupport φ →
    Filter.Tendsto (fun ε : ℝ ↦ ∫ x, φ x*(Real.pi*ε)^(-(l : ℝ))*
      Real.exp (-((∑ j, (g x.1 j)^2)+
        (∑ j, (∑ i, constraintJacobian g x.1 j i*(x.2 i/m i))^2))/ε))
      (𝓝[Set.Ioi (0 : ℝ)] 0) (𝓝 (∫ x, φ x ∂ν))
def constrainedErgodicAverages (P : Measure Ω) (X : ℝ → Ω → Phase n) (μ : Measure (Phase n)) : Prop :=
  IsProbabilityMeasure P ∧ IsProbabilityMeasure μ ∧
  ∀ φ : Phase n → ℝ, Integrable φ μ →
    ∀ᵐ sample ∂P, Filter.Tendsto (fun T : ℝ ↦ T⁻¹*∫ t in (0 : ℝ)..T, φ (X t sample)) Filter.atTop (𝓝 (∫ x, φ x ∂μ))

def constrainedCanonicalQualification {l : ℕ} (ν : Measure (Phase n))
    (m : V n) (g : V n → V l) (U : V n → ℝ) (β : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ ContDiff ℝ 2 g ∧ constrainedReference ν m g ∧
  Integrable (gibbsWeight m U β) ν ∧ (0 < ∫ x, gibbsWeight m U β x ∂ν)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- δ不是普通Lebesgue密度；用有支撑测度ν和正则化δ的弱积分极限规定其含义，不能用任意面测度替代而省略Jacobian因子。
- 实际概率要求配分积分正有限；遍历性还需连通性、正则满秩约束、势增长及不可约等条件。原书省略这些条件，本条仅记录目标，不宣称无条件遍历定理。
- 29号覆盖限定：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。
- 覆盖缺口：29号覆盖限定：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。C：constrainedReference用(πε)^(−l)对2l个标量约束同时正则化，常数和ε幂正确，且显式要求支撑于cotangentConstraint；作为所印delta乘积的弱极限目标是忠实的。constrainedCanonical接受任意ν，未要求它满足constrainedReference、配分积分正有限或β>0，因此并非自动归一约束canonical。constrainedErgodicAverages仅是对任意P/X/μ的遍历目标定义，没有将μ连接到该canonical、也没有X满足约束SDE的前提或相应蕴涵声明。原书delta参考测度与自然约束相空间体积的Jacobian因子和遍历性条件需人工处理；extra\_assumptions的提醒不足以连接这些签名。
网站复审结论：NEEDS\_HUMAN。四个声明作为已缩小范围的定义基本忠实且内部合理，但没有完整的受约束SDE遍历结论。原书无条件遍历采样及delta参考的解释存在实质疑问，必须依任务规则保留原印并判NEEDS\_HUMAN；本判定不是因没有补证明或因sorry。
按版本登记：四个参考与遍历目标定义的限定范围获认可；没有完整受约束SDE遍历定理，几何参考体积和连通/不可约资格仍待导师。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：delta参考弱极限、总化权重和任意过程遍历目标；补正质量/β/正有限配分与参考资格谓词，未证明参考等于几何体积或SDE遍历性，连通反例另记。

### 7. 状态与证明位置

- `MD.Ch07.constrainedCanonical`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.constrainedReference`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.constrainedErgodicAverages`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.constrainedCanonicalQualification`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

