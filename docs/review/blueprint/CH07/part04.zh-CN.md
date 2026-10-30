[上一部分](part03.zh-CN.md) / [目录](../../CH07_BLUEPRINT.zh-CN.md) / [下一部分](part05.zh-CN.md)

## MD-7.6-JSplitting

印刷页 282–283 / PDF页 303–304。

### 1. 原文陈述

> Let $`J`$ be the skew-symmetric canonical symplectic structure matrix. The idea is to consider a splitting of $`J`$ into a finite number $`K`$ of skew-symmetric matrices $`J_i`$, $`i=1,\ldots,K`$. This induces a splitting of the Hamiltonian vector field into $`K`$ vector fields $`f_i=J_i\nabla H`$. Each of these vector fields preserves $`H`$ and, because they are themselves Hamiltonian, their flows are also volume-preserving. Assuming each such vector field is exactly integrable, the system dynamics may be approximated by composing the flow maps for each vector field.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def jField (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ) (x : V n) : V n :=
  fun i ↦ ∑ j, J i j * gradient H x j
theorem jSplitting_energy (J : Matrix (Fin n) (Fin n) ℝ) (H : V n → ℝ)
    (hJ : ∀ i j, J i j = -J j i) (hH : ContDiff ℝ 2 H) :
    ∀ x, lieField (jField J H) H x = 0 ∧ divergenceField (jField J H) x = 0 := by
  sorry
theorem composition_preservesEnergy {E : Type*} (F G : E → E) (H : E → ℝ)
    (hF : ∀ x, H (F x) = H x) (hG : ∀ x, H (G x) = H x) :
    ∀ x, H ((F ∘ G) x) = H x := by
  intro x
  rw [Function.comp_apply, hF, hG]

theorem jField_finiteDecomposition {K : ℕ} (J : Fin K → Matrix (Fin n) (Fin n) ℝ)
    (H : V n → ℝ) (hJ : ∀ k i j, J k i j = -J k j i) :
    jField (∑ k, J k) H = fun x ↦ ∑ k, jField (J k) H x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- Ji取常系数反对称矩阵，H为C²；一般退化Ji并非标准坐标辛矩阵，但能量/散度两个实际导数结论仍有意义。
- 体积保持需要已存在的完整光滑流；本条不新建流存在及Liouville理论。
- 29号覆盖限定：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。
- 覆盖缺口：29号覆盖限定：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。jField是常矩阵乘坐标梯度；jSplitting\_energy在H∈C²、J反对称下给出每一点Lie导数为零及散度为零，符号正确。composition\_preservesEnergy对任意两个已保H的映射复合也正确。但无K族、∑Ji=J、∑fi=J∇H，没有流满足ODE及流保体积结论，也无复合流对原动力学的一致近似。散度零不等于签名已声明流保体积。extra\_assumptions说明缺口，却不补齐“本条全部对象与公式”的覆盖。
网站复审结论：PASS。所列定义与三个定理完整覆盖明示的常反对称矩阵代数、微分结论及已保能映射复合，不把散度为零直接冒称为已建立全局保体积流。有限分解定理没有将矩阵和固定为标准J，但适用于原文J=∑J\_i的代入；hJ对线性求和恒等式虽非必要，仍与原文条件一致。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：有限反对称常矩阵及向量场的和分解、单个子场能量导数/散度为零、已保能映射的复合保能；未含流保体积和一致逼近。

### 7. 状态与证明位置

- `MD.Ch07.jField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.jSplitting_energy`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.composition_preservesEnergy`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.jField_finiteDecomposition`：未证；时间盒止；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.6-CoordinateJSplitting

印刷页 283 / PDF页 304。

### 1. 原文陈述

> As an example of such a $`J`$-splitting, we may take $`K=N_c`$ with each $`J_i`$ to be defined by the components of the canonical symplectic structure matrix having to do with the $`i`$th position and momentum pair, thus the equations of motion for the $`i`$th vector field become

$$
\dot q_i=p_i/m_i,\qquad \dot p_i=-\frac{\partial U}{\partial q_i}(\bar q_1,\ldots,\bar q_{i-1},q_i,\bar q_{i+1},\ldots,\bar q_{N_c}),
$$


> where components with a bar over them are fixed during the calculation. Any such 1-dof Hamiltonian system is formally integrable (albeit in quadratures).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def coordinateJField (m : V n) (U : V n → ℝ) (i : Fin n) (x : Phase n) : Phase n :=
  (fun j ↦ if j = i then x.2 i/m i else 0,
   fun j ↦ if j = i then -gradient U x.1 i else 0)
def frozenPotential (U : V n → ℝ) (q : V n) (i : Fin n) (r : ℝ) : ℝ :=
  U (Function.update q i r)

def coordinateJQualification (m : V n) (U : V n → ℝ) : Prop :=
  (∀ i, 0 < m i) ∧ ContDiff ℝ 2 U

theorem frozenPotential_deriv (m : V n) (U : V n → ℝ)
    (hq : coordinateJQualification m U) (q : V n) (i : Fin n) :
    deriv (frozenPotential U q i) (q i) = gradient U q i := rfl
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整记录冻结坐标的一自由度向量场；形式quadrature可积性的分支、转折点及积分反演尚未形式化，明确列入覆盖缺口。
- 29号覆盖限定：两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。
- 覆盖缺口：完整记录冻结坐标的一自由度向量场；形式quadrature可积性的分支、转折点及积分反演尚未形式化，明确列入覆盖缺口。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。Phase n=V n×V n，coordinateJField只在第i对分量非零，速度pi/mi和力−∂iU正确；frozenPotential正确使用Function.update冻结其余位置。没有mi>0或至少mi≠0以及U光滑性的物理资格，但这两个总函数定义可在更大域定义。未陈述冻结势的导数等于该力，亦没有一自由度求积可积性或流/顺序更新结论。JSON已承认求积缺口；完整所引陈述仍未覆盖。
网站复审结论：PASS。对象均为Phase n或V n，索引i:Fin n，未遗漏冻结坐标。资格命题不自动限制coordinateJField的所有调用，物理使用时需引用。Lean的结论只是冻结势的导数识别，分支、转折点、积分反演和全局流未覆盖，已披露；不因此否定当前限定范围内的正确签名。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：两个总化辅助定义、正质量光滑势资格和冻结势单坐标导数关系；不含分段求积、转折点或一自由度全局流。

### 7. 状态与证明位置

- `MD.Ch07.coordinateJField`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.frozenPotential`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.coordinateJQualification`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.frozenPotential_deriv`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7-ModifiedGenerator

印刷页 284 / PDF页 305。

### 1. 原文陈述

> We begin by defining the generator $`\widehat{\mathcal L}`$ associated to the propagation of averages under the numerical method for an SDE. We think of this generator as a perturbation of the exact Langevin dynamics generator $`\mathcal L_{LD}`$, or

$$
\widehat{\mathcal L}=\mathcal L_{LD}+h\mathcal L_1+h^2\mathcal L_2+h^3\mathcal L_3+O(h^4).\tag{7.16}
$$


> However, the operators involved are not equivalent to the operators that would arise from any stochastic differential equation (see [403]), so we must give up the direct analogy between the formal series and continuous SDE models (which is available in the deterministic setting).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def formalModifiedGenerator {R : Type*} [Ring R] [Algebra ℝ R]
    (S : PowerSeries R) : PowerSeries R :=
  PowerSeries.mk (fun k ↦ PowerSeries.coeff (k+1) (MolecularDynamics.textbookFormalOperatorLogarithm S))
def formalGeneratorExpansion {R : Type*} [Ring R] [Algebra ℝ R]
    (L : PowerSeries R) (L0 L1 L2 L3 : R) : Prop :=
  PowerSeries.coeff 0 L = L0 ∧ PowerSeries.coeff 1 L = L1 ∧
  PowerSeries.coeff 2 L = L2 ∧ PowerSeries.coeff 3 L = L3
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 formalModifiedGenerator, formalGeneratorExpansion 所列对象、量词、前提和结论。范围说明：formalGeneratorExpansion逐一固定0–3阶系数，与形式O(h⁴)一致；formalModifiedGenerator取log(S)的k+1阶系数，相当于形式除以h。D54中n=0的实数除零项为0；在S常数项为1时，其余有限和确为该阶形式对数。任意S仍有定义，但不能因此称为真实传播子的log/h；原文的数值传播子要求S₀=1。extra\_assumptions明确只取形式系数、不承诺收敛或另一SDE，因此本条作为定义通过；未声称已识别实际Langevin生成元。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只取形式幂级数系数；O(h⁴)在此意为0–3阶系数相等，不宣称无界算符级数收敛，也不声称是另一SDE的生成元。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。formalGeneratorExpansion逐一固定0–3阶系数，与形式O(h⁴)一致；formalModifiedGenerator取log(S)的k+1阶系数，相当于形式除以h。D54中n=0的实数除零项为0；在S常数项为1时，其余有限和确为该阶形式对数。任意S仍有定义，但不能因此称为真实传播子的log/h；原文的数值传播子要求S₀=1。extra\_assumptions明确只取形式系数、不承诺收敛或另一SDE，因此本条作为定义通过；未声称已识别实际Langevin生成元。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 formalModifiedGenerator, formalGeneratorExpansion 所列对象、量词、前提和结论。范围说明：formalGeneratorExpansion逐一固定0–3阶系数，与形式O(h⁴)一致；formalModifiedGenerator取log(S)的k+1阶系数，相当于形式除以h。D54中n=0的实数除零项为0；在S常数项为1时，其余有限和确为该阶形式对数。任意S仍有定义，但不能因此称为真实传播子的log/h；原文的数值传播子要求S₀=1。extra\_assumptions明确只取形式系数、不承诺收敛或另一SDE，因此本条作为定义通过；未声称已识别实际Langevin生成元。

### 7. 状态与证明位置

- `MD.Ch07.formalModifiedGenerator`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.formalGeneratorExpansion`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7-InvariantDensityExpansion

印刷页 284 / PDF页 305。

### 1. 原文陈述

> We write this invariant distribution as a perturbation of the (target) canonical distribution

$$
\widehat\rho=\rho_\beta[1+hf_1+h^2f_2+h^3f_3+O(h^4)],\tag{7.17}
$$


> with each correction function $`f_k(q,p)`$ satisfying

$$
\int_{\mathcal D} f_k(q,p)\rho_\beta(q,p)d\omega=0,
$$


> ensuring a useful equivalence in the partition function

$$
\int_{\mathcal D}\widehat\rho(q,p)d\omega=\int_{\mathcal D}\rho_\beta(q,p)d\omega.
$$


> Our computed average is therefore $`\langle\phi\rangle_h\stackrel{\rm def}=\int_{\mathcal D}\phi(q,p)\widehat\rho(q,p)d\omega`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def densityExpansion (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ) : ℕ → Ω → ℝ
  | 0 => ρ
  | k+1 => fun x ↦ ρ x*f (k+1) x
def centeredCorrections (μ : Measure Ω) (f : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure μ ∧ ∀ k, 0 < k → Integrable (f k) μ ∧ (∫ x, f k x ∂μ) = 0
def computedAverage (ν : Measure Ω) (φ ρhat : Ω → ℝ) : ℝ := ∫ x, φ x*ρhat x ∂ν
theorem densityExpansion_zeroMass (ν : Measure Ω) (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ)
    (hρ : Integrable ρ ν)
    (hf : ∀ k, 0 < k → Integrable (fun x ↦ ρ x*f k x) ν ∧ (∫ x, ρ x*f k x ∂ν) = 0) :
    ∀ k, (∫ x, densityExpansion ρ f k x ∂ν) = if k = 0 then ∫ x, ρ x ∂ν else 0 := by
  intro k
  cases k with
  | zero => simp [densityExpansion]
  | succ k => simpa [densityExpansion] using (hf (k+1) (Nat.zero_lt_succ k)).2
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 densityExpansion, centeredCorrections, computedAverage, densityExpansion\_zeroMass 所列对象、量词、前提和结论。范围说明：densityExpansion第0系数为ρ，第k≥1系数为ρfk，索引无偏移。centeredCorrections针对概率μ、k>0同时要求可积及零积分；用于原文时须μ=ρβdω。densityExpansion\_zeroMass直接假设每个ρfk相对ν可积且零质量，完整推出所有系数的积分值。computedAverage是φρhat相对ν积分。这里只得到形式系数的质量一致，未得到实际正密度或余项积分为零；extra\_assumptions已明确限制，不能扩读成精确截断概率或离散不变性定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 系数零质量不等于任意h的截断密度非负；概率密度仍须非负、可积且归一。余项质量也为零或完整级数可交换积分时才推出精确总质量一致。
- 此处证明所有形式系数的质量约束；未把有限截断表达式假称实际不变概率。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。densityExpansion第0系数为ρ，第k≥1系数为ρfk，索引无偏移。centeredCorrections针对概率μ、k>0同时要求可积及零积分；用于原文时须μ=ρβdω。densityExpansion\_zeroMass直接假设每个ρfk相对ν可积且零质量，完整推出所有系数的积分值。computedAverage是φρhat相对ν积分。这里只得到形式系数的质量一致，未得到实际正密度或余项积分为零；extra\_assumptions已明确限制，不能扩读成精确截断概率或离散不变性定理。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 densityExpansion, centeredCorrections, computedAverage, densityExpansion\_zeroMass 所列对象、量词、前提和结论。范围说明：densityExpansion第0系数为ρ，第k≥1系数为ρfk，索引无偏移。centeredCorrections针对概率μ、k>0同时要求可积及零积分；用于原文时须μ=ρβdω。densityExpansion\_zeroMass直接假设每个ρfk相对ν可积且零质量，完整推出所有系数的积分值。computedAverage是φρhat相对ν积分。这里只得到形式系数的质量一致，未得到实际正密度或余项积分为零；extra\_assumptions已明确限制，不能扩读成精确截断概率或离散不变性定理。

### 7. 状态与证明位置

- `MD.Ch07.densityExpansion`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.centeredCorrections`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.computedAverage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.densityExpansion_zeroMass`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-ExactABOPropagators

印刷页 285 / PDF页 306。

### 1. 原文陈述


$$
(e^{t\mathcal L_A}\phi)(q,p)=\phi(q+tM^{-1}p,p),\qquad (e^{t\mathcal L_B}\phi)(q,p)=\phi(q,p-t\nabla U(q)),
$$



$$
(e^{t\mathcal L_O}\phi)(q,p)=\int_{\mathcal P}\phi(q,e^{-\gamma t}p+\zeta M^{1/2}x)\frac{e^{-|x|^2/2}}{(2\pi)^{N_c/2}}dx,
$$


> where $`\zeta=[k_BT(1-e^{-2\gamma t})]^{1/2}`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def propagateA (m : V n) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ driftStep m t
def propagateB (U : V n → ℝ) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ kickStep U t
def propagateO (m : V n) (γ θ t : ℝ) (φ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∫ R, φ (ouStep m γ θ t R x) ∂Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 propagateA, propagateB, propagateO 所列对象、量词、前提和结论。范围说明：D55–D61：A/B分别拉回driftStep/kickStep；OU的噪声是sqrt(θ(1−exp(−2γt)))sqrt(mi)Ri，R服从Fin n各分量gaussianReal 0 1的乘积测度，正确对应θ=kBT和对角正质量。固定时刻定义不包含指数生成元等式或半群律；JSON明确该限制。物理解读需要正质量、θ>0、γ≥0、t≥0和被积函数可积，这些写于extra\_assumptions，不是Lean隐含前提；在不满足时总函数仍可定义但不能作OU物理传播子解释。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- O用实际独立标准正态乘积测度；θ>0、γ≥0、t≥0、正质量时对应OU噪声。期望用于可积φ，未把不可积函数的默认积分当物理期望。
- 半群律及实际SDE生成元识别需OU转移律与Markov理论，本条只定义固定时刻传播子。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。D55–D61：A/B分别拉回driftStep/kickStep；OU的噪声是sqrt(θ(1−exp(−2γt)))sqrt(mi)Ri，R服从Fin n各分量gaussianReal 0 1的乘积测度，正确对应θ=kBT和对角正质量。固定时刻定义不包含指数生成元等式或半群律；JSON明确该限制。物理解读需要正质量、θ>0、γ≥0、t≥0和被积函数可积，这些写于extra\_assumptions，不是Lean隐含前提；在不满足时总函数仍可定义但不能作OU物理传播子解释。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 propagateA, propagateB, propagateO 所列对象、量词、前提和结论。范围说明：D55–D61：A/B分别拉回driftStep/kickStep；OU的噪声是sqrt(θ(1−exp(−2γt)))sqrt(mi)Ri，R服从Fin n各分量gaussianReal 0 1的乘积测度，正确对应θ=kBT和对角正质量。固定时刻定义不包含指数生成元等式或半群律；JSON明确该限制。物理解读需要正质量、θ>0、γ≥0、t≥0和被积函数可积，这些写于extra\_assumptions，不是Lean隐含前提；在不满足时总函数仍可定义但不能作OU物理传播子解释。

### 7. 状态与证明位置

- `MD.Ch07.propagateA`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.propagateB`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.propagateO`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-OperatorOrderReversal

印刷页 285 / PDF页 306。

### 1. 原文陈述

> For example, for the method labelled by the string $`[ABAO]`$, we have

$$
\exp(h\widehat{\mathcal L}_{[ABAO]})=\exp((h/2)\mathcal L_A)\exp(h\mathcal L_B)\exp((h/2)\mathcal L_A)\exp(h\mathcal L_O),
$$


> where importantly note the apparent reversal of the sequence of products, known as the vertauschungssatz. We will find it more convenient to work with the adjoint of the perturbed generator, denoted $`\widehat{\mathcal L}^\dagger`$, which we may compute as

$$
\exp(h\widehat{\mathcal L}_{[ABAO]}^\dagger)=\exp(h\mathcal L_O^\dagger)\exp((h/2)\mathcal L_A^\dagger)\exp(h\mathcal L_B^\dagger)\exp((h/2)\mathcal L_A^\dagger).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem pullback_order {E F : Type*} (A B : E → E) (φ : E → F) :
    φ ∘ (B ∘ A) = (φ ∘ B) ∘ A := rfl
def abaoBackward (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (φ : Phase n → ℝ) :=
  propagateA m (h/2) (propagateB U h (propagateA m (h/2) (propagateO m γ θ h φ)))

theorem fourStage_duality {E : Type*} [AddCommGroup E] [Module ℝ E]
    (pair : E → E → ℝ) (A B C D a b c d : Module.End ℝ E)
    (hA : ∀ x y, pair (A x) y = pair x (a y))
    (hB : ∀ x y, pair (B x) y = pair x (b y))
    (hC : ∀ x y, pair (C x) y = pair x (c y))
    (hD : ∀ x y, pair (D x) y = pair x (d y)) (x y : E) :
    pair (A (B (C (D x)))) y = pair x (d (c (b (a y)))) := by
  rw [hA,hB,hC,hD]
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 覆盖反向拉回组合恒等式和ABAO的全部四段期望传播式；其与前面随机abao映射期望相等仍需推前积分桥。
- 伴随前向传播子的四段顺序记录在原文；独立定义实际密度伴随的函数空间和边界条件列为覆盖缺口。
- 29号覆盖限定：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。
- 覆盖缺口：29号覆盖限定：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。pullback\_order是φ∘(B∘A)=(φ∘B)∘A；结合拉回算子定义可说明顺序反转，但它本身仅为复合结合律。abaoBackward的嵌套次序和h/2系数正确。没有任何伴随对象或前向O A B A四段乘积，因而原文明确给出的第二条主等式未覆盖；extra\_assumptions只登记缺口。也未将此定义与实际离散随机映射的期望识别。
网站复审结论：PASS。后向定义、拉回等式及抽象反序对偶定理的对象和顺序正确。propagateO作为积分的总化定义对任意实参数和φ都有Lean值，但物理Markov半群解释还需适用参数、可测/可积资格；本条没有提出无条件半群识别定理。fourStage\_duality的结论完全由已给出的hA–hD推出，没有将未定义的密度伴随或无界算子域隐含为已完成。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：拉回复合结合律、ABAO后向定义及四个线性算子的反序对偶配对恒等式；实际随机传播子识别及闭算子域未覆盖。

### 7. 状态与证明位置

- `MD.Ch07.pullback_order`：已证；网站：PASS（送审签名未变）
- `MD.Ch07.abaoBackward`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.fourStage_duality`：已证；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-StationaryModifiedPDE

印刷页 285–286 / PDF页 306–307。

### 1. 原文陈述

> Under the propagation of the numerical scheme (or the discretized dynamics), the Fokker-Planck equation gives us that the evolution of a density of points $`\rho`$ is given by

$$
\frac\partial{\partial t}\rho(z,t)=\widehat{\mathcal L}^\dagger\rho,
$$


> with the important case of its invariant distribution satisfying the partial differential equation

$$
\widehat{\mathcal L}^\dagger\widehat\rho=0.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def formalDensityEvolution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (L : E →L[ℝ] E) (ρ : ℝ → E) : Prop := ∀ t, HasDerivAt ρ (L (ρ t)) t
def stationaryModifiedDensity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (ρ : E) : Prop := L ρ = 0
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 真实离散转移一般不嵌入连续Markov半群，修改方程仅为形式分析；不宣称任意离散SDE方法有上述真实Fokker–Planck演化。
- Markov半群资格、密度正性归一、无界生成元定义域及嵌入性尚缺；此处仅明确定义方程，不证明等价。
- 29号覆盖限定：仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。
- 覆盖缺口：29号覆盖限定：仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。formalDensityEvolution对所有实t用HasDerivAt，且L为有界连续线性算子E→L[ℝ]E；原书Langevin/修改微分算子通常无界并需定义域，时间通常t≥0。stationaryModifiedDensity只是任意代数线性自映射的核条件，无密度资格，也未与前一个L识别。二者作为抽象定义有意义，不能据此确认原离散分布真实满足连续Fokker–Planck演化。原页把离散传播与连续方程直接联结需要形式解释或嵌入条件；JSON已提醒，须人工限定，不能静默改成普遍真实PDE。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：仅有界连续线性算子的全实时间演化目标、代数算子的核目标；二者未识别，也非实际Langevin无界生成元或离散嵌入定理。

### 7. 状态与证明位置

- `MD.Ch07.formalDensityEvolution`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.stationaryModifiedDensity`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-TwoOperatorBCH

印刷页 286 / PDF页 307。

### 1. 原文陈述

> Recall that for linear operators $`X`$ and $`Y`$, we can write the composition of their exponentials as

$$
\exp(hX)\exp(hY)=\exp(hZ),
$$


> where we have the expansion

$$
Z=X+Y+\frac h2[X,Y]+\frac{h^2}{12}([X,[X,Y]]+[Y,[Y,X]])+O(h^3).
$$


> The notation $`[X,Y]\stackrel{\rm def}=XY-YX`$ represents the commutator of the operators $`X`$ and $`Y`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def comm {R : Type*} [Ring R] (X Y : R) : R := X*Y-Y*X
def twoStage {R : Type*} [Ring R] [Algebra ℝ R] (X Y : R) : PowerSeries R :=
  MolecularDynamics.textbookFormalOperatorExponential X * MolecularDynamics.textbookFormalOperatorExponential Y
theorem twoOperatorBCH {R : Type*} [Ring R] [Algebra ℝ R] (X Y : R) :
    PowerSeries.coeff 0 (formalModifiedGenerator (twoStage X Y)) = X+Y ∧
    PowerSeries.coeff 1 (formalModifiedGenerator (twoStage X Y)) = (1/2 : ℝ) • comm X Y ∧
    PowerSeries.coeff 2 (formalModifiedGenerator (twoStage X Y)) =
      (1/12 : ℝ) • (comm X (comm X Y)+comm Y (comm Y X)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 comm, twoStage, twoOperatorBCH 所列对象、量词、前提和结论。范围说明：D62交换子为XY−YX，D63形式指数系数Aⁿ/n!，twoStage顺序X后乘Y；形式log/h的0、1、2阶与原文完整展示的三阶系数一致。任意实结合代数足够，不要求交换、收敛或有界性；twoStage常数项为1，满足D54形式对数的使用条件。sorry仅是未填证明，不影响本次签名判定。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 任意实代数中的非交换形式幂级数；不要求无界算符指数收敛。本条完整记录所印0–2阶。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。D62交换子为XY−YX，D63形式指数系数Aⁿ/n!，twoStage顺序X后乘Y；形式log/h的0、1、2阶与原文完整展示的三阶系数一致。任意实结合代数足够，不要求交换、收敛或有界性；twoStage常数项为1，满足D54形式对数的使用条件。sorry仅是未填证明，不影响本次签名判定。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 comm, twoStage, twoOperatorBCH 所列对象、量词、前提和结论。范围说明：D62交换子为XY−YX，D63形式指数系数Aⁿ/n!，twoStage顺序X后乘Y；形式log/h的0、1、2阶与原文完整展示的三阶系数一致。任意实结合代数足够，不要求交换、收敛或有界性；twoStage常数项为1，满足D54形式对数的使用条件。sorry仅是未填证明，不影响本次签名判定。

### 7. 状态与证明位置

- `MD.Ch07.comm`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.twoStage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.twoOperatorBCH`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.1-TaylorRemainder

印刷页 286–287 / PDF页 307–308。

### 1. 原文陈述

> We can make use of Taylor’s theorem to write the identity

$$
P_h=P_0+h\left.\frac{dP_t}{dt}\right|_{t=0}+\cdots+\frac{h^n}{n!}\left.\frac{d^nP_t}{dt^n}\right|_{t=0} +\frac{h^{n+1}}{n!}\int_0^1(1-\lambda)^n\left.\frac{d^{n+1}P_t}{dt^{n+1}}\right|_{t=\lambda h}d\lambda,
$$


> for some finite truncation index $`n\in\{1,2,3,\ldots\}`$. Hence for observables of sufficient smoothness with compact support, this remainder term will remain bounded (see [223]).

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem taylorRemainder (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) (h : ℝ) :
    F h = (∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0) +
      h^(k+1)/(Nat.factorial k : ℝ)*∫ t in (0 : ℝ)..1, (1-t)^k*iteratedDeriv (k+1) F (t*h) := by
  sorry
theorem taylorRemainder_bound (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ F h-∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0)
      (fun h ↦ h^(k+1)) := by
  sorry

theorem propagatedObservable_remainder {E : Type*} (P : ℝ → (E → ℝ) → E → ℝ)
    (φ : E → ℝ) (z : E) (k : ℕ)
    (htime : ContDiff ℝ (k+1) (fun t ↦ P t φ z)) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ P h φ z-∑ j ∈ Finset.range (k+1),
        h^j/(Nat.factorial j : ℝ)*iteratedDeriv j (fun t ↦ P t φ z) 0)
      (fun h ↦ h^(k+1)) := taylorRemainder_bound _ k htime
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P\_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只覆盖作用于单个可观测量和点后的标量C^(n+1) Taylor恒等式及局部余项界；把ABO无界算符组合在紧支撑光滑测试函数上归约到这些假设仍是覆盖缺口。
- 29号覆盖限定：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P\_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。
- 覆盖缺口：29号覆盖限定：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P\_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。taylorRemainder对标量F∈C^(k+1)、所有实h给出正确积分余项，k∈ℕ还合法扩展到0阶。taylorRemainder\_bound是h→0的标量局部O(h^(k+1))，正确但其常数可依赖F。没有P\_t作用在紧支撑可观测量后满足这些假设的桥，也无相空间/算子范数意义下的余项界；不能把逐点标量结论作为原文算子/观测量余项资格的完整审校通过。extra\_assumptions已承认范围缩减。
网站复审结论：PASS。三个声明量化所有k:ℕ；原文n≥1的情形包含其中，额外k=0情形合法。最后一个结论对给定φ,z成立，Big-O常数可依赖它们；并不提供对空间点或测试函数族的统一控制。P是任意时间算子族而不是已识别的ABO半群，htime没有被悄然由紧支撑推得；与明示限定范围一致。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：标量时间函数的Taylor积分余项和逐点O界，包括F(t)=P\_tφ(z)已具备时间正则时的特化；未证明半群时间正则或空间统一界。

### 7. 状态与证明位置

- `MD.Ch07.taylorRemainder`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.taylorRemainder_bound`：未证；缺大型理论；网站：PASS（送审签名未变）
- `MD.Ch07.propagatedObservable_remainder`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-ThreeOperatorBCH

印刷页 287 / PDF页 308。

### 1. 原文陈述


$$
\exp(hS)=\exp(hZ)\exp(hY)\exp(hX).\tag{7.18}
$$



$$
S=X+Y+Z+\frac h2([Z,Y]+[Z,X]+[Y,X])+\frac{h^2}{4}[Z,Y,X] +\frac{h^2}{12}([Y,Y,X]+[X,X,Y]+[Z,Z,Y]+[Z,Z,X]+[Y+X,Y+X,Z])+\cdots
$$


> where the notation $`[A,B,C]`$ is notation for $`[A,[B,C]]`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def threeStage {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) : PowerSeries R :=
  MolecularDynamics.textbookFormalOperatorExponential Z *
    MolecularDynamics.textbookFormalOperatorExponential Y * MolecularDynamics.textbookFormalOperatorExponential X
theorem threeOperatorBCH {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    PowerSeries.coeff 0 (formalModifiedGenerator (threeStage X Y Z)) = X+Y+Z ∧
    PowerSeries.coeff 1 (formalModifiedGenerator (threeStage X Y Z)) =
      (1/2 : ℝ) • (comm Z Y+comm Z X+comm Y X) ∧
    PowerSeries.coeff 2 (formalModifiedGenerator (threeStage X Y Z)) =
      (1/4 : ℝ) • comm Z (comm Y X)+(1/12 : ℝ) •
        (comm Y (comm Y X)+comm X (comm X Y)+comm Z (comm Z Y)+
          comm Z (comm Z X)+comm (Y+X) (comm (Y+X) Z)) := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 threeStage, threeOperatorBCH 所列对象、量词、前提和结论。范围说明：threeStage按Z、Y、X相乘；threeOperatorBCH的0–2阶系数逐项匹配最终印式。comm (Y+X) (comm (Y+X) Z)的括号正确；h²/4项是[Z,[Y,X]]，无交换子符号反转。任意实结合代数上的形式论证足够，常数项为1。中间未合并推导省略不改变所审最终公式。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 完整记录最终0–2阶系数；中间未合并式作为原文推导说明，不另假装是完整精确算符相等。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。threeStage按Z、Y、X相乘；threeOperatorBCH的0–2阶系数逐项匹配最终印式。comm (Y+X) (comm (Y+X) Z)的括号正确；h²/4项是[Z,[Y,X]]，无交换子符号反转。任意实结合代数上的形式论证足够，常数项为1。中间未合并推导省略不改变所审最终公式。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 threeStage, threeOperatorBCH 所列对象、量词、前提和结论。范围说明：threeStage按Z、Y、X相乘；threeOperatorBCH的0–2阶系数逐项匹配最终印式。comm (Y+X) (comm (Y+X) Z)的括号正确；h²/4项是[Z,[Y,X]]，无交换子符号反转。任意实结合代数上的形式论证足够，常数项为1。中间未合并推导省略不改变所审最终公式。

### 7. 状态与证明位置

- `MD.Ch07.threeStage`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.threeOperatorBCH`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-ScalarForwardOperators

印刷页 288 / PDF页 309。

### 1. 原文陈述

> In this one dimensional example, we substitute

$$
Z=\mathcal L_A^\dagger=-p\frac\partial{\partial q},\quad Y=\mathcal L_B^\dagger=U'(q)\frac\partial{\partial p},\quad X=\mathcal L_O^\dagger=\gamma\left({\rm Id}+p\frac\partial{\partial p}\right)+\frac{\sigma^2}{2}\frac{\partial^2}{\partial p^2},
$$


> where $`\sigma=\sqrt{2\gamma k_BT}`$.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
abbrev Density1 := (ℝ × ℝ) → ℝ
def dq (f : Density1) (x : ℝ × ℝ) : ℝ := deriv (fun q ↦ f (q,x.2)) x.1
def dp (f : Density1) (x : ℝ × ℝ) : ℝ := deriv (fun p ↦ f (x.1,p)) x.2
def opA (f : Density1) (x : ℝ × ℝ) : ℝ := -x.2*dq f x
def opB (U : ℝ → ℝ) (f : Density1) (x : ℝ × ℝ) : ℝ := deriv U x.1*dp f x
def opO (γ θ : ℝ) (f : Density1) (x : ℝ × ℝ) : ℝ := γ*(f x+x.2*dp f x)+γ*θ*dp (dp f) x
def opLD (U : ℝ → ℝ) (γ θ : ℝ) (f : Density1) : Density1 := opA f+opB U f+opO γ θ f
def opComm (A B : Density1 → Density1) (f : Density1) : Density1 := A (B f)-B (A f)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 Density1, dq, dp, opA, opB, opO, opLD, opComm 所列对象、量词、前提和结论。范围说明：Density1=(ℝ×ℝ)→ℝ，dq固定p，dp固定q，opA负号、opB力项正号、opO的γf零阶项及γθ二阶项均正确，θ=kBT。opLD是三者和，opComm是先AB再减BA。全函数空间上的deriv是总定义；光滑性、物理正参数及闭算子定义域资格仅在解释中使用，JSON明确没有把这些表达式直接宣称为闭生成元。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 所有偏导都是实际deriv，单位质量、θ=k\_BT；用于光滑密度与γ≥0,θ>0。这里不把未规定定义域的微分表达式直接称闭算符。

### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。Density1=(ℝ×ℝ)→ℝ，dq固定p，dp固定q，opA负号、opB力项正号、opO的γf零阶项及γθ二阶项均正确，θ=kBT。opLD是三者和，opComm是先AB再减BA。全函数空间上的deriv是总定义；光滑性、物理正参数及闭算子定义域资格仅在解释中使用，JSON明确没有把这些表达式直接宣称为闭生成元。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 Density1, dq, dp, opA, opB, opO, opLD, opComm 所列对象、量词、前提和结论。范围说明：Density1=(ℝ×ℝ)→ℝ，dq固定p，dp固定q，opA负号、opB力项正号、opO的γf零阶项及γθ二阶项均正确，θ=kBT。opLD是三者和，opComm是先AB再减BA。全函数空间上的deriv是总定义；光滑性、物理正参数及闭算子定义域资格仅在解释中使用，JSON明确没有把这些表达式直接宣称为闭生成元。

### 7. 状态与证明位置

- `MD.Ch07.Density1`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.dq`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.dp`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opA`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opB`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opO`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opLD`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.opComm`：定义；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-CommutatorAB

印刷页 288 / PDF页 309。

### 1. 原文陈述


$$
[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho=-p\frac\partial{\partial q}\left(U'(q)\frac{\partial\rho}{\partial p}\right)-U'(q)\frac\partial{\partial p}\left(-p\frac{\partial\rho}{\partial q}\right) =-pU''(q)\rho_p-pU'(q)\rho_{pq}+U'(q)\rho_q+U'(q)p\rho_{qp}.
$$


> As this is the commutator of two 1st order differential operators, the mixed partial term vanishes, leaving

$$
[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho=-pU''(q)\rho_p+U'(q)\rho_q.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem commutatorAB (U : ℝ → ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 2 U) (hρ : ContDiff ℝ 2 ρ) : ∀ x,
    opComm opA (opB U) ρ x = -x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 commutatorAB 所列对象、量词、前提和结论。范围说明：commutatorAB量化任意C²势U及C²二元ρ、每一点x；D65–D70给出实际偏导和AB−BA。C²保证混合偏导相等，乘积展开后恰为结论的两项。无质量/γ/温度遗漏，因为这是单位质量A、B的交换子。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口


### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。commutatorAB量化任意C²势U及C²二元ρ、每一点x；D65–D70给出实际偏导和AB−BA。C²保证混合偏导相等，乘积展开后恰为结论的两项。无质量/γ/温度遗漏，因为这是单位质量A、B的交换子。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 commutatorAB 所列对象、量词、前提和结论。范围说明：commutatorAB量化任意C²势U及C²二元ρ、每一点x；D65–D70给出实际偏导和AB−BA。C²保证混合偏导相等，乘积展开后恰为结论的两项。无质量/γ/温度遗漏，因为这是单位质量A、B的交换子。

### 7. 状态与证明位置

- `MD.Ch07.commutatorAB`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-CommutatorsAOBO

印刷页 289 / PDF页 310。

### 1. 原文陈述

> Similar computations give

$$
[\mathcal L_A^\dagger,\mathcal L_O^\dagger]\rho=\gamma p\rho_q+\sigma^2\rho_{qp},\qquad [\mathcal L_B^\dagger,\mathcal L_O^\dagger]\rho=\gamma U'(q)\rho_p.
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
theorem commutatorsAOBO (U : ℝ → ℝ) (ρ : Density1) (γ θ : ℝ)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    opComm opA (opO γ θ) ρ x = γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x ∧
    opComm (opB U) (opO γ θ) ρ x = γ*deriv U x.1*dp ρ x := by
  sorry
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | 仅覆盖 commutatorsAOBO 所列对象、量词、前提和结论。范围说明：commutatorsAOBO在U、ρ均C³下对每一点同时给出两式；2γθ=σ²，dq(dpρ)在此光滑性下等于印式混合偏导，BO符号为正。对所有实γ、θ的代数恒等式成立，不需物理正性。U∈C³比必要条件强但足够，未改变所给物理光滑对象上的结论。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口


### 6. 审计结论（含网站复审结论）

网站首轮结论：PASS。commutatorsAOBO在U、ρ均C³下对每一点同时给出两式；2γθ=σ²，dq(dpρ)在此光滑性下等于印式混合偏导，BO符号为正。对所有实γ、θ的代数恒等式成立，不需物理正性。U∈C³比必要条件强但足够，未改变所给物理光滑对象上的结论。
网站复审结论：本条未进入本轮复审，沿用首轮已绑定版本意见。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（首轮签名未改）。
本条实际覆盖：仅覆盖 commutatorsAOBO 所列对象、量词、前提和结论。范围说明：commutatorsAOBO在U、ρ均C³下对每一点同时给出两式；2γθ=σ²，dq(dpρ)在此光滑性下等于印式混合偏导，BO符号为正。对所有实γ、θ的代数恒等式成立，不需物理正性。U∈C³比必要条件强但足够，未改变所给物理光滑对象上的结论。

### 7. 状态与证明位置

- `MD.Ch07.commutatorsAOBO`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-OBAModifiedOperator

印刷页 288–289 / PDF页 309–310。

### 1. 原文陈述


$$
\exp(h\widehat{\mathcal L}_{[OBA]}^\dagger)=\exp(h\mathcal L_A^\dagger)\exp(h\mathcal L_B^\dagger)\exp(h\mathcal L_O^\dagger).
$$



$$
\widehat{\mathcal L}_{[OBA]}^\dagger\rho=\mathcal L_{LD}^\dagger\rho+\frac h2[-pU''(q)\rho_p+U'(q)\rho_q+\gamma p\rho_q+\sigma^2\rho_{qp}+\gamma U'(q)\rho_p]+O(h^2).
$$



### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def obaFirstCorrection (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1) (x : ℝ × ℝ) : ℝ :=
  (1/2)*(-x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x+
    γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x+γ*deriv U x.1*dp ρ x)
theorem obaFirstCorrection_commutators (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    obaFirstCorrection U γ θ ρ x = (1/2)*(opComm opA (opB U) ρ x+
      opComm opA (opO γ θ) ρ x+opComm (opB U) (opO γ θ) ρ x) := by
  intro x
  rw [commutatorAB U ρ (hU.of_le (by norm_num)) (hρ.of_le (by norm_num)),
    (commutatorsAOBO U ρ γ θ hU hρ x).1, (commutatorsAOBO U ρ γ θ hU hρ x).2]
  dsimp [obaFirstCorrection]
  ring
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只证明三个真实交换子表达式与所印一阶修正一致；整体离散传播子的余项界需Taylor/弱展开桥，不声称完成。
- 29号覆盖限定：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。
- 覆盖缺口：29号覆盖限定：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。

### 6. 审计结论（含网站复审结论）

网站首轮结论：FAIL。obaFirstCorrection以θ替代kBT，五项各乘1/2，正确。obaFirstCorrection\_commutators在C³下仅证明此表达式等于三个实际交换子之和的一半，完全正确。但没有OBA前向乘积对象、log/h系数、LLD零阶或余项陈述，未把该函数认定为数值方案修改生成元的一阶系数。extra\_assumptions承认该桥未做，因而完整两条原式的覆盖仍FAIL；不是因sorry或证明状态。
网站复审结论：PASS。单位质量的一维设定下，θ=k\_BT给σ²=2γθ，五个导数项的符号和系数全部一致。U、ρ的C³资格足以展开三项真实交换子和交换混合偏导；γ、θ无需正性即可成立该纯微分代数恒等式。公式中的O(h²)属于源文的形式修改生成元展开，当前Lean并无关于h、乘积对数或余项范数的结论，且已准确披露。
按版本登记：原文、修正版及范围解释见网站原始意见；不把签名通过当作证明完成。
当前状态：网站PASS（复审绑定版本）。
本条实际覆盖：OBA候选一阶微分表达式及其与三个真实交换子和的恒等式；未识别OBA乘积的log/h或弱修改生成元余项。

### 7. 状态与证明位置

- `MD.Ch07.obaFirstCorrection`：定义；网站：PASS（送审签名未变）
- `MD.Ch07.obaFirstCorrection_commutators`：未证；缺大型理论；网站：PASS（送审签名未变）

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

## MD-7.7.2-SpectralQualification

印刷页 289 / PDF页 310。

### 1. 原文陈述

> The assumption of validity becomes more credible as we find that the operator $`\mathcal L_{LD}^\dagger`$ has a compact resolvent and therefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous chapter. It will have one zero eigenvalue corresponding to the invariant density $`\rho_\beta`$ and all the remaining eigenvalues lie in the negative half plane.

### 2. 原文证明

> 原页推导与上下文全文见original\_page\_text；数学符号的排版以随附原页PDF为准。

### 3. 完整当前Lean（原文与修正版独立保留）

```lean
def simpleEigenvalue {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (eigen : ℂ) : Prop := Module.finrank ℂ (Module.End.eigenspace L eigen) = 1
def printedSpectralConclusion {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧ ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    simpleEigenvalue L eigen ∧ (eigen = 0 ∨ eigen.re < 0)

def spectralConclusionPrinted {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop := printedSpectralConclusion L ρ

def spectralConclusionPrinted_corrected {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧
  (∀ v : E, L v = 0 → v ∈ Submodule.span ℂ ({ρ} : Set E)) ∧
  ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    FiniteDimensional ℂ (Module.End.eigenspace L eigen) ∧ (eigen = 0 ∨ eigen.re < 0)
```

### 4. 对照表

| 原文对象或结论 | 实际覆盖 |
|---|---|
| 所选数学成分 | Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。 |
| 对象、量词、前提 | 见完整声明与下方新增资格 |

### 5. [EXTRA] 与覆盖缺口

- 只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。
- 29号覆盖限定：Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。
- 覆盖缺口：只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。

### 6. 审计结论（含网站复审结论）

网站首轮结论：NEEDS\_HUMAN。分别审校：simpleEigenvalue定义的是特征空间维数1（几何单重），不是通常谱论的代数单重。printedSpectralConclusion及spectralConclusionPrinted忠实保留“所有特征值单重、0对应ρ、其他实部负”的点谱目标，但没有紧预解式或完整谱的对象，也没有代数重数。_corrected把所有特征空间改为有限维，改掉“离散⇒单重”的错误方向是合理的；然而同时删掉零特征值应为唯一不变密度方向的约束，且有限维几何特征空间不等同于离散谱及有限代数重数。它只是较弱目标谓词，不是已得到的Langevin谱定理，也不是完整修正。由于原书错误及应保留哪些额外结论需人工决定，总判NEEDS\_HUMAN。
网站复审结论：NEEDS\_HUMAN。按已披露的范围，三个Printed/别名定义忠实记录原文的“点谱、几何单重”部分，corrected是较弱的点谱候选而不是已经证明的结论。原文“离散谱即单重谱”是实质数学疑误；此外几何单重不能代替代数单重，完整的原书谱论含义仍需人工选定，因此整体NEEDS\_HUMAN，不将源文错误隐改后判PASS。
按版本登记：网站仅认可已披露的点谱/几何单重定义；corrected仍是较弱候选Prop，未获完整紧预解式谱定理的PASS，不计为修正版定理通过。
当前状态：原文疑误或范围待导师；限定定义与分版本意见另列。
本条实际覆盖：Printed的simpleEigenvalue仅几何单重；修正版是较弱点谱目标并补零核方向唯一，不含完整谱、孤立性或有限代数重数，绝非紧预解式谱定理。

### 7. 状态与证明位置

- `MD.Ch07.simpleEigenvalue`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.printedSpectralConclusion`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.spectralConclusionPrinted`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS
- `MD.Ch07.spectralConclusionPrinted_corrected`：定义；网站：见原始报告的分版本意见；不推定完整定理PASS

位置：Blueprint/Ch07.lean。所有当前声明的编译和公理输出均已逐项核对。

