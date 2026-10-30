[上一部分](part01.zh-CN.md) / [目录](../../CH07_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

## MD-7.3.1-Langevin

印刷页 268 / PDF页 289。

### 1. 原文陈述

> Langevin dynamics:

$$
dq=M^{-1}pdt,\qquad dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BT}M^{1/2}dW.\tag{7.4}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def gradient (U : V n → ℝ) (q : V n) : V n := fun i ↦ coordDerivative U q i

def langevin (P : Measure Ω) (W : ℝ → Ω → V n) (X : ℝ → Ω → Phase n)
    (U : V n → ℝ) (m : V n) (γ θ : ℝ) (x0 : Phase n) : Prop :=
  vectorWiener P W ∧ (∀ i, 0 < m i) ∧ 0 ≤ γ ∧ 0 < θ ∧
  (∀ t : ℝ, 0 ≤ t → Measurable[MeasurableSpace.comap
    (fun (sample : Ω) (s : Icc (0 : ℝ) t) ↦ W s sample) inferInstance] (X t)) ∧
  (∀ᵐ sample ∂P, ContinuousOn (fun t ↦ X t sample) (Ici 0) ∧ X 0 sample = x0) ∧
  ∀ᵐ sample ∂P, ∀ t : ℝ, 0 ≤ t → ∀ i,
    IntervalIntegrable (fun s ↦ (X s sample).2 i / m i) volume 0 t ∧
    IntervalIntegrable (fun s ↦ -gradient U (X s sample).1 i - γ*(X s sample).2 i) volume 0 t ∧
    (X t sample).1 i = x0.1 i + (∫ s in 0..t, (X s sample).2 i / m i) ∧
    (X t sample).2 i = x0.2 i + (∫ s in 0..t, -gradient U (X s sample).1 i - γ*(X s sample).2 i) +
      Real.sqrt (2*γ*θ*m i) * (W t sample i - W 0 sample i)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 gradient, langevin 所列对象、量词、前提和结论。范围说明：langevin的自然历史适应、确定初值与公共几乎处处连续路径均明确；同一公共满测集上对所有非负t及全部坐标给出可积性与位置/动量积分方程。位置漂移p\_i/m\_i，动量漂移−∂_iU−γp\_i，噪声sqrt(2γθm\_i)(W\_i(t)−W\_i(0))，完整对应(7.4)。U的导数使用真实deriv总化定义，经典动力学解释限于偏导存在的势能，不声称任意U均有解。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 用真实坐标偏导与完整位置/动量积分方程表达；常扩散的Itô项即W增量乘系数；显式状态适应W自然历史、漂移可积。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。langevin的自然历史适应、确定初值与公共几乎处处连续路径均明确；同一公共满测集上对所有非负t及全部坐标给出可积性与位置/动量积分方程。位置漂移p\_i/m\_i，动量漂移−∂_iU−γp\_i，噪声sqrt(2γθm\_i)(W\_i(t)−W\_i(0))，完整对应(7.4)。U的导数使用真实deriv总化定义，经典动力学解释限于偏导存在的势能，不声称任意U均有解。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 gradient, langevin 所列对象、量词、前提和结论。范围说明：langevin的自然历史适应、确定初值与公共几乎处处连续路径均明确；同一公共满测集上对所有非负t及全部坐标给出可积性与位置/动量积分方程。位置漂移p\_i/m\_i，动量漂移−∂_iU−γp\_i，噪声sqrt(2γθm\_i)(W\_i(t)−W\_i(0))，完整对应(7.4)。U的导数使用真实deriv总化定义，经典动力学解释限于偏导存在的势能，不声称任意U均有解。

### 7. 状态与证明位置

- `MD.Ch07.gradient`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.langevin`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-HamiltonianGibbs

印刷页 269 / PDF页 290。

### 1. 原文陈述

> Since Hamiltonian dynamics leaves invariant any function of the energy, its corresponding Fokker-Planck operator (in this case the Liouvillian, $`\mathcal L_H^\dagger=-\mathcal L_H`$) will preserve distributions that are functions of the Hamiltonian $`H`$. This implies in particular that it preserves $`\rho_\beta`$, which is proportional to $`\exp(-\beta H)`$. Thus the forward propagator associated to the Hamiltonian system automatically preserves the Gibbs distribution, and we have

$$
e^{t\mathcal L_H^\dagger}\rho_\beta=\rho_\beta.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem hamiltonianGibbs {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (F : D → D) (H : D → ℝ) (β : ℝ)
    (hF : Measurable F) (hv : MeasurePreserving F ν ν)
    (hH : ∀ x, H (F x) = H x) (hweight : Measurable (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x)))) :
    Measure.map F (ν.withDensity (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x)))) =
      ν.withDensity (fun x ↦ ENNReal.ofReal (Real.exp (-β*H x))) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 hamiltonianGibbs 所列对象、量词、前提和结论。范围说明：对任意可测D、基准ν，F可测且保持ν，H逐点沿F守恒，权重可测，结论是未归一化Gibbs加权测度的真实推前不变性。能量守恒使权重与F复合不变，体积保持使积分变量替换成立；无需F可逆。存在性及体积/能量保持作为已披露前提，不是已证明一般Hamilton流存在；如称概率另需正有限配分积分。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- F为已存在的实际Hamiltonian流的固定时刻映射；显式体积保持与能量保持，结论为实际加权测度不变性。
- 本文未重证明一般Hamiltonian流存在；若需归一化为概率，须另补配分积分正有限。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。对任意可测D、基准ν，F可测且保持ν，H逐点沿F守恒，权重可测，结论是未归一化Gibbs加权测度的真实推前不变性。能量守恒使权重与F复合不变，体积保持使积分变量替换成立；无需F可逆。存在性及体积/能量保持作为已披露前提，不是已证明一般Hamilton流存在；如称概率另需正有限配分积分。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 hamiltonianGibbs 所列对象、量词、前提和结论。范围说明：对任意可测D、基准ν，F可测且保持ν，H逐点沿F守恒，权重可测，结论是未归一化Gibbs加权测度的真实推前不变性。能量守恒使权重与F复合不变，体积保持使积分变量替换成立；无需F可逆。存在性及体积/能量保持作为已披露前提，不是已证明一般Hamilton流存在；如称概率另需正有限配分积分。

### 7. 状态与证明位置

- `MD.Ch07.hamiltonianGibbs`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-ABOPieces

印刷页 269–270 / PDF页 290–291。

### 1. 原文陈述

> We therefore consider dividing the Langevin system (7.4) into parts

$$
d\binom qp=\binom{M^{-1}p}{0}dt+\binom0{-\nabla U(q)}dt+\binom0{-\gamma pdt+\sigma M^{1/2}dW},\tag{7.5}
$$


> which we label A, B, and O, where each of the three parts may be solved “exactly”, with individual updates given as

$$
\mathcal U_h^A(q,p)=(q+hM^{-1}p,p),\quad \mathcal U_h^B(q,p)=(q,p-h\nabla U(q)),\quad \mathcal U_h^O(q,p)=(q,e^{-\gamma h}p+\sqrt{k_BT(1-e^{-2\gamma h})}M^{1/2}R),
$$


> where $`R`$ is a vector of i.i.d. normal random numbers.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def driftStep (m : V n) (h : ℝ) (x : Phase n) : Phase n :=
  (fun i ↦ x.1 i + h * x.2 i / m i, x.2)

def kickStep (U : V n → ℝ) (h : ℝ) (x : Phase n) : Phase n :=
  (x.1, fun i ↦ x.2 i - h * gradient U x.1 i)

def aField (m : V n) (x : Phase n) : Phase n := (fun i ↦ x.2 i / m i, 0)
def bField (U : V n → ℝ) (x : Phase n) : Phase n := (0, fun i ↦ -gradient U x.1 i)
def oDrift (γ : ℝ) (x : Phase n) : Phase n := (0, fun i ↦ -γ*x.2 i)

theorem splittingDrift (m : V n) (U : V n → ℝ) (γ : ℝ) (x : Phase n) :
    aField m x + bField U x + oDrift γ x =
      (fun i ↦ x.2 i / m i, fun i ↦ -gradient U x.1 i - γ*x.2 i) := by
  ext i <;> simp [aField, bField, oDrift] <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 driftStep, kickStep, aField, bField, oDrift, splittingDrift 所列对象、量词、前提和结论。范围说明：aField=(M⁻¹p,0)、bField=(0,−∇U)、oDrift=(0,−γp)，splittingDrift只证明漂移和而未冒充随机扩散恒等式。driftStep、kickStep及引用ouStep给出三种更新；真实扩散与正态资格及O精确性分别由VectorOU、OUPhaseIteration、OUExactUpdate承担，A/B流另由下条承担。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- M为正对角质量；σ=√(2γk\_BT)；OU单步及独立正态资格已在OUPhaseIteration写全。
- 仅最后短定理证明漂移相加；A/B确定性精确流与O分布精确性各自另列，不用漂移恒等式替代。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。aField=(M⁻¹p,0)、bField=(0,−∇U)、oDrift=(0,−γp)，splittingDrift只证明漂移和而未冒充随机扩散恒等式。driftStep、kickStep及引用ouStep给出三种更新；真实扩散与正态资格及O精确性分别由VectorOU、OUPhaseIteration、OUExactUpdate承担，A/B流另由下条承担。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 driftStep, kickStep, aField, bField, oDrift, splittingDrift 所列对象、量词、前提和结论。范围说明：aField=(M⁻¹p,0)、bField=(0,−∇U)、oDrift=(0,−γp)，splittingDrift只证明漂移和而未冒充随机扩散恒等式。driftStep、kickStep及引用ouStep给出三种更新；真实扩散与正态资格及O精确性分别由VectorOU、OUPhaseIteration、OUExactUpdate承担，A/B流另由下条承担。

### 7. 状态与证明位置

- `MD.Ch07.driftStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.kickStep`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.aField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.bField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.oDrift`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.splittingDrift`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-ABExactFlows

印刷页 270 / PDF页 291。

### 1. 原文陈述

> For the deterministic pieces A and B, the updates correspond to their flow maps, while the update for the O piece corresponds to the solution derived in (7.3).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem driftStep_derivative (m : V n) (x : Phase n) (t : ℝ) (i : Fin n) :
    HasDerivAt (fun s ↦ (driftStep m s x).1 i) (x.2 i / m i) t := by
  simpa [driftStep, mul_div_assoc] using ((hasDerivAt_id t).mul_const (x.2 i / m i)).const_add (x.1 i)

theorem kickStep_derivative (U : V n → ℝ) (x : Phase n) (t : ℝ) (i : Fin n) :
    HasDerivAt (fun s ↦ (kickStep U s x).2 i) (-gradient U x.1 i) t := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 driftStep\_derivative, kickStep\_derivative 所列对象、量词、前提和结论。范围说明：driftStep\_derivative和kickStep\_derivative对任意固定初态、时间、坐标给出真实时间导数，另一分量恒定且t=0为初态可直接由定义读取，分别等于aField和bField沿轨道的分量。B中q恒定，故不需对U再作时间求导。O的精确性由ouTransitionLaw签名覆盖，未因其sorry判失败。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 逐坐标A位置/B动量真实时间导数；另一个分量由更新定义恒定；O精确性引用OUTransitionLaw未证陈述，不冒称全部已证。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。driftStep\_derivative和kickStep\_derivative对任意固定初态、时间、坐标给出真实时间导数，另一分量恒定且t=0为初态可直接由定义读取，分别等于aField和bField沿轨道的分量。B中q恒定，故不需对U再作时间求导。O的精确性由ouTransitionLaw签名覆盖，未因其sorry判失败。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 driftStep\_derivative, kickStep\_derivative 所列对象、量词、前提和结论。范围说明：driftStep\_derivative和kickStep\_derivative对任意固定初态、时间、坐标给出真实时间导数，另一分量恒定且t=0为初态可直接由定义读取，分别等于aField和bField沿轨道的分量。B中q恒定，故不需对U再作时间求导。O的精确性由ouTransitionLaw签名覆盖，未因其sorry判失败。

### 7. 状态与证明位置

- `MD.Ch07.driftStep_derivative`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.kickStep_derivative`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-ABForward

印刷页 270 / PDF页 291。

### 1. 原文陈述

> The relevant forward propagators for each piece of the Hamiltonian part are computed through the adjoint of the Lie derivatives as

$$
\mathcal L_A^\dagger=-M^{-1}p\cdot\nabla_q,\qquad \mathcal L_B^\dagger=\nabla U(q)\cdot\nabla_p.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def aForward (m : V n) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  -∑ i, x.2 i / m i * coordDerivative (fun q ↦ f (q,x.2)) x.1 i
def bForward (U : V n → ℝ) (f : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∑ i, gradient U x.1 i * coordDerivative (fun p ↦ f (x.1,p)) x.2 i
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 aForward, bForward 所列对象、量词、前提和结论。范围说明：aForward为−∑(p\_i/m\_i)∂_{q\_i}f，bForward为+∑∂_{q\_i}U ∂_{p\_i}f，符号及变量均匹配；系数分别对被求导变量独立，因此无遗漏的散度零阶项。仅定义形式微分表达式；边界和算子域限制已说明。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 以真实偏导定义所印微分表达式；形式伴随解释要求足够光滑及边界通量消失，未声称一般强算子域。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。aForward为−∑(p\_i/m\_i)∂_{q\_i}f，bForward为+∑∂_{q\_i}U ∂_{p\_i}f，符号及变量均匹配；系数分别对被求导变量独立，因此无遗漏的散度零阶项。仅定义形式微分表达式；边界和算子域限制已说明。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 aForward, bForward 所列对象、量词、前提和结论。范围说明：aForward为−∑(p\_i/m\_i)∂_{q\_i}f，bForward为+∑∂_{q\_i}U ∂_{p\_i}f，符号及变量均匹配；系数分别对被求导变量独立，因此无遗漏的散度零阶项。仅定义形式微分表达式；边界和算子域限制已说明。

### 7. 状态与证明位置

- `MD.Ch07.aForward`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.bForward`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-ABOBABO

印刷页 270 / PDF页 291。

### 1. 原文陈述

> For example, the method denoted $`[ABO]`$ (acting from left to right) has a resulting update

$$
\mathcal U_h^{[ABO]}=\mathcal U_h^O\circ\mathcal U_h^B\circ\mathcal U_h^A.
$$


> An alternative is to use velocity Verlet for the Hamiltonian part, resulting in a scheme denoted $`[BABO]`$ with associated map

$$
\mathcal U_h^{[BABO]}=\mathcal U_h^O\circ\mathcal U_{h/2}^B\circ\mathcal U_h^A\circ\mathcal U_{h/2}^B.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def abo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ kickStep U h ∘ driftStep m h
def babo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 abo, babo 所列对象、量词、前提和结论。范围说明：从右至左展开复合，abo执行A(h),B(h),O(h)；babo执行B(h/2),A(h),B(h/2),O(h)，与原页从左至右执行字母约定完全一致。噪声分布资格与函数映射分开披露。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 字母从左到右执行，函数复合从右到左；随机变量独立资格由vectorNormalSequence约束。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。从右至左展开复合，abo执行A(h),B(h),O(h)；babo执行B(h/2),A(h),B(h/2),O(h)，与原页从左至右执行字母约定完全一致。噪声分布资格与函数映射分开披露。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 abo, babo 所列对象、量词、前提和结论。范围说明：从右至左展开复合，abo执行A(h),B(h),O(h)；babo执行B(h/2),A(h),B(h/2),O(h)，与原页从左至右执行字母约定完全一致。噪声分布资格与函数映射分开披露。

### 7. 状态与证明位置

- `MD.Ch07.abo`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.babo`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-WordConvention

印刷页 270 / PDF页 291。

### 1. 原文陈述

> As a result we use the convention that if a letter appears $`k`$ times in a method's string, then each individual update piece uses a timestep $`h/k`$. For example, the scheme denoted $`[OABOAOBAO]`$ has an update

$$
\mathcal U_h^{[OABOAOBAO]}=\mathcal U_{h/4}^O\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/4}^O\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/4}^O\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/3}^A\circ\mathcal U_{h/4}^O,
$$


> where the random numbers used in each O update are independent. This scheme will require a total of $`4N_c`$ normal random numbers and two force evaluations per step (the force must be recomputed at the first B step following an A step); the number of force evaluations required is not directly related to the length of the string.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def oabaobaoPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 4 → V n) : Phase n → Phase n :=
  ouStep m γ θ (h/4) (R 3) ∘ driftStep m (h/3) ∘ kickStep U (h/2) ∘
  ouStep m γ θ (h/4) (R 2) ∘ driftStep m (h/3) ∘
  ouStep m γ θ (h/4) (R 1) ∘ kickStep U (h/2) ∘
  driftStep m (h/3) ∘ ouStep m γ θ (h/4) (R 0)

/-- 恢复原页的兼容名称；原书此处没有计数勘误。 -/
def oabaobaoPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : Fin 4 → V n) : Phase n → Phase n := oabaobaoPrinted m U γ θ h R

theorem oabaobaoCount : (["O","A","B","O","A","O","B","A","O"] : List String).count "O" = 4 := by decide
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 九字母OABOAOBAO的确定性单步映射、四次O更新与计数；独立噪声序列的概率资格由vectorNormalSequence另列。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 每个O的向量噪声需联合独立标准正态；字母计数结论独立证明。
- 29号覆盖限定：九字母OABOAOBAO的确定性单步映射、四次O更新与计数；独立噪声序列的概率资格由vectorNormalSequence另列。
- PDF291已目视核对：原书九字母OABOAOBAO、四次O(h/4)、4N\_c均正确；撤销转录造成的假疑误。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。原页实际为九字母OABOAOBAO，四个O、三个A、两个B；所印复合也有九个因子，四个O(h/4)，并明确需4N\_c正态数，完全符合每字母总时长h的约定。本条JSON及三个Lean声明却删掉第三、第四字母间的O，形成八字母OABAOBAO。Printed版不忠实；_corrected版仅使另一个八字母算法内部一致，不能作为原页勘误；oabaobaoCount对八字母列表计数为3本身正确，但对象不是原书例子。
网站复审结论：PASS。任意n及实参数m,U,γ,θ,h和R:Fin 4→V n给出总化的确定性映射。三次A各h/3、两次B各h/2、四次O各h/4，与原页一致；计数定理无前提且结论正确。物理随机方法需正质量、适用时间/温度及联合独立标准正态噪声，当前定义不附带这些概率断言；此限制不使字面映射签名失败。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：九字母OABOAOBAO的确定性单步映射、四次O更新与计数；独立噪声序列的概率资格由vectorNormalSequence另列。

### 7. 状态与证明位置

- `MD.Ch07.oabaobaoPrinted`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.oabaobaoPrinted_corrected`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.oabaobaoCount`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-SixSchemes

印刷页 271 / PDF页 292。

### 1. 原文陈述

> For reference and to remove any ambiguity, we write out some of these algorithms below as single timestep maps.

$$
\begin{array}{ll} [ABAO]:&q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\quad p_{n+1/2}=p_n-h\nabla U(q_{n+1/2}),\\ &q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1/2},\quad p_{n+1}=e^{-h\gamma}p_{n+1/2}+\zeta_2M^{1/2}R_n;\\ [BABO]:&p_{n+1/2}=p_n-(h/2)\nabla U(q_n),\quad q_{n+1}=q_n+hM^{-1}p_{n+1/2},\\ &\hat p_{n+1/2}=p_{n+1/2}-(h/2)\nabla U(q_{n+1}),\quad p_{n+1}=e^{-h\gamma}\hat p_{n+1/2}+\zeta_2M^{1/2}R_n;\\ [ABOBA]:&q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\quad p_{n+1/2}=p_n-(h/2)\nabla U(q_{n+1/2}),\\ &\hat p_{n+1/2}=e^{-h\gamma}p_{n+1/2}+\zeta_2M^{1/2}R_n,\\ &p_{n+1}=\hat p_{n+1/2}-(h/2)\nabla U(q_{n+1/2}),\quad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1};\\ [BAOAB]:&p_{n+1/2}=p_n-(h/2)\nabla U(q_n),\quad q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},\\ &\hat p_{n+1/2}=e^{-h\gamma}p_{n+1/2}+\zeta_2M^{1/2}R_n,\\ &q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\hat p_{n+1/2},\quad p_{n+1}=\hat p_{n+1/2}-(h/2)\nabla U(q_{n+1});\\ [OABAO]:&p_{n+1/2}=e^{-h\gamma/2}p_n+\zeta_1M^{1/2}R_n,\\ &q_{n+1/2}=q_n+(h/2)M^{-1}p_{n+1/2},\quad\hat p_{n+1/2}=p_{n+1/2}-h\nabla U(q_{n+1/2}),\\ &q_{n+1}=q_{n+1/2}+(h/2)M^{-1}\hat p_{n+1/2},\quad p_{n+1}=e^{-h\gamma/2}\hat p_{n+1/2}+\zeta_1M^{1/2}R_{n+1/2};\\ [OBABO]:&p_{n+1/2}=e^{-h\gamma/2}p_n+\zeta_1M^{1/2}R_n,\quad\hat p_{n+1/2}=p_{n+1/2}-(h/2)\nabla U(q_n),\\ &q_{n+1}=q_n+hM^{-1}\hat p_{n+1/2},\quad\hat p_{n+1}=\hat p_{n+1/2}-(h/2)\nabla U(q_{n+1}),\\ &p_{n+1}=e^{-h\gamma/2}\hat p_{n+1}+\zeta_1M^{1/2}R_{n+1/2}, \end{array}
$$


> where $`\zeta_j=[k_BT(1-e^{-j\gamma h})]^{1/2}`$, and $`R_n,R_{n+1/2}`$ are $`N_d`$ vectors of standard independent $`\mathcal N(0,1)`$ random variables, resampled at each step.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def abao (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  ouStep m γ θ h R ∘ driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2)
def aboba (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  driftStep m (h/2) ∘ kickStep U (h/2) ∘ ouStep m γ θ h R ∘ kickStep U (h/2) ∘ driftStep m (h/2)
def baoab (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  kickStep U (h/2) ∘ driftStep m (h/2) ∘ ouStep m γ θ h R ∘ driftStep m (h/2) ∘ kickStep U (h/2)
def oabao (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  ouStep m γ θ (h/2) S ∘ driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ (h/2) R
def obabo (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) : Phase n → Phase n :=
  ouStep m γ θ (h/2) S ∘ kickStep U (h/2) ∘ driftStep m h ∘ kickStep U (h/2) ∘ ouStep m γ θ (h/2) R
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 abao, aboba, baoab, oabao, obabo 所列对象、量词、前提和结论。范围说明：逐项展开abao、aboba、baoab、oabao、obabo及前条babo，全部中间q、p和力求值位置吻合原页六种算法；全O步对应ζ₂，半O步对应ζ₁，两次O使用不同R,S。独立正态是资格条件，不是任意确定R,S的属性；可用vectorNormalSequence相邻两索引实现。未将跨步缓存的成本说明伪作数学定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- BABO已定义于ABOBABO；其余5个完整复合依次对应所列中间步。
- R与S为同一步两次O的独立标准正态向量；跨步也独立，用vectorNormalSequence提供资格。
- 原文最后“single evaluation”使用跨步缓存；实现成本不列为待证数学命题。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。逐项展开abao、aboba、baoab、oabao、obabo及前条babo，全部中间q、p和力求值位置吻合原页六种算法；全O步对应ζ₂，半O步对应ζ₁，两次O使用不同R,S。独立正态是资格条件，不是任意确定R,S的属性；可用vectorNormalSequence相邻两索引实现。未将跨步缓存的成本说明伪作数学定理。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 abao, aboba, baoab, oabao, obabo 所列对象、量词、前提和结论。范围说明：逐项展开abao、aboba、baoab、oabao、obabo及前条babo，全部中间q、p和力求值位置吻合原页六种算法；全O步对应ζ₂，半O步对应ζ₁，两次O使用不同R,S。独立正态是资格条件，不是任意确定R,S的属性；可用vectorNormalSequence相邻两索引实现。未将跨步缓存的成本说明伪作数学定理。

### 7. 状态与证明位置

- `MD.Ch07.abao`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.aboba`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.baoab`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.oabao`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.obabo`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.1-ConjugateIteration

印刷页 272 / PDF页 293。

### 1. 原文陈述

> When iterated $`n+1`$ times, we can see the scheme $`[OABA]`$ produces a mapping of the form

$$
(\mathcal U_h^{[OABA]})^{n+1}=\mathcal U_{h/2}^A\circ\mathcal U_{h/2}^B\circ(\mathcal U_h^{[BAOAB]})^n\circ\mathcal U_{h/2}^B\circ\mathcal U_{h/2}^A\circ\mathcal U_h^O;
$$


> therefore through a coordinate transformation the $`[OABA]`$ method can be morphed into the $`[BAOAB]`$ scheme.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem compositionIterate {D : Type*} (S T : D → D) (k : ℕ) :
    (S ∘ T)^[k+1] = S ∘ (T ∘ S)^[k] ∘ T := by
  funext x
  induction k with
  | zero => rfl
  | succ k ih =>
    simp only [Function.iterate_succ_apply', Function.comp_apply] at *
    rw [ih]

def oaba (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) : Phase n → Phase n :=
  driftStep m (h/2) ∘ kickStep U h ∘ driftStep m (h/2) ∘ ouStep m γ θ h R

def conjugateNoiseS (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (z : Phase n × ℕ) : Phase n × ℕ :=
  ((kickStep U (h/2) ∘ driftStep m (h/2) ∘ ouStep m γ θ h (R z.2)) z.1,z.2+1)

def conjugateNoiseT (m : V n) (U : V n → ℝ) (h : ℝ)
    (z : Phase n × ℕ) : Phase n × ℕ :=
  ((driftStep m (h/2) ∘ kickStep U (h/2)) z.1,z.2)

theorem oaba_baoab_noiseShift (m : V n) (U : V n → ℝ) (γ θ h : ℝ)
    (R : ℕ → V n) (k : ℕ) :
    (fun z : Phase n × ℕ ↦ (oaba m U γ θ h (R z.2) z.1,z.2+1))^[k+1] =
      conjugateNoiseT m U h ∘
      (fun z : Phase n × ℕ ↦ (baoab m U γ θ h (R z.2) z.1,z.2+1))^[k] ∘
      conjugateNoiseS m U γ θ h R := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- compositionIterate是任意确定性映射的真实复合恒等式；实际随机迭代应在扩展噪声序列空间中使用更新映射，不能把固定R重复使用当独立重抽样。
- 对所印OABA与BAOAB的随机分布/路径共轭仍需噪声移位包装，列入覆盖缺口；未把一般S,T恒等式冒称整段已覆盖。
- 29号覆盖限定：一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。
- 覆盖缺口：29号覆盖限定：一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。compositionIterate 对任意类型 D、任意自映射 S,T 和自然数 k 的恒等式正确；oaba 的右到左顺序为 O,A/2,B,A/2。未给出将该通用恒等式特化为所印 BAOAB 的声明，也没有独立噪声序列上的共轭。
网站复审结论：PASS。所有对象和量词匹配：状态空间为Phase n×ℕ，R:ℕ→V n任意，k任意自然数；不需概率假设即可陈述精确代数关系。采用T∘S为OABA、S∘T为BAOAB时，原文外侧A/B半步分别由T及S给出，端点和噪声移位正确。一般compositionIterate中的S/T字母与具体conjugateNoiseS/T的角色对调不影响结论。不变测度、可逆坐标变换和遍历性没有被该恒等式证明，已按范围限制保留。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：一般复合迭代恒等式、OABA定义及带噪声序号的OABA/BAOAB精确代数移位关系；不包含不变测度转移或遍历性。

### 7. 状态与证明位置

- `MD.Ch07.compositionIterate`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.oaba`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.conjugateNoiseS`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.conjugateNoiseT`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.oaba_baoab_noiseShift`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.2-SPVPrinted

印刷页 272 / PDF页 293。

### 1. 原文陈述

> Stochastic Position Verlet (SPV)

$$
q_{n+1/2}=q_n+(h/2)M^{-1}p_n,\qquad p_{n+1}=e^{-h\gamma}p_n-\eta\nabla U(q_n)+\zeta M^{1/2}R_n,\qquad q_{n+1}=q_{n+1/2}+(h/2)M^{-1}p_{n+1}
$$


> where $`\eta=(1-e^{-h\gamma})/\gamma`$, $`\zeta=[k_BT(1-e^{-2\gamma h})]^{1/2}`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def spvPrinted (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  let qhalf := (driftStep m (h/2) x).1
  let pnew := fun i ↦ ouMomentum m γ θ h x.2 R i - (1-Real.exp (-h*γ))/γ * gradient U x.1 i
  driftStep m (h/2) (qhalf,pnew)

def spvPrinted_corrected (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) (x : Phase n) : Phase n :=
  let qhalf := (driftStep m (h/2) x).1
  let pnew := fun i ↦ ouMomentum m γ θ h x.2 R i - (1-Real.exp (-h*γ))/γ * gradient U qhalf i
  driftStep m (h/2) (qhalf,pnew)

/-- 两个总化映射的物理适用域；γ=0另需定义η=h，此处不含该延拓。 -/
def spvQualification (m : V n) (γ θ h : ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ 0 < γ ∧ 0 < θ ∧ 0 ≤ h
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | Printed保留原页q\_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- γ>0使用原印η商；γ=0的连续延拓η=h另需定义，不用实数除零总化声称正确。
- 29号覆盖限定：Printed保留原页q\_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。
- 覆盖缺口：29号覆盖限定：Printed保留原页q\_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。spvPrinted 忠实采用 q\_n 计算梯度；spvPrinted\_corrected 改为 qhalf，符合先漂移半步再精确求解冻结位置的 OU/力子步。θ 对应 k\_BT，逐坐标质量为对角 M。两版均未单独限制物理参数，视为代数定义可接受；γ=0 时商的总化值不能代表连续延拓。
网站复审结论：NEEDS\_HUMAN。Printed及corrected的输入均为m,U,γ,θ,h,R,x，输出为Phase n；前者忠实原印q\_n，后者实现先A半步、再冻结位置的受力OU整步、再A半步。候选修正符合本页对称分裂的推导，但原印与文字说明存在真实冲突，因此整条保留NEEDS\_HUMAN。spvQualification只是独立Prop，不会自动成为两个def的前提；应在物理解释时显式引用。
按版本登记：修正版仅作为对称分裂的候选定义获认可；物理使用须引用spvQualification，γ=0延拓未覆盖。原印取力点仍待导师。
当前状态：修正版/限定声明=网站PASS；原文疑误或范围待导师。
本条实际覆盖：Printed保留原页q\_n力，候选修正版使用qhalf；总化函数需在正质量、γ>0、θ>0、h≥0下解释为物理单步，未覆盖γ=0延拓。

### 7. 状态与证明位置

- `MD.Ch07.spvPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.spvPrinted_corrected`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.spvQualification`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.2-SPVLargeFriction

印刷页 272–273 / PDF页 293–294。

### 1. 原文陈述

> It is important to note that in the limit of infinite friction, we have $`\eta\to0`$ independent of the timestep $`h`$. This suggests that this splitting strategy is unsuitable for large choices of the parameter $`\gamma`$ as the sampling will become inconsistent: the force will be dominated by the stochastic term, leaving the dynamics to evolve as a random walk.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem spvEtaLimit (h : ℝ) (hh : 0 < h) :
    Tendsto (fun γ : ℝ ↦ (1-Real.exp (-h*γ))/γ) atTop (𝓝 0) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 固定h的大摩擦单步极限及相应代数关系；未声称联合h/γ极限的一致性或完整采样不一致性。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只表达明确的η极限；采样不一致的定性判断缺统一模型、时标与测试函数量化，不作为已证结论。
- 29号覆盖限定：固定h的大摩擦单步极限及相应代数关系；未声称联合h/γ极限的一致性或完整采样不一致性。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。spvEtaLimit 对每个固定 h>0 断言 γ→+∞ 时 η→0，正确，且未把任意负 h 包含在内。没有陈述分布采样不一致或随机游走极限，extra\_assumptions 已披露此范围。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：固定h的大摩擦单步极限及相应代数关系；未声称联合h/γ极限的一致性或完整采样不一致性。

### 7. 状态与证明位置

- `MD.Ch07.spvEtaLimit`：未证；缺大型理论；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.3.2-BBK

印刷页 273 / PDF页 294。

### 1. 原文陈述

> Brünger-Brooks-Karplus (BBK)

$$
p_{n+1/2}=(1-h\gamma/2)p_n-(h/2)\nabla U(q_n)+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R_n,
$$



$$
q_{n+1}=q_n+hM^{-1}p_{n+1/2},\qquad p_{n+1}=[p_{n+1/2}-(h/2)\nabla U(q_{n+1})+\tfrac12\sqrt{2k_BTh\gamma}M^{1/2}R'_n]/(1+h\gamma/2).
$$


> Often $`R'`$ is chosen such that $`R'_n=R_{n+1}`$, so the random vector would be reused at the start of the following timestep, however there are many variants of this scheme that incorporate the redraw of random numbers differently. In other variants of BBK we take $`R'_n=R_n`$, reusing the random number within the step.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def bbk (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R S : V n) (x : Phase n) : Phase n :=
  let ph := fun i ↦ (1-h*γ/2)*x.2 i - (h/2)*gradient U x.1 i +
    (1/2)*Real.sqrt (2*θ*h*γ)*Real.sqrt (m i)*R i
  let q := (driftStep m h (x.1,ph)).1
  (q, fun i ↦ (ph i-(h/2)*gradient U q i + (1/2)*Real.sqrt (2*θ*h*γ)*Real.sqrt (m i)*S i)/(1+h*γ/2))

def bbkSameNoise (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (R : V n) := bbk m U γ θ h R R
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 bbk, bbkSameNoise 所列对象、量词、前提和结论。范围说明：bbk 的两次力分别在旧位置与新位置；两个噪声系数均为 1/2，末步除以 1+hγ/2。bbkSameNoise 精确取 S=R。向量逐坐标版本与所印三式相符。R′_n=R_{n+1} 的跨步耦合由条目15另给出，不由单步函数自动保证。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- h>0、γ≥0、θ>0、m\_i>0时分母非零及噪声方差有效；不同R′耦合方案分别处理，不把独立与重用噪声混为一谈。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。bbk 的两次力分别在旧位置与新位置；两个噪声系数均为 1/2，末步除以 1+hγ/2。bbkSameNoise 精确取 S=R。向量逐坐标版本与所印三式相符。R′_n=R_{n+1} 的跨步耦合由条目15另给出，不由单步函数自动保证。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 bbk, bbkSameNoise 所列对象、量词、前提和结论。范围说明：bbk 的两次力分别在旧位置与新位置；两个噪声系数均为 1/2，末步除以 1+hγ/2。bbkSameNoise 精确取 S=R。向量逐坐标版本与所印三式相符。R′_n=R_{n+1} 的跨步耦合由条目15另给出，不由单步函数自动保证。

### 7. 状态与证明位置

- `MD.Ch07.bbk`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.bbkSameNoise`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4-HarmonicHamiltonian

印刷页 273 / PDF页 294。

### 1. 原文陈述

> Recall that the one-dimensional harmonic oscillator with spring constant $`\Omega^2`$ has potential energy function $`U(q)=\Omega^2q^2/2`$, with Hamiltonian

$$
H(q,p)=\frac{p^2}{2m}+\frac{\Omega^2q^2}{2},\tag{7.6}
$$


> where $`(q,p)\in\mathbb R^2`$ represent a particle's position and momentum, and $`m\gt 0`$ is the particle's mass.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def harmonicHamiltonian (m Ω : ℝ) (x : ℝ × ℝ) : ℝ := x.2^2/(2*m)+Ω^2*x.1^2/2
def harmonicLaw (m Ω θ : ℝ) : Measure (ℝ × ℝ) :=
  (gaussianReal 0 (Real.toNNReal (θ/Ω^2))).prod (gaussianReal 0 (Real.toNNReal (θ*m)))
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 harmonicHamiltonian, harmonicLaw 所列对象、量词、前提和结论。范围说明：harmonicHamiltonian 的 x.1 为 q、x.2 为 p，两项系数与(7.6)一致。harmonicLaw 是方差 θ/Ω² 与 θm 的零均值正态乘积；正 m、正 θ、Ω≠0 的 Gibbs 解释需要所列条件，不是对任意参数的概率密度识别定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 正m、正θ、Ω≠0时为可归一化的正则谐振子Gibbs分布；θ=k\_BT。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。harmonicHamiltonian 的 x.1 为 q、x.2 为 p，两项系数与(7.6)一致。harmonicLaw 是方差 θ/Ω² 与 θm 的零均值正态乘积；正 m、正 θ、Ω≠0 的 Gibbs 解释需要所列条件，不是对任意参数的概率密度识别定理。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 harmonicHamiltonian, harmonicLaw 所列对象、量词、前提和结论。范围说明：harmonicHamiltonian 的 x.1 为 q、x.2 为 p，两项系数与(7.6)一致。harmonicLaw 是方差 θ/Ω² 与 θm 的零均值正态乘积；正 m、正 θ、Ω≠0 的 Gibbs 解释需要所列条件，不是对任意参数的概率密度识别定理。

### 7. 状态与证明位置

- `MD.Ch07.harmonicHamiltonian`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.harmonicLaw`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4-HarmonicMoments

印刷页 273–274 / PDF页 294–295。

### 1. 原文陈述

> In this setting, the canonical distribution $`\rho_\beta`$ is the product of two Gaussian distributions, where we have invariant (stationary) averages

$$
\langle q\rangle=\langle p\rangle=0,\qquad\langle\Omega^2q^2\rangle=\langle p^2/m\rangle=k_BT,\qquad\langle qp\rangle=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem harmonicMoments (m Ω θ : ℝ) (hm : 0 < m) (hΩ : Ω ≠ 0) (hθ : 0 < θ) :
    (∫ x, x.1 ∂harmonicLaw m Ω θ) = 0 ∧
    (∫ x, x.2 ∂harmonicLaw m Ω θ) = 0 ∧
    (∫ x, Ω^2*x.1^2 ∂harmonicLaw m Ω θ) = θ ∧
    (∫ x, x.2^2/m ∂harmonicLaw m Ω θ) = θ ∧
    (∫ x, x.1*x.2 ∂harmonicLaw m Ω θ) = 0 := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 harmonicMoments 所列对象、量词、前提和结论。范围说明：五个积分结论完整对应两个一阶矩、两个能量二阶矩和混合矩；正 m、Ω≠0、正 θ 保证 Real.toNNReal 不改变目标方差。harmonicLaw 为实际乘积概率测度，未把结论作为前提；其与 exp(-H/θ) 的密度识别未在该签名中证明，已披露。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- harmonicLaw给出实际正态乘积，未把所需各矩值作为假设；与Hamiltonian的密度识别另列覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。五个积分结论完整对应两个一阶矩、两个能量二阶矩和混合矩；正 m、Ω≠0、正 θ 保证 Real.toNNReal 不改变目标方差。harmonicLaw 为实际乘积概率测度，未把结论作为前提；其与 exp(-H/θ) 的密度识别未在该签名中证明，已披露。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 harmonicMoments 所列对象、量词、前提和结论。范围说明：五个积分结论完整对应两个一阶矩、两个能量二阶矩和混合矩；正 m、Ω≠0、正 θ 保证 Real.toNNReal 不改变目标方差。harmonicLaw 为实际乘积概率测度，未把结论作为前提；其与 exp(-H/θ) 的密度识别未在该签名中证明，已披露。

### 7. 状态与证明位置

- `MD.Ch07.harmonicMoments`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4-LinearIteration

印刷页 274 / PDF页 295。

### 1. 原文陈述

> Thus, denoting the iteration index as a subscript, we may explicitly write one iteration of a general numerical method for evolving the dynamics as

$$
\binom{q_{n+1}}{p_{n+1}}=\Psi\binom{q_n}{p_n}+\mu_n,\tag{7.7}
$$


> where $`\Psi`$ is a constant matrix that depends on the stepsize $`h`$, the friction coefficient $`\gamma`$, the particle mass $`m`$ and the spring constant $`\Omega`$. Additionally $`\mu_n`$ is a vector of stochastic processes.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def linearUpdate (a b c d : ℝ) (x noise : ℝ × ℝ) : ℝ × ℝ :=
  (a*x.1+b*x.2+noise.1,c*x.1+d*x.2+noise.2)
def momentQ (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.1^2 ∂μ
def momentP (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.2^2 ∂μ
def momentQP (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.1*x.2 ∂μ
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 linearUpdate, momentQ, momentP, momentQP 所列对象、量词、前提和结论。范围说明：linearUpdate 以四个实数表示任意常实 2×2 矩阵，状态和噪声均为 ℝ×ℝ；两个分量完整对应(7.7)。momentQ/P/QP 是原始二阶矩，不误作中心方差。该定义不自动保证特定算法线性或噪声与状态独立。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 具体2×2矩阵用四个真实系数，噪声不假定自动独立；后续陈述分别补独立或相关结构。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。linearUpdate 以四个实数表示任意常实 2×2 矩阵，状态和噪声均为 ℝ×ℝ；两个分量完整对应(7.7)。momentQ/P/QP 是原始二阶矩，不误作中心方差。该定义不自动保证特定算法线性或噪声与状态独立。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 linearUpdate, momentQ, momentP, momentQP 所列对象、量词、前提和结论。范围说明：linearUpdate 以四个实数表示任意常实 2×2 矩阵，状态和噪声均为 ℝ×ℝ；两个分量完整对应(7.7)。momentQ/P/QP 是原始二阶矩，不误作中心方差。该定义不自动保证特定算法线性或噪声与状态独立。

### 7. 状态与证明位置

- `MD.Ch07.linearUpdate`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentQ`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentP`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.momentQP`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4-BBKLinearForm

印刷页 274 / PDF页 295。

### 1. 原文陈述

> For example, in the BBK method we can compute directly from its update scheme that

$$
\Psi^{\rm BBK}=\begin{bmatrix}1-\frac{h^2\Omega^2}{2m}&\frac hm(1-\frac{\gamma h}2)\\ \frac{h\Omega^2}{2m}\frac{h^2\Omega^2-4m}{2+\gamma h}&\frac{(2-\gamma h)(2m-h^2\Omega^2)}{2m(2+\gamma h)}\end{bmatrix},
$$



$$
\mu_n^{\rm BBK}=\begin{bmatrix}\sqrt{\frac{k_BT\gamma h^3}{2m}}R_n\\ \frac{\sqrt{2k_BT\gamma hm}}{2+\gamma h}[(1-\frac{h^2\Omega^2}{2m})R_n+R'_n]\end{bmatrix}.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def bbkMatrix (m Ω γ h : ℝ) : ℝ × ℝ × ℝ × ℝ :=
  (1-h^2*Ω^2/(2*m), h/m*(1-γ*h/2),
    h*Ω^2/(2*m)*((h^2*Ω^2-4*m)/(2+γ*h)),
    (2-γ*h)*(2*m-h^2*Ω^2)/(2*m*(2+γ*h)))
def bbkNoise (m Ω γ θ h R S : ℝ) : ℝ × ℝ :=
  (Real.sqrt (θ*γ*h^3/(2*m))*R,
    Real.sqrt (2*θ*γ*h*m)/(2+γ*h)*((1-h^2*Ω^2/(2*m))*R+S))
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 bbkMatrix, bbkNoise 所列对象、量词、前提和结论。范围说明：bbkMatrix 的四个嵌套积投影依次为 ψ11,ψ12,ψ21,ψ22；bbkNoise 的两坐标、共同分母和 R,S 系数均与原页一致。它们是记录所印系数的定义，不是从 bbk 推导这些系数的等式定理，extra\_assumptions 已明确此缺口。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整记录所印矩阵与噪声；从BBK更新代入谐势的代数识别暂未证明，不以定义计为已证识别。
- 覆盖缺口：完整记录所印矩阵与噪声；从BBK更新代入谐势的代数识别暂未证明，不以定义计为已证识别。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。bbkMatrix 的四个嵌套积投影依次为 ψ11,ψ12,ψ21,ψ22；bbkNoise 的两坐标、共同分母和 R,S 系数均与原页一致。它们是记录所印系数的定义，不是从 bbk 推导这些系数的等式定理，extra\_assumptions 已明确此缺口。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 bbkMatrix, bbkNoise 所列对象、量词、前提和结论。范围说明：bbkMatrix 的四个嵌套积投影依次为 ψ11,ψ12,ψ21,ψ22；bbkNoise 的两坐标、共同分母和 R,S 系数均与原页一致。它们是记录所印系数的定义，不是从 bbk 推导这些系数的等式定理，extra\_assumptions 已明确此缺口。

### 7. 状态与证明位置

- `MD.Ch07.bbkMatrix`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.bbkNoise`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.4-QuadraticProducts

印刷页 274 / PDF页 295。

### 1. 原文陈述

> More generally, if we define the components of $`\Psi`$ as $`\psi_{ij}`$ and denote $`\mu_n=[\mu_{n,1},\mu_{n,2}]^T`$ we can take products of the update equations defined by (7.7) to obtain

$$
q_{n+1}^2=\psi_{11}^2q_n^2+\psi_{12}^2p_n^2+\mu_{n,1}^2+2\psi_{11}\psi_{12}q_np_n+2\psi_{11}\mu_{n,1}q_n+2\psi_{12}\mu_{n,1}p_n,\tag{7.8}
$$



$$
p_{n+1}^2=\psi_{21}^2q_n^2+\psi_{22}^2p_n^2+\mu_{n,2}^2+2\psi_{21}\psi_{22}q_np_n+2\psi_{21}\mu_{n,2}q_n+2\psi_{22}\mu_{n,2}p_n,\tag{7.9}
$$



$$
q_{n+1}p_{n+1}=\psi_{11}\psi_{21}q_n^2+\psi_{12}\psi_{22}p_n^2+\mu_{n,1}\mu_{n,2}+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})q_np_n +(\psi_{11}\mu_{n,2}+\psi_{21}\mu_{n,1})q_n+(\psi_{22}\mu_{n,1}+\psi_{12}\mu_{n,2})p_n.\tag{7.10}
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem quadraticProducts (a b c d q p r s : ℝ) :
    (linearUpdate a b c d (q,p) (r,s)).1^2 =
      a^2*q^2+b^2*p^2+r^2+2*a*b*q*p+2*a*r*q+2*b*r*p ∧
    (linearUpdate a b c d (q,p) (r,s)).2^2 =
      c^2*q^2+d^2*p^2+s^2+2*c*d*q*p+2*c*s*q+2*d*s*p ∧
    (linearUpdate a b c d (q,p) (r,s)).1*(linearUpdate a b c d (q,p) (r,s)).2 =
      a*c*q^2+b*d*p^2+r*s+(a*d+b*c)*q*p+(a*s+c*r)*q+(d*r+b*s)*p := by
  dsimp [linearUpdate]
  constructor
  · ring
  constructor <;> ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 quadraticProducts 所列对象、量词、前提和结论。范围说明：对全部八个任意实数，三个合取项分别展开 q\_new²、p\_new²、q\_new p\_new。交叉项 (a*d+b*c)、(a*s+c*r)、(d*r+b*s) 均正确；不需要概率或独立性前提。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口


### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。对全部八个任意实数，三个合取项分别展开 q\_new²、p\_new²、q\_new p\_new。交叉项 (a*d+b*c)、(a*s+c*r)、(d*r+b*s) 均正确；不需要概率或独立性前提。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 quadraticProducts 所列对象、量词、前提和结论。范围说明：对全部八个任意实数，三个合取项分别展开 q\_new²、p\_new²、q\_new p\_new。交叉项 (a*d+b*c)、(a*s+c*r)、(d*r+b*s) 均正确；不需要概率或独立性前提。

### 7. 状态与证明位置

- `MD.Ch07.quadraticProducts`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

