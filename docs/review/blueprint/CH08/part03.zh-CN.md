[上一部分](part02.zh-CN.md) / [目录](../../CH08_BLUEPRINT.zh-CN.md) / 下一部分：无

## MD-8.9.1-DPDMassOrderPrinted

印刷页 389 / PDF页 410。

### 1. 原文陈述

> For $`dp=-\nabla U\,dt-\Delta(q)p\,dt+\Sigma(q)dW`$, the book gives $`\Delta=M^{-1}\Sigma\Sigma^{\mathsf T}/(2k_B T)`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dpdMatrixFDPrinted {s r : ℕ} (M Γ : Matrix (Fin s) (Fin s) ℝ)
    (B : Matrix (Fin s) (Fin r) ℝ) (θ : ℝ) : Prop := Γ=(1/(2*θ)) • (M⁻¹*(B*B.transpose))
def dpdMatrixFD_corrected {s r : ℕ} (M Γ : Matrix (Fin s) (Fin s) ℝ)
    (B : Matrix (Fin s) (Fin r) ℝ) (θ : ℝ) : Prop := Γ=(1/(2*θ)) • ((B*B.transpose)*M⁻¹)
theorem dpdMassOrder_counterexample :
    (!![1,0;0,(1/2 : ℝ)]) * (!![1,-1;-1,1]) ≠
      (!![1,-1;-1,1]) * (!![1,0;0,(1/2 : ℝ)]) := by
  intro h
  have hh := congrArg (fun A : Matrix (Fin 2) (Fin 2) ℝ ↦ A 0 1) h
  norm_num [Matrix.mul_apply,Fin.sum_univ_two] at hh
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印/校正的质量矩阵次序及具体代数反例。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- M应正定、$`\theta\gt 0`$；本条记录两个矩阵关系目标与不交换反例，不声称由形式关系自动得到不变概率。
- 覆盖缺口：M应正定、$`\theta\gt 0`$；本条记录两个矩阵关系目标与不交换反例，不声称由形式关系自动得到不变概率。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；一般不等质量的乘法次序错误。
修正版：原送审右乘$`M^{-1}`$修正版与不交换反例PASS。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF410：对动量漂移$`-\Delta p`$、动量协方差$`k_B TM`$，应为$`\Delta=\Sigma\Sigma^{\mathsf T}M^{-1}/(2k_B T)`$；原印左乘仅在相应矩阵可交换（如等质量）时一致。两粒子不等质量的矩阵反例已证。；保留Printed等式；[ERRATUM?]记录一般质量情形改为$`\Sigma\Sigma^{\mathsf T}M^{-1}/(2k_B T)`$，标注等质量或交换条件下两者相同。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页410。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.dpdMatrixFDPrinted`：定义
- `MD.Ch08.dpdMatrixFD_corrected`：定义
- `MD.Ch08.dpdMassOrder_counterexample`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.2-DPDVelocityVerlet

印刷页 389–391 / PDF页 410–412。

### 1. 原文陈述

> $`p_{1/2}=p+hF^c(q)/2+hF^D(q,p)/2+\sqrt h F^R(q,R_{old})/2`$; $`q'=q+hM^{-1}p_{1/2}`$; $`p'=p_{1/2}+hF^c(q')/2+hF^D(q',p_{1/2})/2+\sqrt h F^R(q',R_{new})/2`$. Reuse $`R_{new}`$ next step. (8.91)–(8.93).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dpdRandomForce {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (σ : ℝ)
    (wR : ℝ → ℝ) (q : ParticleConfig N d) (R : Vec K) : ParticleConfig N d :=
  ∑ k, R k • (dpdNoise pairs σ wR q k).2

def dpdVerlet {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ h : ℝ) (wD wR : ℝ → ℝ)
    (state : ParticlePhase N d × Vec K) (Rnew : Vec K) : ParticlePhase N d × Vec K :=
  let q := state.1.1
  let p := state.1.2
  let ph := p+(h/2) • dpdConservative α rc q+(h/2) • dpdDissipative m γ wD q p+
    (Real.sqrt h/2) • dpdRandomForce pairs σ wR q state.2
  let qn := fun i ↦ q i+(h/m i) • ph i
  let pn := ph+(h/2) • dpdConservative α rc qn+(h/2) • dpdDissipative m γ wD qn ph+
    (Real.sqrt h/2) • dpdRandomForce pairs σ wR qn Rnew
  ((qn,pn),Rnew)

theorem dpdVerlet_reuse {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ h : ℝ) (wD wR : ℝ → ℝ) (z : ParticlePhase N d × Vec K) (R : Vec K) :
    (dpdVerlet pairs m α rc γ σ h wD wR z R).2=R := rfl
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 三条更新式和新噪声在下一步复用的状态机制。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 物理用法要求$`m_i\gt 0`$、$`h\ge0`$、无序对枚举、每步$`R_{new}`$独立标准正态并与历史独立；本条确定性给定输入的扩展状态映射。
- 尚未证明书中预期的一阶弱收敛；未把随机输入映射称为对称确定性流。
- 覆盖缺口：尚未证明书中预期的一阶弱收敛；未把随机输入映射称为对称确定性流。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页410–412。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.dpdRandomForce`：定义
- `MD.Ch08.dpdVerlet`：定义
- `MD.Ch08.dpdVerlet_reuse`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.2-DPDSplitGenerator

印刷页 391 / PDF页 412。

### 1. 原文陈述

> The DPD system splits into $`A`$: free transport, $`B`$: conservative force, $`O`$: dissipative plus pair noise. $`L_{DPD}=L_A+L_B+L_O`$. (8.94)–(8.98).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dpdA {N d : ℕ} (m : Fin N → ℝ) (z : ParticlePhase N d) : ParticlePhase N d :=
  ((fun i ↦ (m i)⁻¹ • z.2 i),0)
def dpdB {N d : ℕ} (α rc : ℝ) (z : ParticlePhase N d) : ParticlePhase N d :=
  (0,dpdConservative α rc z.1)
def dpdO {N d : ℕ} (m : Fin N → ℝ) (γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : ParticlePhase N d := (0,dpdDissipative m γ wD z.1 z.2)
def firstOrder8 {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (F : E → E) (f : E → ℝ) (z : E) : ℝ := fderiv ℝ f z (F z)
def dpdLO {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdO m γ wD) f z+
    (∑ k, fderiv ℝ (fun x ↦ fderiv ℝ f x) z (dpdNoise pairs σ wR z.1 k)
      (dpdNoise pairs σ wR z.1 k))/2
def dpdGenerator {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdA m) f z+firstOrder8 (dpdB α rc) f z+dpdLO pairs m γ σ wD wR f z
theorem dpdDrift_split {N d : ℕ} (m : Fin N → ℝ) (α rc γ : ℝ) (wD : ℝ → ℝ)
    (z : ParticlePhase N d) : dpdDrift m α rc γ wD z=dpdA m z+dpdB α rc z+dpdO m γ wD z := by
  ext <;> simp [dpdDrift,dpdA,dpdB,dpdO]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际三个漂移、无序对扩散生成元和漂移分解恒等式。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 采用独立无序对的Itô二阶导数形式，实现(8.97)有序双和的合并表达；未证明有序/无序表达等价。
- 光滑测试函数上的形式生成元定义不等同于已建立Markov半群，Fₜ=eᵗᴸ及其定义域列缺口。
- 覆盖缺口：采用独立无序对的Itô二阶导数形式，实现(8.97)有序双和的合并表达；未证明有序/无序表达等价。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页412。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.dpdA`：定义
- `MD.Ch08.dpdB`：定义
- `MD.Ch08.dpdO`：定义
- `MD.Ch08.firstOrder8`：定义
- `MD.Ch08.dpdLO`：定义
- `MD.Ch08.dpdGenerator`：定义
- `MD.Ch08.dpdDrift_split`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.2-DPDPairGeneratorPrinted

印刷页 392 / PDF页 413。

### 1. 原文陈述

> (8.100) prints $`L_{Oij}=[-\gamma\omega^D u+(\sigma^2/2)(\omega^R)^2e\cdot(\partial_{p_i}-\partial_{p_j})]e\cdot\partial_{p_i}`$ for each unordered pair $`i\lt j`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pairDerivative {N d : ℕ} (i j : Fin N) (e : Vec d)
    (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  fderiv ℝ f p (pairImpulseVector i j e)
def dpdPairGeneratorPrinted {N d : ℕ} (i j : Fin N) (e : Vec d) (m : Fin N → ℝ)
    (γ σ wd wr : ℝ) (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  -γ*wd*dot e (relativeVelocity m p i j)*fderiv ℝ f p (Pi.single i e)+
    σ^2*wr^2/2*pairDerivative i j e (fun x ↦ fderiv ℝ f x (Pi.single i e)) p
def dpdPairGenerator_corrected {N d : ℕ} (i j : Fin N) (e : Vec d) (m : Fin N → ℝ)
    (γ σ wd wr : ℝ) (f : ParticleConfig N d → ℝ) (p : ParticleConfig N d) : ℝ :=
  -γ*wd*dot e (relativeVelocity m p i j)*pairDerivative i j e f p+
    σ^2*wr^2/2*pairDerivative i j e (pairDerivative i j e f) p
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 冻结配置下单对动量生成元的原式和守恒方向修正版。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 本条只分别定义原印和成对修正版；不声称已证明驻定概率或原书单对不变性。
- 覆盖缺口：本条只分别定义原印和成对修正版；不声称已证明驻定概率或原书单对不变性。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；单对解释下最外层$`\partial_{p_i}`$不保总动量。
修正版：原送审改用Dij的_corrected签名PASS；不据此否定完整有序双和。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF413：单个无序对算子的最外层只对$`p_i`$求导，会对总动量产生非零漂移；对两粒子成对守恒更新应将最外层改为$`e\cdot(\partial_{p_i}-\partial_{p_j})`$。完整有序双和(8.97)另含反方向项，不能直接同样判错。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页413。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pairDerivative`：定义
- `MD.Ch08.dpdPairGeneratorPrinted`：定义
- `MD.Ch08.dpdPairGenerator_corrected`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.2-DPDSplittingCompositions

印刷页 392–393 / PDF页 413–414。

### 1. 原文陈述

> Shardlow: $`O(h)B(h/2)A(h)B(h/2)`$; $`S=B+O`$ and Trotter: $`S(h/2)A(h)S(h/2)`$. Pair products use the printed fixed unordered-pair order. (8.99),(8.101),(8.102).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def dpdShardlowComposition {E : Type*} (A B O : ℝ → E → E) (h : ℝ) : E → E :=
  O h ∘ B (h/2) ∘ A h ∘ B (h/2)
def dpdTrotterComposition {E : Type*} (A S : ℝ → E → E) (h : ℝ) : E → E :=
  S (h/2) ∘ A h ∘ S (h/2)
def sequentialPairComposition {E : Type*} (steps : List (E → E)) : E → E :=
  fun x ↦ steps.foldl (fun y F ↦ F y) x
def dpdSGenerator {N d K : ℕ} (pairs : Fin K → Fin N × Fin N) (m : Fin N → ℝ)
    (α rc γ σ : ℝ) (wD wR : ℝ → ℝ) (f : ParticlePhase N d → ℝ) (z : ParticlePhase N d) : ℝ :=
  firstOrder8 (dpdB α rc) f z+dpdLO pairs m γ σ wD wR f z
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 两种外层组合、固定顺序逐对执行及S形式生成元；实际OU单对步骤见后条。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- A/B/O/S为调用者指定的映射；只保留所印组合顺序。尚未实现BBK成对近似或其误差、全O/S流及生成元指数关系。
- 两次S同顺序的非交换成对乘积不能仅凭外层回文判为对称；不作该声称。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页413–414。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.dpdShardlowComposition`：定义
- `MD.Ch08.dpdTrotterComposition`：定义
- `MD.Ch08.sequentialPairComposition`：定义
- `MD.Ch08.dpdSGenerator`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.2-DPDPairOUUpdate

印刷页 393 / PDF页 414。

### 1. 原文陈述

> $`m_{red}=m_i m_j/(m_i+m_j)`$; $`m_{red}\,du=F\,dt-\gamma\omega^D u\,dt+\sigma\omega^R dW`$. $`a=\gamma\omega^D/m_{red}`$. $`u(t)=F/(a m_{red})+\exp(-at)(u_0-F/(a m_{red}))+\sqrt{\theta(1-\exp(-2at))/m_{red}}R`$. $`\Delta u=u(t)-u_0`$; $`p_i\mathrel{+}=m_{red}\Delta u\,e`$, $`p_j\mathrel{-}=m_{red}\Delta u\,e`$. (8.103)–(8.107).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def reducedMass8 (mi mj : ℝ) : ℝ := mi*mj/(mi+mj)
theorem reducedMass8_pos (mi mj : ℝ) (hi : 0 < mi) (hj : 0 < mj) : 0 < reducedMass8 mi mj :=
  div_pos (mul_pos hi hj) (add_pos hi hj)
def dpdPairOUPrinted (mr a F θ t u R : ℝ) : ℝ :=
  F/(a*mr)+Real.exp (-a*t)*(u-F/(a*mr))+Real.sqrt (θ*(1-Real.exp (-2*a*t))/mr)*R
def dpdPairOU_corrected (mr a F θ t u R : ℝ) : ℝ :=
  Real.exp (-a*t)*u+(F/mr)*(if a=0 then t else (1-Real.exp (-a*t))/a)+
    Real.sqrt (θ*(1-Real.exp (-2*a*t))/mr)*R
theorem dpdPairOU_zeroRate (mr F θ t u R : ℝ) :
    dpdPairOU_corrected mr 0 F θ t u R=u+(F/mr)*t := by simp [dpdPairOU_corrected]
def dpdPairMomentumStep {N d : ℕ} (i j : Fin N) (e : Vec d) (mr du : ℝ)
    (p : ParticleConfig N d) : ParticleConfig N d := p+pairImpulseVector i j ((mr*du) • e)
theorem dpdPairMomentumStep_conserves {N d : ℕ} (i j : Fin N) (e : Vec d) (mr du : ℝ)
    (p : ParticleConfig N d) : totalMomentum (dpdPairMomentumStep i j e mr du p)=totalMomentum p := by
  simp [dpdPairMomentumStep,pairImpulseVector,totalMomentum,Finset.sum_add_distrib,Finset.sum_sub_distrib]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 原印/零率延拓的OU转移公式、速度增量所用动量更新及总动量守恒。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 原印转移律要求$`mr\gt 0`$、$`a\gt 0`$、$`\theta\gt 0`$、$`t\ge0`$及R独立标准正态；F为冻结配置的成对保守力标量，FDT用于方差。
- 单对精确分布律及其随机积分推导未证明；已证明质量正性、零率值与逐对总动量代数守恒。
- [EXTRA] 零率分支仅用于涨落耗散使噪声同时退化的情形；不用于任意独立非零扩散的零漂移OU。物理转移需正约化质量、正温度、$`a,t\ge0`$及独立标准正态R。
- 覆盖缺口：单对精确分布律及其随机积分推导未证明；已证明质量正性、零率值与逐对总动量代数守恒。

### 6. 审计结论（含网站复审结论）

网站首轮：NEEDS_HUMAN。
网站复审结论：本条未进入本轮复审；保留首轮NEEDS_HUMAN意见。
原文版：Printed忠实性PASS；零率原式通常未定义。
修正版：原送审正率改写与FDT噪声同时退化的零率_corrected签名PASS。
当前：原书疑误待导师；原送审正确版本分项保留。
原书疑点：已目视核对原页PDF414：原印$`F/(am_{red})`$须$`a\gt 0`$；$`\gamma=0`$或截断外$`\omega^D=0`$时需用积分系数连续延拓。修正版显式定义$`a=0`$为自由加速，噪声退化为零。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页414。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.reducedMass8`：定义
- `MD.Ch08.reducedMass8_pos`：已证
- `MD.Ch08.dpdPairOUPrinted`：定义
- `MD.Ch08.dpdPairOU_corrected`：定义
- `MD.Ch08.dpdPairOU_zeroRate`：已证
- `MD.Ch08.dpdPairMomentumStep`：定义
- `MD.Ch08.dpdPairMomentumStep_conserves`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.3-PairwiseNoseHoover

印刷页 394 / PDF页 415。

### 1. 原文陈述

> $`dq_i=p_i\,dt/m_i`$, $`dp_i=F^c_i\,dt+\xi\tilde F^D_i\,dt`$, $`d\xi=G\,dt`$; $`G=Q^{-1}\sum_{i\lt j}\omega^D(r_{ij})[(v_{ij}\cdot e_{ij})^2-\theta/m_{red}]`$. (8.108),(8.109).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
abbrev PNHLState (N d : ℕ) := ParticlePhase N d × ℝ
def pairwiseFeedback {N d : ℕ} (m : Fin N → ℝ) (θ Q : ℝ) (wD : ℝ → ℝ)
    (q p : ParticleConfig N d) : ℝ :=
  (∑ i, ∑ j ∈ Finset.univ.filter (fun j ↦ i < j), wD (pairDistance q i j)*
    ((dot (relativeVelocity m p i j) (pairDirection q i j))^2-θ/reducedMass8 (m i) (m j)))/Q
def pnhDrift {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  (((fun i ↦ (m i)⁻¹ • z.1.2 i),
    dpdConservative α rc z.1.1+z.2 • dpdDissipative m 1 wD z.1.1 z.1.2),
   pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def isPNHSolution {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q : ℝ) (wD : ℝ → ℝ)
    (X : ℝ → PNHLState N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 < θ ∧ 0 < Q ∧
  ∀ t, 0 ≤ t → HasDerivWithinAt X (pnhDrift m α rc θ Q wD (X t)) (Ici 0) t
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | PNH场、反馈和正质量/正热浴质量的ODE规格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- Q为原文μ，$`\tilde F^D`$是$`\gamma=1`$的相对速度耗散；排除$`i=j`$，物理轨道另需非碰撞且$`\omega^D\ge0`$。
- 只落盘实际ODE规格；Galilean不变性、总动量沿轨道守恒、存在唯一性及遍历性列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页415。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.PNHLState`：定义
- `MD.Ch08.pairwiseFeedback`：定义
- `MD.Ch08.pnhDrift`：定义
- `MD.Ch08.isPNHSolution`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.3-PairwiseCanonicalWeight

印刷页 394 / PDF页 415。

### 1. 原文陈述

> $`\hat\rho_\beta=\hat Z^{-1}\exp(-\beta H(q,p))\exp(-\beta Q\xi^2/2)`$, on accessible fixed-momentum space. (8.110).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pairwiseWeight {N d : ℕ} (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ)
    (β Q : ℝ) (z : PNHLState N d) : ℝ :=
  Real.exp (-β*particleHamiltonian m U z.1)*Real.exp (-β*Q*z.2^2/2)
def pairwiseCanonicalDensity {N d : ℕ} (ν : Measure (PNHLState N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β Q : ℝ) (z : PNHLState N d) : ℝ :=
  pairwiseWeight m U β Q z/(∫ x, pairwiseWeight m U β Q x ∂ν)
def pairwiseCanonicalQualification {N d : ℕ} (ν : Measure (PNHLState N d))
    (m : Fin N → ℝ) (U : ParticleConfig N d → ℝ) (β Q : ℝ) (π : Vec d) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < β ∧ 0 < Q ∧ ν {z | totalMomentum z.1.2 ≠ π}=0 ∧
  Integrable (pairwiseWeight m U β Q) ν ∧ (0 < ∫ z, pairwiseWeight m U β Q z ∂ν) ∧
  probabilityDensity ν (pairwiseCanonicalDensity ν m U β Q)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 动量约束下扩展Gibbs权、配分积分和概率密度资格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- ν是需指定的动量叶参考测度；正有限配分积分和概率资格显式列出。
- 这里只定义权重及归一目标，不把任意支持在动量叶上的测度称为PNH不变测度。完整不变性和归一存在理论列缺口。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页415。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pairwiseWeight`：定义
- `MD.Ch08.pairwiseCanonicalDensity`：定义
- `MD.Ch08.pairwiseCanonicalQualification`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.4-PairwiseNHLSDE

印刷页 395 / PDF页 416。

### 1. 原文陈述

> PNHL adds $`d\xi=(G-\hat\gamma\xi)dt+\hat\sigma\,dW`$, $`\hat\sigma^2=2\hat\gamma\theta/Q`$, to PNH. $`W`$ is standard Wiener. (8.111),(8.112).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pnhlDrift {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  ((pnhDrift m α rc θ Q wD z).1,pairwiseFeedback m θ Q wD z.1.1 z.1.2-γ*z.2)
def pnhlNoise {N d : ℕ} (σ : ℝ) (_ : Fin 1) : PNHLState N d := ((0,0),σ)
def isPNHLSolution {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ) (wD : ℝ → ℝ)
    (P : Measure Ω) (W : ℝ → Ω → Vec 1) (X : ℝ → Ω → PNHLState N d)
    (x0 : PNHLState N d) : Prop :=
  0 < N ∧ 0 < d ∧ (∀ i, 0 < m i) ∧ 0 < rc ∧ 0 < θ ∧ 0 < Q ∧ 0 ≤ γ ∧
  σ^2=2*γ*θ/Q ∧ (∀ r, 0 ≤ wD r) ∧
  (∀ t, 0 ≤ t → ∀ᵐ sample ∂P, ∀ i j, i ≠ j → 0 < pairDistance (X t sample).1.1 i j) ∧
  additiveSDE P 1 W X x0 (pnhlDrift m α rc θ Q γ wD) (pnhlNoise σ)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 带正质量资格、涨落耗散关系及真实独立标准Wiener的PNHL积分解规格。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 实际一维标准Wiener由通用积分解规格明示；扩散仅作用ξ。
- 未证明该非碰撞解类存在、唯一、保测或遍历；“改善遍历性”是动机不是已证结论。
- 覆盖缺口：未证明该非碰撞解类存在、唯一、保测或遍历；“改善遍历性”是动机不是已证结论。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页416。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pnhlDrift`：定义
- `MD.Ch08.pnhlNoise`：定义
- `MD.Ch08.isPNHLSolution`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.4-PairwiseNHLGenerator

印刷页 395 / PDF页 416。

### 1. 原文陈述

> PNHL splits $`A,B,C,D,O`$, with $`C:\xi\tilde F^D`$, $`D:G\partial_\xi`$, $`O:-\hat\gamma\xi\partial_\xi+\hat\sigma^2\partial_\xi^2/2`$. $`L_{PNHL}=L_A+L_B+L_C+L_D+L_O`$. (8.113),(8.114).

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pnhlA {N d : ℕ} (m : Fin N → ℝ) (z : PNHLState N d) : PNHLState N d := (dpdA m z.1,0)
def pnhlB {N d : ℕ} (α rc : ℝ) (z : PNHLState N d) : PNHLState N d := (dpdB α rc z.1,0)
def pnhlC {N d : ℕ} (m : Fin N → ℝ) (wD : ℝ → ℝ) (z : PNHLState N d) : PNHLState N d :=
  ((0,z.2 • dpdDissipative m 1 wD z.1.1 z.1.2),0)
def pnhlD {N d : ℕ} (m : Fin N → ℝ) (θ Q : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d := ((0,0),pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def pnhlO {N d : ℕ} (γ : ℝ) (z : PNHLState N d) : PNHLState N d := ((0,0),-γ*z.2)
def pnhlGenerator {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ) (wD : ℝ → ℝ)
    (f : PNHLState N d → ℝ) (z : PNHLState N d) : ℝ :=
  firstOrder8 (pnhlA m) f z+firstOrder8 (pnhlB α rc) f z+firstOrder8 (pnhlC m wD) f z+
    firstOrder8 (pnhlD m θ Q wD) f z+additiveGenerator (pnhlO γ) (pnhlNoise σ 0) f z
theorem pnhlDrift_split {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : pnhlDrift m α rc θ Q γ wD z=
      pnhlA m z+pnhlB α rc z+pnhlC m wD z+pnhlD m θ Q wD z+pnhlO γ z := by
  ext <;> simp [pnhlDrift,pnhDrift,pnhlA,pnhlB,pnhlC,pnhlD,pnhlO,dpdA,dpdB,sub_eq_add_neg]
theorem pairwiseWeight_localStationary {N d : ℕ} (m : Fin N → ℝ) (α rc θ Q γ σ : ℝ)
    (hm : ∀ i, 0 < m i) (hrc : 0 < rc) (hθ : 0 < θ) (hQ : 0 < Q)
    (hγ : 0 ≤ γ) (hσ : σ^2=2*γ*θ/Q) (z : PNHLState N d)
    (hq : ∀ i j, i ≠ j → 0 < pairDistance z.1.1 i j)
    (hcut : ∀ i j, i ≠ j → pairDistance z.1.1 i j ≠ rc) :
    -textbookDivergence (fun x ↦ pairwiseWeight m (dpdPotential α rc) θ⁻¹ Q x •
      pnhlDrift m α rc θ Q γ (fun r ↦ (dpdWeightR rc r)^2) x) z+
      σ^2/2*deriv (deriv (fun s ↦ pairwiseWeight m (dpdPotential α rc) θ⁻¹ Q (z.1,s))) z.2=0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 五子场、形式生成元、漂移分解；扩展权的局部驻定目标。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 驻定式只为非碰撞、离开截断界面的局部光滑目标；全局保测需边界、半群等理论。
- 没有以漂移分解恒等式替代驻定或遍历性证明；两者分别列状态。
- 覆盖缺口：没有以漂移分解恒等式替代驻定或遍历性证明；两者分别列状态。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页416。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pnhlA`：定义
- `MD.Ch08.pnhlB`：定义
- `MD.Ch08.pnhlC`：定义
- `MD.Ch08.pnhlD`：定义
- `MD.Ch08.pnhlO`：定义
- `MD.Ch08.pnhlGenerator`：定义
- `MD.Ch08.pnhlDrift_split`：已证
- `MD.Ch08.pairwiseWeight_localStationary`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.9.4-PNHLSplittingAlgorithms

印刷页 396 / PDF页 417。

### 1. 原文陈述

> PNHL-S: $`A^{1/2}B^{1/2}C^{1/2}D^{1/2}OD^{1/2}C^{1/2}B^{1/2}A^{1/2}`$; PNHL-N: $`A^{1/2}B^{1/2}C^{1/2}D^{1/2}OD^{1/2}C^{1/2}A^{1/2}B^{1/2}`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def pnhlAStep {N d : ℕ} (m : Fin N → ℝ) (h : ℝ) (z : PNHLState N d) : PNHLState N d :=
  (((fun i ↦ z.1.1 i+(h/m i) • z.1.2 i),z.1.2),z.2)
def pnhlBStep {N d : ℕ} (α rc h : ℝ) (z : PNHLState N d) : PNHLState N d :=
  ((z.1.1,z.1.2+h • dpdConservative α rc z.1.1),z.2)
def pnhlDStep {N d : ℕ} (m : Fin N → ℝ) (θ Q h : ℝ) (wD : ℝ → ℝ)
    (z : PNHLState N d) : PNHLState N d :=
  (z.1,z.2+h*pairwiseFeedback m θ Q wD z.1.1 z.1.2)
def pnhlOStep {N d : ℕ} (θ Q γ h R : ℝ) (z : PNHLState N d) : PNHLState N d :=
  (z.1,Real.exp (-γ*h)*z.2+Real.sqrt (θ/Q*(1-Real.exp (-2*γ*h)))*R)
def pnhlPairCStep {N d : ℕ} (i j : Fin N) (m : Fin N → ℝ) (h : ℝ)
    (wD : ℝ → ℝ) (z : PNHLState N d) : PNHLState N d :=
  let mr := reducedMass8 (m i) (m j)
  let e := pairDirection z.1.1 i j
  let u := dot e (relativeVelocity m z.1.2 i j)
  let du := u*(Real.exp (-z.2*wD (pairDistance z.1.1 i j)*h/mr)-1)
  ((z.1.1,dpdPairMomentumStep i j e mr du z.1.2),z.2)
def pnhlSComposition {E : Type*} (A B C D O : ℝ → E → E) (h : ℝ) : E → E :=
  A (h/2) ∘ B (h/2) ∘ C (h/2) ∘ D (h/2) ∘ O h ∘ D (h/2) ∘ C (h/2) ∘ B (h/2) ∘ A (h/2)
def pnhlNComposition {E : Type*} (A B C D O : ℝ → E → E) (h : ℝ) : E → E :=
  A (h/2) ∘ B (h/2) ∘ C (h/2) ∘ D (h/2) ∘ O h ∘ D (h/2) ∘ C (h/2) ∘ A (h/2) ∘ B (h/2)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | A/B/D/O实际更新、单对C更新和S/N的原印外层组合；全C指数与误差理论列缺口。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- O需$`\theta,Q\gt 0`$、$`\gamma,h\ge0`$及R独立标准正态；A/B/D给实际子步。C仅给逐对精确更新，全C需有序逐对近似，未冒称精确全流。
- 两组合保留原印因子顺序；不证明全方法弱阶、不变分布误差或非对称方法更优的经验结论。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页417。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.pnhlAStep`：定义
- `MD.Ch08.pnhlBStep`：定义
- `MD.Ch08.pnhlDStep`：定义
- `MD.Ch08.pnhlOStep`：定义
- `MD.Ch08.pnhlPairCStep`：定义
- `MD.Ch08.pnhlSComposition`：定义
- `MD.Ch08.pnhlNComposition`：定义

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.10-BerendsenRelaxation

印刷页 396–397 / PDF页 417–418。

### 1. 原文陈述

> $`\dot T(t)=\gamma_T(T_{target}-T(t))`$, $`\gamma_T\gt 0`$. After Verlet, $`p\leftarrow\sqrt{1+\gamma_T h(N_d k_B T/\lVert p\rVert^2-1)}p`$.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def berendsenTemperature (θ T0 γ t : ℝ) : ℝ := θ+(T0-θ)*Real.exp (-γ*t)
theorem berendsenTemperature_derivative (θ T0 γ t : ℝ) :
    HasDerivAt (berendsenTemperature θ T0 γ) (γ*(θ-berendsenTemperature θ T0 γ t)) t := by
  convert (hasDerivAt_const t θ).add (((hasDerivAt_id t).const_mul (-γ)).exp.const_mul (T0-θ)) using 1
  · ext x
    dsimp [berendsenTemperature]
  · dsimp [berendsenTemperature]
    ring
def berendsenRadicand (nd θ γ h E : ℝ) : ℝ := 1+γ*h*(nd*θ/E-1)
def berendsenScale {n : ℕ} (θ γ h : ℝ) (p : Vec n) : Vec n :=
  Real.sqrt (berendsenRadicand n θ γ h (dot p p)) • p
def berendsenScaleQualification {n : ℕ} (θ γ h : ℝ) (p : Vec n) : Prop :=
  0 < n ∧ 0 < θ ∧ 0 < γ ∧ 0 ≤ h ∧ 0 < dot p p ∧ 0 ≤ berendsenRadicand n θ γ h (dot p p)
theorem dot_smul_same {n : ℕ} (c : ℝ) (p : Vec n) : dot (c • p) (c • p)=c^2*dot p p := by
  simp only [dot,Pi.smul_apply,smul_eq_mul,Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i hi
  ring
theorem berendsenScale_energy {n : ℕ} (θ γ h : ℝ) (p : Vec n)
    (hq : berendsenScaleQualification θ γ h p) :
    dot (berendsenScale θ γ h p) (berendsenScale θ γ h p)=
      (1-γ*h)*dot p p+γ*h*n*θ := by
  rw [berendsenScale,dot_smul_same,Real.sq_sqrt hq.2.2.2.2.2]
  dsimp [berendsenRadicand]
  field_simp [ne_of_gt hq.2.2.2.2.1]
  <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | Berendsen温度方程的显式解、动量缩放、有效域和单次能量恒等式。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 取单位粒子质量的Euclidean动量平方和；有效域显式要求非零动量及非负根号，避免将总化sqrt/division当作物理方法。
- 只证明所印温度ODE的显式解及动量缩放能量恒等式；不声称温度控制必然正则采样。完整Verlet耦合的统计行为未证。
- 覆盖缺口：只证明所印温度ODE的显式解及动量缩放能量恒等式；不声称温度控制必然正则采样。完整Verlet耦合的统计行为未证。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页417–418。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.berendsenTemperature`：定义
- `MD.Ch08.berendsenTemperature_derivative`：已证
- `MD.Ch08.berendsenRadicand`：定义
- `MD.Ch08.berendsenScale`：定义
- `MD.Ch08.berendsenScaleQualification`：定义
- `MD.Ch08.dot_smul_same`：已证
- `MD.Ch08.berendsenScale_energy`：已证

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.10-CanonicalTotalMomentumGaussian

印刷页 397–398 / PDF页 418–419。

### 1. 原文陈述

> In Euclidean canonical equilibrium, total momenta are sums of independent centered normal particle momenta and hence are centered normal.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
theorem totalMomentum_gaussian {N d : ℕ} (P : Measure Ω) [IsProbabilityMeasure P]
    (p : Ω → ParticleConfig N d) (m : Fin N → ℝ) (θ : ℝ)
    (hm : ∀ i, 0 < m i) (hθ : 0 < θ) (a : Fin d)
    (hind : iIndepFun (fun i sample ↦ p sample i a) P)
    (hlaw : ∀ i, HasLaw (fun sample ↦ p sample i a)
      (gaussianReal 0 (Real.toNNReal (m i*θ))) P) :
    HasLaw (fun sample ↦ totalMomentum (p sample) a)
      (gaussianReal 0 (Real.toNNReal ((∑ i, m i)*θ))) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 实际独立Gaussian动量假设下的一坐标总动量分布；非采样收敛定理。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 结论明确以各粒子坐标的独立正则Gaussian分布为前提；不从“系统遍历”直接推出有限时刻分布。
- 原页比较直方图和轨迹属于经验试验，未转为普适数学断言。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页418–419。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.totalMomentum_gaussian`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

## MD-8.10-NHLTotalMomentumSign

印刷页 398 / PDF页 419。

### 1. 原文陈述

> With central forces and an NHL thermostat, total momentum obeys $`\dot P=-\xi P`$, so each component keeps the sign of its initial value.

对应原页全文逐字保留在原文JSON；摘要中的[EXTRA]与修正解释不替换原文。

### 2. 原文证明

> 对应原页推导逐字保存在statement_verbatim/original_page_text；排版以原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立列出）

```lean
def nhlMomentumFactor (ξ : ℝ → ℝ) (t : ℝ) : ℝ := Real.exp (-(∫ s in (0 : ℝ)..t, ξ s))
theorem nhlMomentumFactor_pos (ξ : ℝ → ℝ) (t : ℝ) : 0 < nhlMomentumFactor ξ t := Real.exp_pos _
theorem nhlMomentum_sign (ξ : ℝ → ℝ) (P0 : ℝ) (t : ℝ) :
    (0 < nhlMomentumFactor ξ t*P0 ↔ 0 < P0) ∧
    (nhlMomentumFactor ξ t*P0 < 0 ↔ P0 < 0) := by
  constructor
  · exact mul_pos_iff_of_pos_left (nhlMomentumFactor_pos ξ t)
  · constructor
    · intro h
      by_contra hp
      have hp' : 0 ≤ P0 := le_of_not_gt hp
      have hn := mul_nonneg (le_of_lt (nhlMomentumFactor_pos ξ t)) hp'
      linarith
    · intro h
      exact mul_neg_of_pos_of_neg (nhlMomentumFactor_pos ξ t) h
theorem nhlTotalMomentum_odeSolution (ξ P : ℝ → ℝ) (hξ : Continuous ξ)
    (hP : ∀ t, HasDerivAt P (-ξ t*P t) t) (t : ℝ) :
    P t=nhlMomentumFactor ξ t*P 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 本条数学成分 | 总动量标量ODE解目标、正指数因子及显式表达式的符号保持。 |
| 对象、量词、前提及结论 | 见完整声明；补充资格在[EXTRA]列明 |

### 5. [EXTRA] 与覆盖缺口

- 只对连续ξ及实际标量ODE声明解公式，正指数乘子的符号结论已证；从NHL粒子SDE推出总动量ODE仍需成对力抵消及积分方程桥接。
- 欧氏空间正负动量不变与特殊初值下遍历性的讨论不扩展为任意系统的遍历性反例。

### 6. 审计结论（含网站复审结论）

网站首轮：PASS。
网站复审结论：本条未进入本轮复审；保留首轮PASS意见。
原文版：见原网站逐项意见；不凭整组状态推定原印真值。
修正版：未单列修正版则不推定分项PASS。
当前：网站PASS（首轮声明未变）。
原书疑点：本条未单列公式疑误。
原页核对历史证据见blueprint/ch08/closeout31/PDF_VISUAL_CHECKS.json及blueprint/ch08/source_page_checks.json；原书PDF页419。本轮不虚称重新目视。

### 7. 状态与证明位置

- `MD.Ch08.nhlMomentumFactor`：定义
- `MD.Ch08.nhlMomentumFactor_pos`：已证
- `MD.Ch08.nhlMomentum_sign`：已证
- `MD.Ch08.nhlTotalMomentum_odeSolution`：未证；缺大型理论

位置：Blueprint/Ch08.lean。Lean字节未改，复用已绑定的396声明编译和逐条公理证据；完整检查另见32号报告。

