[上一部分](part07.zh-CN.md) / [目录](../../CH07_BLUEPRINT.zh-CN.md) / [下一部分](part09.zh-CN.md)

## MD-7.12-ConstrainedHOSplitting

印刷页 318 / PDF页 339。

### 1. 原文陈述

> We could instead consider splitting the dynamics up and performing the integration using a splitting method. One uses

$$
H_c:\quad dq=M^{-1}pdt,\quad dp=-\nabla U(q)dt-g'(q)^T\lambda dt,\quad g(q)=0,
$$



$$
O_c:\quad dq=0,\quad dp=-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\quad g(q)=0.
$$


> We solve these two pieces symmetrically, where the constrained Hamiltonian part is solved over a step $`h`$, in between two solves of the Ornstein-Uhlenbeck SDE with stepsize $`h/2`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def constrainedHField {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def constrainedOField {l : ℕ} (g : V n → V l) (γ : ℝ) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -γ*x.2 i-constraintReaction g x.1 multiplier i)
def constrainedHOComposition {E : Type*} (H O : ℝ → E → E) (h : ℝ) : E → E := O (h/2) ∘ H h ∘ O (h/2)

def constrainedONoise (m : V n) (γ θ : ℝ) (j : Fin n) : Phase n :=
  (0,fun i ↦ if i=j then Real.sqrt (2*γ*θ*m i) else 0)

def constrainedHIntegralStep {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (X : ℝ → Phase n) (Λ : ℝ → V l) (x0 : Phase n) (T : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ ContDiff ℝ 2 g ∧ ContDiff ℝ 1 U ∧ 0 ≤ T ∧
  ContinuousOn X (Icc 0 T) ∧ X 0=x0 ∧
  (∀ t ∈ Icc 0 T, X t ∈ cotangentConstraint m g) ∧
  ∀ i, IntervalIntegrable (fun t ↦ (X t).2 i/m i) volume 0 T ∧
    IntervalIntegrable (fun t ↦ -gradient U (X t).1 i-
      constraintReaction g (X t).1 (Λ t) i) volume 0 T ∧
    ∀ t ∈ Icc 0 T,
      (X t).1 i=x0.1 i+∫ s in (0 : ℝ)..t, (X s).2 i/m i ∧
      (X t).2 i=x0.2 i+∫ s in (0 : ℝ)..t,
        -gradient U (X s).1 i-constraintReaction g (X s).1 (Λ s) i

/-- O乘子冲量允许含随机部分；不把它限为有限变差的λdt。 -/
def constrainedOIntegralStep {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n)
    (reactionImpulse : ℝ → Ω → V n) (x0 : Phase n) (T : ℝ) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ ContDiff ℝ 2 g ∧ 0 ≤ T ∧
  (∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P, X t sample ∈ cotangentConstraint m g) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Icc 0 T) ∧
    X 0 sample=x0 ∧ reactionImpulse 0 sample=0) ∧
  (∀ sample i, IntervalIntegrable (fun t ↦ -γ*(X t sample).2 i) volume 0 T) ∧
  (∀ sample t, ∃ impulseCoeff : V l, reactionImpulse t sample=constraintReaction g x0.1 impulseCoeff) ∧
  (∀ t ∈ Icc 0 T, Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t) ∧
    Measurable[MeasurableSpace.comap (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance]
      (reactionImpulse t)) ∧
  ∀ t ∈ Icc 0 T, ∀ᵐ sample ∂P,
    (X t sample).1=x0.1 ∧ ∀ i,
      (X t sample).2 i=x0.2 i+(∫ s in (0 : ℝ)..t, -γ*(X s sample).2 i)-
        reactionImpulse t sample i+Real.sqrt (2*γ*θ*m i)*(W t sample i-W 0 sample i)

def constrainedHMapQualification {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (H : ℝ → Phase n → Phase n) : Prop :=
  (∀ T, 0 ≤ T → Measurable (H T)) ∧
  ∀ x ∈ cotangentConstraint m g, ∀ T, 0 ≤ T → ∃ Λ : ℝ → V l,
    constrainedHIntegralStep m U g (fun t ↦ H t x) Λ x T

def constrainedOMapQualification {l : ℕ} (P : Measure Ω) (m : V n) (g : V n → V l)
    (γ θ : ℝ) (W : ℝ → Ω → V n) (O : ℝ → Ω → Phase n → Phase n) : Prop :=
  IsProbabilityMeasure P ∧ vectorWiener P W ∧
  (∀ T, 0 ≤ T → Measurable (fun z : Ω × Phase n ↦ O T z.1 z.2)) ∧
  ∀ x ∈ cotangentConstraint m g, ∀ T, 0 ≤ T → ∃ reaction : ℝ → Ω → V n,
    constrainedOIntegralStep P m g γ θ W (fun t sample ↦ O t sample x) reaction x T

/-- 非负步长、合规确定初值下的输出；底层概率测度明确为P.prod P。 -/
def constrainedHOQualifiedComposition {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) : Ω × Ω → Phase n :=
  fun sample ↦ O (h/2) sample.2 (H h (O (h/2) sample.1 x))

theorem constrainedHOQualifiedComposition_measurable {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) :
    Measurable (constrainedHOQualifiedComposition P m U g γ θ W H O hH hO h hh x hx) := by
  have hhalf : 0 ≤ h/2 := by positivity
  have hmO := hO.2.2.1 (h/2) hhalf
  have hfirst : Measurable (fun sample : Ω × Ω ↦ O (h/2) sample.1 x) :=
    hmO.comp (measurable_fst.prodMk measurable_const)
  exact hmO.comp (measurable_snd.prodMk ((hH.1 h hh).comp hfirst))

/-- 输出律由乘积概率上的可测推前给出；不声称已识别条件积分解。 -/
def constrainedHOOutputLaw {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) : Measure (Phase n) :=
  (P.prod P).map (constrainedHOQualifiedComposition P m U g γ θ W H O hH hO h hh x hx)

theorem constrainedHOOutput_hasLaw {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) :
    HasLaw (constrainedHOQualifiedComposition P m U g γ θ W H O hH hO h hh x hx)
      (constrainedHOOutputLaw P m U g γ θ W H O hH hO h hh x hx) (P.prod P) := by
  exact hasLaw_map (constrainedHOQualifiedComposition_measurable P m U g γ θ W H O hH hO h hh x hx).aemeasurable

theorem constrainedHOOutputLaw_probability {l : ℕ} (P : Measure Ω) (m : V n)
    (U : V n → ℝ) (g : V n → V l) (γ θ : ℝ) (W : ℝ → Ω → V n)
    (H : ℝ → Phase n → Phase n) (O : ℝ → Ω → Phase n → Phase n)
    (hH : constrainedHMapQualification m U g H)
    (hO : constrainedOMapQualification P m g γ θ W O) (h : ℝ) (hh : 0 ≤ h)
    (x : Phase n) (hx : x ∈ cotangentConstraint m g) :
    IsProbabilityMeasure (constrainedHOOutputLaw P m U g γ θ W H O hH hO h hh x hx) := by
  letI : IsProbabilityMeasure P := hO.1
  exact (constrainedHOOutput_hasLaw P m U g γ θ W H O hH hO h hh x hx).isProbabilityMeasure_iff.mp inferInstance
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | H/O漂移、O扩散、逐确定初值的约束积分解规格；资格独立要求概率测度及Wiener噪声，H对初值可测、O对样本与初值联合可测。对h≥0及合规确定初值明确P.prod P上的O-H-O输出、可测性和推前概率分布。随机初值条件解、几乎处处约束保持与完整条件转移核识别尚未建立。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Hc、Oc分别使用各自乘子，不能将相同multiplier在求和中重复扣除；Oc噪声为前条真实Wiener常扩散项，向量场仅记录漂移。
- 每段都应满足cotangentConstraint，实际流或核、Oc半群律及约束Gaussian不变性尚未证明。
- 30号修复：P为概率及W为向量Wiener独立于约束集非空性；H的初值可测与O的样本/初值联合可测。
- H/O漂移、O扩散、逐确定初值的约束积分解规格；资格独立要求概率测度及Wiener噪声，H对初值可测、O对样本与初值联合可测。对h≥0及合规确定初值明确P.prod P上的O-H-O输出、可测性和推前概率分布。随机初值条件解、几乎处处约束保持与完整条件转移核识别尚未建立。
- 覆盖缺口：未建立随机初值代入后的条件积分解、几乎处处约束保持及完整条件转移核识别；未构造分段解存在唯一性、Oc半群律或约束Gaussian不变性。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。C：HField正确记录dq=M⁻¹p与−∇U−g′ᵀλ，OField只记录dq=0和−γp−g′ᵀλ的漂移。composition在任意类型E及任意映射H/O上实现右至左O半步、H全步、O半步，顺序正确。然而完整Oc噪声√(2γkBTM)dW没有参数或扩散对象，本条也没有H/O满足各自受约束方程、g=0及隐藏约束保持的资格。映射E→E还不能直接表达随机OU核及两次独立新噪声；不能以extra\_assumptions中“前条噪声”替代本条缺失的连接签名。FAIL是完整对象/结论缺项，不要求实际流的存在证明。
网站复审结论：FAIL。漂移、扩散、分段积分解及O-H-O时间次序核对正确，且hH/hO确已连接分段规格。FAIL限于本条声明要覆盖的独立随机映射组合：规格只逐确定初值可测，没有H/O联合可测性，也未指定P.prod P上的输出随机变量/条件分布。两个坐标的函数不足以保证随机初值下的有效组合。另有原印λdt解释疑义，因此A部分仍NEEDS\_HUMAN。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：按网站审校意见修复，本地核验通过（未再送网站）。
本条实际覆盖：H/O漂移、O扩散、逐确定初值的约束积分解规格；资格独立要求概率测度及Wiener噪声，H对初值可测、O对样本与初值联合可测。对h≥0及合规确定初值明确P.prod P上的O-H-O输出、可测性和推前概率分布。随机初值条件解、几乎处处约束保持与完整条件转移核识别尚未建立。

### 7. 状态与证明位置

- `MD.Ch07.constrainedHField`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedOField`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOComposition`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedONoise`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHIntegralStep`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedOIntegralStep`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHMapQualification`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedOMapQualification`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOQualifiedComposition`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOQualifiedComposition_measurable`：已证；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOOutputLaw`：定义；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOOutput_hasLaw`：已证；网站：按意见修复，本地核验通过（未再送网站）
- `MD.Ch07.constrainedHOOutputLaw_probability`：已证；网站：按意见修复，本地核验通过（未再送网站）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12-MEVMEAlgorithm

印刷页 318–319 / PDF页 339–340。

### 1. 原文陈述

> Midpoint Euler - Verlet - Midpoint Euler (see [232])

$$
p_{n+1/4}=p_n-\tfrac{h\gamma}4(p_n+p_{n+1/4})+\sqrt{h\gamma k_BTM}R_n-g'(q_n)^T\lambda_{n+1/4},\quad g'(q_n)M^{-1}p_{n+1/4}=0.
$$



$$
p_{n+1/2}=p_{n+1/4}-\tfrac h2\nabla U(q_n)-g'(q_n)^T\lambda_{n+1/2},\quad q_{n+1}=q_n+hM^{-1}p_{n+1/2},
$$



$$
p_{n+3/4}=p_{n+1/2}-\tfrac h2\nabla U(q_{n+1})-g'(q_{n+1})^T\lambda_{n+3/4},\quad g'(q_{n+1})M^{-1}p_{n+3/4}=0,\quad g(q_{n+1})=0.
$$



$$
p_{n+1}=p_{n+3/4}-\tfrac{h\gamma}4(p_{n+3/4}+p_{n+1})+\sqrt{h\gamma k_BTM}R_{n+1/2}-g'(q_{n+1})^T\lambda_{n+1},\quad g'(q_{n+1})M^{-1}p_{n+1}=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def midpointConstrainedORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R out : V n) (multiplier : V l) : Prop :=
  (∀ i, out i = p i-h*γ/4*(p i+out i)+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q multiplier i) ∧
  hiddenConstraint m g (q,out)
def constrainedVerletRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (h : ℝ)
    (x out : Phase n) (ph : V n) (multiplier μ : V l) : Prop :=
  (∀ i, ph i = x.2 i-h/2*gradient U x.1 i-constraintReaction g x.1 multiplier i) ∧
  (∀ i, out.1 i = x.1 i+h/m i*ph i) ∧
  (∀ i, out.2 i = ph i-h/2*gradient U out.1 i-constraintReaction g out.1 μ i) ∧
  out ∈ cotangentConstraint m g
def mevmeRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ) (γ θ h : ℝ)
    (R S : V n) (x out : Phase n) : Prop :=
  ∃ pa ph pb : V n, ∃ multipliera multiplierb multiplierc multiplierd : V l,
    midpointConstrainedORelation m g γ θ h x.1 x.2 R pa multipliera ∧
    constrainedVerletRelation m g U h (x.1,pa) (out.1,pb) ph multiplierb multiplierc ∧
    midpointConstrainedORelation m g γ θ h out.1 pb S out.2 multiplierd
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 midpointConstrainedORelation, constrainedVerletRelation, mevmeRelation 所列对象、量词、前提和结论。范围说明：三个关系按任意维数n、约束数l逐坐标编码；θ对应k\_BT，m为对角质量。D3–D8给出真正坐标偏导、Jacobian转置反力、g′M⁻¹p=0及g=0。mevmeRelation存在量化pa/ph/pb及四组乘子，最后位置固定且终动量满足隐约束。其性质是给定R,S的代数关系；独立标准正态、正质量等应用资格按EXTRA另加，不据此宣称随机算法或解的存在唯一。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整记录全部中间动量、乘子和位置/隐约束；隐式关系不声称求解器存在唯一。R,S为独立标准Gaussian向量的资格由使用时另加vectorNormalSequence。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。三个关系按任意维数n、约束数l逐坐标编码；θ对应k\_BT，m为对角质量。D3–D8给出真正坐标偏导、Jacobian转置反力、g′M⁻¹p=0及g=0。mevmeRelation存在量化pa/ph/pb及四组乘子，最后位置固定且终动量满足隐约束。其性质是给定R,S的代数关系；独立标准正态、正质量等应用资格按EXTRA另加，不据此宣称随机算法或解的存在唯一。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 midpointConstrainedORelation, constrainedVerletRelation, mevmeRelation 所列对象、量词、前提和结论。范围说明：三个关系按任意维数n、约束数l逐坐标编码；θ对应k\_BT，m为对角质量。D3–D8给出真正坐标偏导、Jacobian转置反力、g′M⁻¹p=0及g=0。mevmeRelation存在量化pa/ph/pb及四组乘子，最后位置固定且终动量满足隐约束。其性质是给定R,S的代数关系；独立标准正态、正质量等应用资格按EXTRA另加，不据此宣称随机算法或解的存在唯一。

### 7. 状态与证明位置

- `MD.Ch07.midpointConstrainedORelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedVerletRelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.mevmeRelation`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12-MidpointStabilityPrinted

印刷页 319 / PDF页 340。

### 1. 原文陈述

> The Lagrange multiplier $`\lambda_{n+1/4}`$ (and likewise $`\lambda_{n+1}`$) can be obtained by solving the linear system

$$
g'(q_n)M^{-1}[(1-h\gamma/4)p_n+\sqrt{h\gamma k_BTM}R_n-g'(q_n)^T\lambda_{n+1/4}]=0,
$$


> which is easily computed once the $`R_n`$ vector is evaluated in the step, and gives us a stability criterion

$$
\gamma h\lt 4.\tag{7.46}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def multiplierLinearSystem {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (q p R : V n) (multiplier : V l) : Prop :=
  hiddenConstraint m g (q,fun i ↦ (1-h*γ/4)*p i+Real.sqrt (h*γ*θ*m i)*R i-constraintReaction g q multiplier i)
def midpointAmplification (a : ℝ) : ℝ := (1-a/4)/(1+a/4)
def midpointStabilityPrinted (a : ℝ) : Prop := a < 4
theorem midpointStabilityPrinted_corrected (a : ℝ) (ha : 0 ≤ a) : |midpointAmplification a| ≤ 1 := by
  unfold midpointAmplification
  rw [abs_le]
  constructor
  · apply (le_div_iff₀ (by positivity : 0 < 1+a/4)).2
    nlinarith
  · apply (div_le_iff₀ (by positivity : 0 < 1+a/4)).2
    nlinarith
theorem midpointStability_counterexample : |midpointAmplification 8| ≤ 1 ∧ ¬ (8 : ℝ) < 4 := by
  norm_num [midpointAmplification]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 multiplierLinearSystem, midpointAmplification, midpointStabilityPrinted, midpointStabilityPrinted\_corrected, midpointStability\_counterexample 所列对象、量词、前提和结论。范围说明：multiplierLinearSystem与D7展开后正是原式，无遗漏的分母；中点求解产生的公共因子不影响零约束。Printed仅定义a<4，未伪造充要稳定性。corrected对所有a≥0给出单独OU放大因子绝对值≤1，counterexample在a=8给出同一性质且8不小于4，均正确。不能用这个例子否定整套Verlet算法的充分限制，EXTRA对此区分正确。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 原文版仅保留γh<4条件，不增添充要关系；补充结论仅针对中点OU衰减模态。a=8说明γh<4不是该单独模态稳定的必要条件，不反驳原书整套算法的充分条件。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。multiplierLinearSystem与D7展开后正是原式，无遗漏的分母；中点求解产生的公共因子不影响零约束。Printed仅定义a<4，未伪造充要稳定性。corrected对所有a≥0给出单独OU放大因子绝对值≤1，counterexample在a=8给出同一性质且8不小于4，均正确。不能用这个例子否定整套Verlet算法的充分限制，EXTRA对此区分正确。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 multiplierLinearSystem, midpointAmplification, midpointStabilityPrinted, midpointStabilityPrinted\_corrected, midpointStability\_counterexample 所列对象、量词、前提和结论。范围说明：multiplierLinearSystem与D7展开后正是原式，无遗漏的分母；中点求解产生的公共因子不影响零约束。Printed仅定义a<4，未伪造充要稳定性。corrected对所有a≥0给出单独OU放大因子绝对值≤1，counterexample在a=8给出同一性质且8不小于4，均正确。不能用这个例子否定整套Verlet算法的充分限制，EXTRA对此区分正确。

### 7. 状态与证明位置

- `MD.Ch07.multiplierLinearSystem`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.midpointAmplification`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.midpointStabilityPrinted`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.midpointStabilityPrinted_corrected`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.midpointStability_counterexample`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12.1-ConstrainedABOSplitting

印刷页 319–320 / PDF页 340–341。

### 1. 原文陈述


$$
A_c:\quad dq=M^{-1}pdt,\quad dp=-g'(q)^T\lambda dt,\quad g(q)=0,
$$



$$
B_c:\quad dq=0,\quad dp=-\nabla U(q)dt-g'(q)^T\lambda dt,\quad g(q)=0,
$$



$$
O_c:\quad dq=0,\quad dp=-\gamma pdt+\sqrt{2\gamma k_BTM}dW-g'(q)^T\lambda dt,\quad g(q)=0.
$$


> Observe that the holonomic constraint (as well as the hidden constraint) is maintained in each part, changing the usual A piece into a geodesic drift along the manifold defined by $`g(q)=0`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def constrainedAField {l : ℕ} (m : V n) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (fun i ↦ x.2 i/m i,fun i ↦ -constraintReaction g x.1 multiplier i)
def constrainedBField {l : ℕ} (U : V n → ℝ) (g : V n → V l) (multiplier : V l) (x : Phase n) : Phase n :=
  (0,fun i ↦ -gradient U x.1 i-constraintReaction g x.1 multiplier i)
def geodesicConstraintFlow {l : ℕ} (m : V n) (g : V n → V l) (F : ℝ → Phase n → Phase n) : Prop :=
  (∀ x, F 0 x = x) ∧ (∀ s t x, F (s+t) x = F s (F t x)) ∧
  ∀ x ∈ cotangentConstraint m g, ∃ multiplier : ℝ → V l, ∀ t,
    F t x ∈ cotangentConstraint m g ∧ HasDerivAt (fun s ↦ F s x) (constrainedAField m g (multiplier t) (F t x)) t
def constrainedKickRelation {l : ℕ} (m : V n) (U : V n → ℝ) (g : V n → V l)
    (h : ℝ) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ multiplier : V l, (∀ i, out.2 i = x.2 i-h*gradient U x.1 i-constraintReaction g x.1 multiplier i) ∧
    out ∈ cotangentConstraint m g
def constrainedExactORelation {l : ℕ} (m : V n) (g : V n → V l) (γ θ h : ℝ)
    (R : V n) (x out : Phase n) : Prop :=
  out.1 = x.1 ∧ ∃ multiplier : V l, (∀ i, out.2 i = ouMomentum m γ θ h x.2 R i-constraintReaction g x.1 multiplier i) ∧
    out ∈ cotangentConstraint m g
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 constrainedAField, constrainedBField, geodesicConstraintFlow, constrainedKickRelation, constrainedExactORelation 所列对象、量词、前提和结论。范围说明：Ac、Bc反力符号及零位置漂移正确；geodesicConstraintFlow对全部时间给出流合成律，并仅在余切约束初值上要求导数方程与约束保持。Bc的积分反力吸收到乘子中。Oc由D9及constrainedExactORelation给出固定位置下精确OU再作质量度量约束投影的关系，与本节求解方式一致。θ=k\_BT，R的Gaussian资格及正质量/满秩等在EXTRA明确另加；未把隐式可解性当成结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Ac为已存在的完整光滑约束流，F0=id及流合成律完整；Bc/Oc为乘子线性求解关系。规则保持约束写在关系中，不把乘子求解存在性计为已证。
- 正质量、约束Jacobian满秩和γ≥0,θ>0,h≥0由求解器应用时另加；Oc噪声R必须独立标准Gaussian。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。Ac、Bc反力符号及零位置漂移正确；geodesicConstraintFlow对全部时间给出流合成律，并仅在余切约束初值上要求导数方程与约束保持。Bc的积分反力吸收到乘子中。Oc由D9及constrainedExactORelation给出固定位置下精确OU再作质量度量约束投影的关系，与本节求解方式一致。θ=k\_BT，R的Gaussian资格及正质量/满秩等在EXTRA明确另加；未把隐式可解性当成结论。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 constrainedAField, constrainedBField, geodesicConstraintFlow, constrainedKickRelation, constrainedExactORelation 所列对象、量词、前提和结论。范围说明：Ac、Bc反力符号及零位置漂移正确；geodesicConstraintFlow对全部时间给出流合成律，并仅在余切约束初值上要求导数方程与约束保持。Bc的积分反力吸收到乘子中。Oc由D9及constrainedExactORelation给出固定位置下精确OU再作质量度量约束投影的关系，与本节求解方式一致。θ=k\_BT，R的Gaussian资格及正质量/满秩等在EXTRA明确另加；未把隐式可解性当成结论。

### 7. 状态与证明位置

- `MD.Ch07.constrainedAField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedBField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.geodesicConstraintFlow`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedKickRelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedExactORelation`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12.1-ConstrainedBAOABAlgorithm

印刷页 320 / PDF页 341。

### 1. 原文陈述

> c-$`[BAOAB]`$

$$
p_{n+1/5}=p_n-\tfrac h2\nabla U(q_n)-g'(q_n)^T\lambda_{n+1/3},\quad g'(q_n)M^{-1}p_{n+1/5}=0.
$$


> Solve the geodesic flow $`A_c`$ for $`h/2`$, and map $`[q_n,p_{n+1/5}]\to[q_{n+1/2},p_{n+2/5}]`$.

$$
p_{n+3/5}=e^{-\gamma h}p_{n+2/5}+\sqrt{(1-e^{-2\gamma h})k_BTM}R_n-g'(q_{n+1/2})^T\lambda_{n+2/3},\quad g'(q_{n+1/2})M^{-1}p_{n+3/5}=0.
$$


> Solve the geodesic flow $`A_c`$ for $`h/2`$, and map $`[q_{n+1/2},p_{n+3/5}]\to[q_{n+1},p_{n+4/5}]`$.

$$
p_{n+1}=p_{n+4/5}-\tfrac h2\nabla U(q_{n+1})-g'(q_{n+1})^T\lambda_{n+1},\quad g'(q_{n+1})M^{-1}p_{n+1}=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def constrainedBAOABRelation {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n) : Prop :=
  geodesicConstraintFlow m g F ∧ ∃ b o : Phase n,
    constrainedKickRelation m U g (h/2) x b ∧
    constrainedExactORelation m g γ θ h R (F (h/2) b) o ∧
    constrainedKickRelation m U g (h/2) (F (h/2) o) out
theorem constrainedBAOAB_constraint {l : ℕ} (m : V n) (g : V n → V l) (U : V n → ℝ)
    (F : ℝ → Phase n → Phase n) (γ θ h : ℝ) (R : V n) (x out : Phase n)
    (hs : constrainedBAOABRelation m g U F γ θ h R x out) : out ∈ cotangentConstraint m g := by
  obtain ⟨_,b,o,_,_,hout⟩ := hs
  exact hout.2.choose_spec.2
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 constrainedBAOABRelation, constrainedBAOAB\_constraint 所列对象、量词、前提和结论。范围说明：关系包含B(h/2)→F(h/2)→O(h)→F(h/2)→B(h/2)，中间相点b,o存在量化，另外两相点由F表达，无需独立命名。D11–D13保留全体位置及隐约束。终点约束定理只从最后kick取出out∈cotangentConstraint，结论范围准确，没有声称二阶或不变测度。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整五段关系、全部中间变量与隐约束；仅证明成功求解后的终点资格，不证明隐式解存在、唯一或概率不变性。网站包须同时摘录geodesicConstraintFlow、两求解关系和选择规格。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。关系包含B(h/2)→F(h/2)→O(h)→F(h/2)→B(h/2)，中间相点b,o存在量化，另外两相点由F表达，无需独立命名。D11–D13保留全体位置及隐约束。终点约束定理只从最后kick取出out∈cotangentConstraint，结论范围准确，没有声称二阶或不变测度。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 constrainedBAOABRelation, constrainedBAOAB\_constraint 所列对象、量词、前提和结论。范围说明：关系包含B(h/2)→F(h/2)→O(h)→F(h/2)→B(h/2)，中间相点b,o存在量化，另外两相点由F表达，无需独立命名。D11–D13保留全体位置及隐约束。终点约束定理只从最后kick取出out∈cotangentConstraint，结论范围准确，没有声称二阶或不变测度。

### 7. 状态与证明位置

- `MD.Ch07.constrainedBAOABRelation`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.constrainedBAOAB_constraint`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.12.1-ApproximateGeodesicOrder

印刷页 320 / PDF页 341。

### 1. 原文陈述

> We do not necessarily need to solve the geodesic flow exactly in practice, though for the purposes of analysis we shall assume we do. If we are considering a second order scheme, then solving the $`A_c`$ piece to at least second order would be sufficient to preserve the overall order of the scheme, although a scheme may have potentially better accuracy and stability properties if a higher order solve is used.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def localMapErrorBound {E : Type*} [NormedAddCommGroup E] (F G : ℝ → E → E) (D : Set E) (r : ℕ) : Prop :=
  ∃ C ≥ 0, ∃ δ > 0, ∀ h ∈ Set.Ioo 0 δ, ∀ x ∈ D, ‖F h x-G h x‖ ≤ C*h^(r+1)
def geodesicReplacementSecondOrder {E : Type*} [NormedAddCommGroup E]
    (exact approx : ℝ → E → E) (D : Set E) : Prop := localMapErrorBound exact approx D 2
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 用实际范数误差与统一C,δ明确二阶局部替换资格。完整对称随机组合需稳定性、Lipschitz、矩界及采用强阶/弱阶的区分，原段未列齐；此处不把定义当作保阶定理。
- 29号覆盖限定：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。
- 覆盖缺口：29号覆盖限定：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。localMapErrorBound对同一C≥0、δ>0以及全部0<h<δ、x∈D给出O(h^(r+1))误差；r=2即局部O(h³)，定义本身合理。但geodesicReplacementSecondOrder只是该定义的别名，无任何组合方法、随机强/弱误差、稳定性前提或整体二阶结论。EXTRA诚实说明缺口，却不能使“本条全部数学对象与公式”的statement\_scope成立。FAIL基于完整结论缺失，与是否有sorry无关。
网站复审结论：PASS。按本条明确声明的“一致局部O(h³)误差资格定义”范围，域、范数、全部量词和r+1指数均正确。两个def未声称替换后整体二阶，故不以缺少该定理否定其已缩小范围的签名。原文完整保阶论断仍未形式化，不能由本PASS消除该覆盖缺口。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：仅一致局部O(h³)误差资格定义；原文替换测地流后整体保二阶的命题未形式化。

### 7. 状态与证明位置

- `MD.Ch07.localMapErrorBound`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.geodesicReplacementSecondOrder`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-FastSlowHarmonicModel

印刷页 323 / PDF页 344。

### 1. 原文陈述


$$
H(q,p)=p^2/2+U(q),\qquad U(q)=U_F(q)+U_S(q),
$$



$$
U_S(q)=q^2/2,\qquad U_F(q)=\Omega^2q^2/2,\tag{7.47}
$$


> where $`\Omega\gg1`$.

$$
\binom{dq}{dp}=\underbrace{\binom{pdt}{-\Omega^2qdt-\gamma pdt+\sqrt{2\gamma/\beta}dW}}_{\rm Fast}+\underbrace{\binom0{-qdt}}_{\rm Slow}.\tag{7.48}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
abbrev Mat2 := Matrix (Fin 2) (Fin 2) ℝ
def fastPotential (Ω q : ℝ) : ℝ := Ω^2*q^2/2
def slowPotential (q : ℝ) : ℝ := q^2/2
def fastMatrix (Ω γ : ℝ) : Mat2 := !![0,1;-Ω^2,-γ]
def slowMatrix (h : ℝ) : Mat2 := !![1,0;-h,1]
def fastLangevin (P : Measure Ω) (W : ℝ → Ω → V 1) (X : ℝ → Ω → Phase 1)
    (frequency γ β : ℝ) (x0 : Phase 1) : Prop :=
  0 < frequency ∧ 0 < β ∧ langevin P W X (fun q ↦ fastPotential frequency (q 0)) (fun _ ↦ 1) γ β⁻¹ x0
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 Mat2, fastPotential, slowPotential, fastMatrix, slowMatrix, fastLangevin 所列对象、量词、前提和结论。范围说明：状态为一维实位置/动量、质量1；fast/slow势与F矩阵正确，slowMatrix是慢子系统精确流。D15、D20展开后快SDE具有适应性、连续轨道、确定初值、正β、γ≥0及完整积分方程；噪声θ=β⁻¹产生所需系数。总势及H由两势与单位质量动能直接组成，未另命名。Ω≫1作为本节背景，未被错误编码为任意定量常数。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 单位质量、实际标准Wiener、状态适应、正β及完整积分方程由langevin定义体保留；Ω≫1在定量结论中分别改成明确不等式。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。状态为一维实位置/动量、质量1；fast/slow势与F矩阵正确，slowMatrix是慢子系统精确流。D15、D20展开后快SDE具有适应性、连续轨道、确定初值、正β、γ≥0及完整积分方程；噪声θ=β⁻¹产生所需系数。总势及H由两势与单位质量动能直接组成，未另命名。Ω≫1作为本节背景，未被错误编码为任意定量常数。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 Mat2, fastPotential, slowPotential, fastMatrix, slowMatrix, fastLangevin 所列对象、量词、前提和结论。范围说明：状态为一维实位置/动量、质量1；fast/slow势与F矩阵正确，slowMatrix是慢子系统精确流。D15、D20展开后快SDE具有适应性、连续轨道、确定初值、正β、γ≥0及完整积分方程；噪声θ=β⁻¹产生所需系数。总势及H由两势与单位质量动能直接组成，未另命名。Ω≫1作为本节背景，未被错误编码为任意定量常数。

### 7. 状态与证明位置

- `MD.Ch07.Mat2`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fastPotential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.slowPotential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fastMatrix`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.slowMatrix`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fastLangevin`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-ExactFastGaussianLaw

印刷页 323–324 / PDF页 344–345。

### 1. 原文陈述

> Writing $`F=\begin{bmatrix}0&1\\-\Omega^2&-\gamma\end{bmatrix}`$, we can write down the solution to the fast dynamics as

$$
\binom{q(t)}{p(t)}=\exp(Ft)\binom{q(0)}{p(0)}+B_tR,
$$


> where $`R`$ is a column vector of two i.i.d. random normal numbers distributed as $`\mathcal N(0,1)`$, and

$$
B_tB_t^T=\frac{2\gamma}\beta\int_0^t\exp(F(t-s))\begin{bmatrix}0&0\\0&1\end{bmatrix}\exp(F^T(t-s))ds.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def fastExponential (Ω γ t : ℝ) : Mat2 := NormedSpace.exp (t • fastMatrix Ω γ)
def fastCovariance (Ω γ β t : ℝ) : Mat2 := fun i j ↦ 2*γ/β*∫ s in (0 : ℝ)..t,
  (fastExponential Ω γ (t-s)* (!![0,0;0,1] : Mat2)*(fastExponential Ω γ (t-s))ᵀ) i j
theorem exactFastGaussianLaw (P : Measure Ω) (W : ℝ → Ω → V 1) (X : ℝ → Ω → Phase 1)
    (frequency γ β t : ℝ) (x0 : Phase 1) (B : Mat2)
    (hX : fastLangevin P W X frequency γ β x0) (ht : 0 ≤ t)
    (hB : B*Bᵀ = fastCovariance frequency γ β t) :
    HasLaw (fun sample ↦ (![ (X t sample).1 0, (X t sample).2 0] : Fin 2 → ℝ))
      (Measure.map (fun R : Fin 2 → ℝ ↦
        fastExponential frequency γ t *ᵥ (![x0.1 0,x0.2 0] : Fin 2 → ℝ)+B*ᵥ R)
        (Measure.pi (fun _ : Fin 2 ↦ gaussianReal 0 1))) P := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 fastExponential, fastCovariance, exactFastGaussianLaw 所列对象、量词、前提和结论。范围说明：对任意满足fastLangevin的真实过程、t≥0及任意满足BBᵀ=协方差的实2×2矩阵，结论是时刻t状态的HasLaw；乘积gaussianReal 0 1正确表达两独立标准正态。协方差末因子(exp(F(t−s)))ᵀ等于exp(Fᵀ(t−s))。确定初值、β正及γ非负由hX内含；结论是单时刻分布，不是用同一R构造整个过程。假定B因子而不证存在与EXTRA相符。sorry不影响本次签名判定。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 陈述真实过程的转移分布，不将强解等于一组新独立R假设成结论。Bt只需给定平方根因子；正半定矩阵平方根存在性未另证明。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。对任意满足fastLangevin的真实过程、t≥0及任意满足BBᵀ=协方差的实2×2矩阵，结论是时刻t状态的HasLaw；乘积gaussianReal 0 1正确表达两独立标准正态。协方差末因子(exp(F(t−s)))ᵀ等于exp(Fᵀ(t−s))。确定初值、β正及γ非负由hX内含；结论是单时刻分布，不是用同一R构造整个过程。假定B因子而不证存在与EXTRA相符。sorry不影响本次签名判定。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 fastExponential, fastCovariance, exactFastGaussianLaw 所列对象、量词、前提和结论。范围说明：对任意满足fastLangevin的真实过程、t≥0及任意满足BBᵀ=协方差的实2×2矩阵，结论是时刻t状态的HasLaw；乘积gaussianReal 0 1正确表达两独立标准正态。协方差末因子(exp(F(t−s)))ᵀ等于exp(Fᵀ(t−s))。确定初值、β正及γ非负由hX内含；结论是单时刻分布，不是用同一R构造整个过程。假定B因子而不证存在与EXTRA相符。sorry不影响本次签名判定。

### 7. 状态与证明位置

- `MD.Ch07.fastExponential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fastCovariance`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.exactFastGaussianLaw`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-MultipleTimestepUpdate

印刷页 324 / PDF页 345。

### 1. 原文陈述

> The solution to the slow part of our splitting is just

$$
\binom{q(t)}{p(t)}=\begin{bmatrix}1&0\\-t&1\end{bmatrix}\binom{q(0)}{p(0)}.
$$


> For a method taking one step of the fast system followed by a step of the slow system, using fixed step size $`h\gt 0`$, we can write the update scheme for $`z=[q,p]^T`$ as

$$
z_{n+1}=Xz_n+YR_n,\qquad X=\begin{bmatrix}1&0\\-h&1\end{bmatrix}\exp(hF),\quad Y=\begin{bmatrix}1&0\\-h&1\end{bmatrix}B_h.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def multipleX (Ω γ h : ℝ) : Mat2 := slowMatrix h*fastExponential Ω γ h
def multipleY (h : ℝ) (B : Mat2) : Mat2 := slowMatrix h*B
def multipleStep (Ω γ h : ℝ) (B : Mat2) (R z : Fin 2 → ℝ) : Fin 2 → ℝ :=
  multipleX Ω γ h *ᵥ z+multipleY h B *ᵥ R
theorem multipleStep_composition (Ω γ h : ℝ) (B : Mat2) (R z : Fin 2 → ℝ) :
    multipleStep Ω γ h B R z = slowMatrix h *ᵥ (fastExponential Ω γ h *ᵥ z+B*ᵥ R) := by
  simp [multipleStep,multipleX,multipleY,Matrix.mulVec_add,Matrix.mulVec_mulVec]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 multipleX, multipleY, multipleStep, multipleStep\_composition 所列对象、量词、前提和结论。范围说明：multipleX=S(h)exp(hF)、multipleY=S(h)B及向量更新保留快后慢次序。composition对所有实参数、B,R,z的代数恒等式正确，不需要h>0；将性质推广至任意实h无害。B作为前条Bh传入，Gaussian与协方差资格是作为随机步使用时的前提，当前声明仅定义给定B,R的更新，不宣称平稳分布存在。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Rn为每步独立标准二维Gaussian；稳定分布分析仍要求真实独立序列及有限协方差，不能只以更新定义宣称存在平稳解。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。multipleX=S(h)exp(hF)、multipleY=S(h)B及向量更新保留快后慢次序。composition对所有实参数、B,R,z的代数恒等式正确，不需要h>0；将性质推广至任意实h无害。B作为前条Bh传入，Gaussian与协方差资格是作为随机步使用时的前提，当前声明仅定义给定B,R的更新，不宣称平稳分布存在。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 multipleX, multipleY, multipleStep, multipleStep\_composition 所列对象、量词、前提和结论。范围说明：multipleX=S(h)exp(hF)、multipleY=S(h)B及向量更新保留快后慢次序。composition对所有实参数、B,R,z的代数恒等式正确，不需要h>0；将性质推广至任意实h无害。B作为前条Bh传入，Gaussian与协方差资格是作为随机步使用时的前提，当前声明仅定义给定B,R的更新，不宣称平稳分布存在。

### 7. 状态与证明位置

- `MD.Ch07.multipleX`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.multipleY`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.multipleStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.multipleStep_composition`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-DeterminantTrace

印刷页 324 / PDF页 345。

### 1. 原文陈述

> Denoting $`\eta=\sqrt{\gamma^2-4\Omega^2}`$, then we compute

$$
\det(X)=e^{-\gamma h},\qquad \operatorname{tr}(X)=\frac{\eta-h}{\eta}e^{(\eta-\gamma)h/2}+\frac{\eta+h}{\eta}e^{(-\eta-\gamma)h/2}.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def traceFormula (γ h : ℝ) (η : ℂ) : ℂ :=
  (η-(h : ℂ))/η*Complex.exp ((η-(γ : ℂ))*(h : ℂ)/2)+
  (η+(h : ℂ))/η*Complex.exp ((-η-(γ : ℂ))*(h : ℂ)/2)
theorem determinantTrace (Ω γ h : ℝ) (η : ℂ) (hη : η^2 = (γ : ℂ)^2-4*(Ω : ℂ)^2) (hne : η ≠ 0) :
    Matrix.det (multipleX Ω γ h) = Real.exp (-γ*h) ∧
    ((Matrix.trace (multipleX Ω γ h) : ℝ) : ℂ) = traceFormula γ h η := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 traceFormula, determinantTrace 所列对象、量词、前提和结论。范围说明：任意实Ω,γ,h及复η满足η²=γ²−4Ω²且η≠0时，行列式和复数化实迹等式正确；选择另一个平方根只交换两项。取复η正确容纳欠阻尼；hne排除原式本来未定义的临界点，EXTRA已标覆盖缺口。临界η=0没有被此定理证明，不能将其当作含临界点的全域声明。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- η允许纯虚数；显式排除临界η=0，避免除零假公式。临界阻尼应取连续极限，另列覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。任意实Ω,γ,h及复η满足η²=γ²−4Ω²且η≠0时，行列式和复数化实迹等式正确；选择另一个平方根只交换两项。取复η正确容纳欠阻尼；hne排除原式本来未定义的临界点，EXTRA已标覆盖缺口。临界η=0没有被此定理证明，不能将其当作含临界点的全域声明。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 traceFormula, determinantTrace 所列对象、量词、前提和结论。范围说明：任意实Ω,γ,h及复η满足η²=γ²−4Ω²且η≠0时，行列式和复数化实迹等式正确；选择另一个平方根只交换两项。取复η正确容纳欠阻尼；hne排除原式本来未定义的临界点，EXTRA已标覆盖缺口。临界η=0没有被此定理证明，不能将其当作含临界点的全域声明。

### 7. 状态与证明位置

- `MD.Ch07.traceFormula`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.determinantTrace`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-SpectralRadiusStability

印刷页 324 / PDF页 345。

### 1. 原文陈述

> The stability of the method therefore depends solely on the spectral radius of the matrix $`X`$. This gives a stability condition

$$
\left|\frac{\eta-h}{\eta}e^{(\eta-\gamma)h/2}+\frac{\eta+h}{\eta}e^{(-\eta-\gamma)h/2}\right|\le1+e^{-\gamma h}.
$$


> Multiplying by $`e^{\gamma h/2}`$ gives

$$
|\cosh(\eta h/2)+(h/\eta)\sinh(-\eta h/2)|\le\cosh(\gamma h/2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def characteristicUnitDisk (X : Mat2) : Prop :=
  ∀ z : ℂ, z^2-((Matrix.trace X : ℝ) : ℂ)*z+((Matrix.det X : ℝ) : ℂ) = 0 → ‖z‖ ≤ 1
theorem spectralRadiusStability (X : Mat2) (hd : 0 < Matrix.det X) (hd1 : Matrix.det X < 1) :
    characteristicUnitDisk X ↔ |Matrix.trace X| ≤ 1+Matrix.det X := by
  sorry
def hyperbolicStability (γ h : ℝ) (η : ℂ) : Prop :=
  ‖Complex.cosh (η*(h : ℂ)/2)+(h : ℂ)/η*Complex.sinh (-η*(h : ℂ)/2)‖ ≤ Real.cosh (γ*h/2)

theorem multipleX_spectral_hyperbolic (Ω γ h : ℝ) (η : ℂ)
    (hγ : 0 < γ) (hh : 0 < h)
    (hη : η^2=(γ : ℂ)^2-4*(Ω : ℂ)^2) (hne : η ≠ 0) :
    characteristicUnitDisk (multipleX Ω γ h) ↔ hyperbolicStability γ h η := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只陈述谱半径≤1的确定性边界资格；有非退化随机驱动时平稳二阶矩一般要求严格谱半径<1，等号并不自动给随机长期稳定。
- 正摩擦正h给0<det<1；γ=0、Jordan边界、临界η=0均需另审。trace到双曲式的代数/指数桥未证明。
- 29号覆盖限定：实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。
- 覆盖缺口：正摩擦正h给0<det<1；γ=0、Jordan边界、临界η=0均需另审。trace到双曲式的代数/指数桥未证明。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。characteristicUnitDisk量化所有复特征根的模≤1；对实2×2矩阵且0<det<1，与|tr|≤1+det等价，抽象定理签名正确。hyperbolicStability只定义不等式；没有把multipleX、traceFormula、η²关系及η≠0联结到该条件的等价定理，故原条完整结论尚缺桥梁。EXTRA已说明此缺口，不能替代完整形式化。谱边界不等于Gaussian驱动的平稳有限方差条件。
网站复审结论：NEEDS\_HUMAN。四条Lean声明的对象、域、全部假设与结论均核对正确；在0<det X<1及γ>0,h>0,η²=γ²−4Ω²,η≠0的前提下，两个等价定理的签名成立。若只看明确缩小的确定性谱范围，可判PASS。全条依任务“原书数学疑误保留并判NEEDS\_HUMAN”的规则，仍需人工界定原印随机系统中的稳定性；不能把闭圆盘条件当成有限方差平稳性，也不能因sorry判FAIL。
按版本登记：四条闭单位圆谱声明签名PASS；不可把≤边界等同Gaussian噪声下有限二阶矩平稳性，η=0另留缺口。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：实二阶矩阵的闭单位圆谱判据及实际multipleX在γη资格下的双曲条件等价；不含Gaussian驱动有限方差平稳性。

### 7. 状态与证明位置

- `MD.Ch07.characteristicUnitDisk`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.spectralRadiusStability`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.hyperbolicStability`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.multipleX_spectral_hyperbolic`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.13-HyperbolicPhaseTransform

印刷页 324 / PDF页 345。

### 1. 原文陈述

> For $`\gamma\gt 0`$, we can simplify to

$$
\left|\cosh\left(\frac{\eta h}{2}-\operatorname{atanh}\left(\frac h\eta\right)\right)\sqrt{1-\frac{h^2}{\eta^2}}\right|\le\cosh(\gamma h/2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def hyperbolicPhase (η h : ℝ) : ℝ :=
  Real.cosh (η*h/2-Real.artanh (h/η))*Real.sqrt (1-h^2/η^2)
theorem hyperbolicPhase_identity (η h : ℝ) (hη : η ≠ 0) (hr : |h/η| < 1) :
    hyperbolicPhase η h = Real.cosh (η*h/2)-h/η*Real.sinh (η*h/2) := by
  have hh : h/η ∈ Set.Ioo (-1 : ℝ) 1 := abs_lt.mp hr
  have hs : Real.sqrt (1-(h/η)^2) ≠ 0 := by
    apply ne_of_gt
    apply Real.sqrt_pos.2
    have hsq : (h/η)^2 < 1 := (sq_lt_one_iff_abs_lt_one (h/η)).2 hr
    linarith
  simp only [hyperbolicPhase,Real.cosh_sub,Real.cosh_artanh hh,Real.sinh_artanh hh]
  rw [← div_pow]
  calc
    _ = (Real.cosh (η*h/2)-(h/η)*Real.sinh (η*h/2))/Real.sqrt (1-(h/η)^2)*Real.sqrt (1-(h/η)^2) := by ring
    _ = _ := div_mul_cancel₀ _ hs
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅实η≠0、/h/η/<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 实η版本必须补|h/η|<1，γ>0本身不足；复η需选择sqrt/artanh分支，原文未说明。只覆盖明确实域上的等式，不把所有γ>0都纳入。
- 29号覆盖限定：仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。
- 覆盖缺口：29号覆盖限定：仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。hyperbolicPhase\_identity对实η≠0及|h/η|<1的等式正确，额外实域前提明确且必要；展开cosh差公式即得cosh(a)−r sinh(a)。它没有覆盖纯虚η或实|h/η|≥1，也未给整个稳定不等式的全参数等价声明。不能由这个有效的受限等式确认原书对所有γ>0的措辞。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：仅实η≠0、|h/η|<1分支恒等式；未含复η、其他实参数或全稳定不等式等价。

### 7. 状态与证明位置

- `MD.Ch07.hyperbolicPhase`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.hyperbolicPhase_identity`：已证；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

