[上一部分](part01.zh-CN.md) / [目录](../../CH01_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

## 1. MD-1.1.2-AngleBond · definition · 印刷p.13 / PDFp.36

### 2. 原文陈述

> When a trio of atoms with labels $`i`$, $`j`$, and $`k`$ admits a pair of length bonds, say $`(i,j)`$ and $`(j,k)`$, then an additional three-body term will need to be incorporated:

$$
\varphi_{ijk}^{\mathrm{ang}}=\frac{k_{ijk}^{\mathrm{ang}}}{2}(\theta_{ijk}-\theta_{ijk}^0)^2,
$$


> where the angle $`\theta_{ijk}`$ is given in terms of the positions as

$$
\theta_{ijk}=\arccos\frac{(\boldsymbol q_i-\boldsymbol q_j)\cdot(\boldsymbol q_j-\boldsymbol q_k)}{r_{ij}r_{jk}}.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def angleBondModel (k θ₀ : ℝ) (qᵢ qⱼ qₖ : V3) : ℝ :=
  k / 2 * (Real.arccos (inner ℝ (qᵢ-qⱼ) (qⱼ-qₖ) /
    (‖qᵢ-qⱼ‖ * ‖qⱼ-qₖ‖)) - θ₀)^2

/-- Physical angle domain; both directed bonds have strictly positive length. -/
def AngleBondValidDomain (qᵢ qⱼ qₖ : V3) : Prop :=
  0 < ‖qᵢ-qⱼ‖ ∧ 0 < ‖qⱼ-qₖ‖

def angleBondOnDomain (k θ₀ : ℝ) (qᵢ qⱼ qₖ : V3)
    (_h : AngleBondValidDomain qᵢ qⱼ qₖ) : ℝ := angleBondModel k θ₀ qᵢ qⱼ qₖ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.angleBondOnDomain；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\varphi_{ijk}^{\mathrm{ang}}=\frac{k_{ijk}^{\mathrm{ang}}}{2}(\theta_{ijk}-\theta_{ijk}^0)^2,`$；$`\theta_{ijk}=\arccos\frac{(\boldsymbol q_i-\boldsymbol q_j)\cdot(\boldsymbol q_j-\boldsymbol q_k)}{r_{ij}r_{jk}}.`$ | MD.Ch01.angleBondModel，完整展开陈述见上一行及第4段 | 一致 |
| 21号网站建议修复 | MD.Ch01.angleBondOnDomain | 总化辅助angleBondModel保留；angleBondOnDomain强制两键长严格正，有向差不改。 |

[EXTRA] [EXTRA] 总化辅助angleBondModel保留；angleBondOnDomain强制两键长严格正，有向差不改。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：总化辅助angleBondModel保留；angleBondOnDomain强制两键长严格正，有向差不改。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
公式在非零两键长上PASS，V3、内积、两范数乘积、arccos及弹簧系数均与原页一致。但当前angleBondModel接受所有三位置，没有非零键长的子类型或前提，context\_notation所说“两键长非零”没有落实，也未声明零分母仅是辅助总化扩展。Lean的除零为0会在原书角度未定义的重合构形给出实势，故按完整对象/域要求FAIL。k正也只是物理上下文，并非签名前提；本次不把原书的有向差约定自行换成通常补角约定。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:489；MD.Ch01.angleBondOnDomain。

## 1. MD-1.1.2-Dihedral · definition · 印刷p.13 / PDFp.36

### 2. 原文陈述

> Dihedral potentials typically are modelled using a trigonometric potential function, as

$$
\varphi_{ijkl}^{\mathrm{dih}}=k_{ijkl}^{\mathrm{dih}}[1+\cos(n_{ijkl}^{\mathrm{dih}}\eta_{ijkl}-d_{ijkl}^{\mathrm{dih}})].
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def dihedralPotential (k n θ d : ℝ) := k*(1+Real.cos (n*θ-d))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.dihedralPotential；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\varphi_{ijkl}^{\mathrm{dih}}=k_{ijkl}^{\mathrm{dih}}[1+\cos(n_{ijkl}^{\mathrm{dih}}\eta_{ijkl}-d_{ijkl}^{\mathrm{dih}})].`$ | MD.Ch01.dihedralPotential，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:497；MD.Ch01.dihedralPotential。

## 1. MD-1.1.2-GayBerne · Example 1.2 · 印刷p.16–17 / PDFp.39–40

### 2. 原文陈述

> The potential energy may be written as

$$
\varphi_{\mathrm{GB}}(\boldsymbol q_1,\boldsymbol q_2,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=4\epsilon_{\mathrm{GB}}\left[\left(\frac{\sigma_0}{\Delta}\right)^{12}-\left(\frac{\sigma_0}{\Delta}\right)^6\right],
$$



$$
\epsilon_{\mathrm{GB}}(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2),
$$


> with

$$
\Delta(\boldsymbol r,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\|\boldsymbol r\|-\sigma_0/\sqrt{W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)},
$$



$$
\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_0[1-\chi^2(\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2)^2]^{-1/2},\qquad\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi'),
$$


> and

$$
W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)\stackrel{\mathrm{def}}=1-\frac\chi2\left[\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1+\hat{\boldsymbol u}_2))^2}{1+\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}+\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1-\hat{\boldsymbol u}_2))^2}{1-\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}\right].
$$


> Finally

$$
\chi=\frac{[\sigma_e/\sigma_s]^2-1}{[\sigma_e/\sigma_s]^2+1},\qquad\chi'=\frac{1-[\epsilon_e/\epsilon_s]^{1/\mu}}{1+[\epsilon_e/\epsilon_s]^{1/\mu}}.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def gayBerneModel (ε₀ σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3) : ℝ :=
  let r := q₂ - q₁
  let χ := gayBerneChi σₑ σₛ
  let χ' := gayBerneChiPrime εₑ εₛ μ
  let Δ := ‖r‖ - σ₀ / Real.sqrt (gayBerneW (‖r‖⁻¹ • r) u₁ u₂ χ)
  let εGB := gayBerneEpsilonOne ε₀ χ u₁ u₂ * gayBerneEpsilonTwo (‖r‖⁻¹ • r) u₁ u₂ χ'
  4 * εGB * ((σ₀ / Δ)^12 - (σ₀ / Δ)^6)

/-- Effective Gay--Berne domain: all divisions and both square roots are physical. -/
def GayBerneValidDomain (σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3) : Prop :=
  let r := q₂-q₁
  let rhat := ‖r‖⁻¹ • r
  let χ := gayBerneChi σₑ σₛ
  let χ' := gayBerneChiPrime εₑ εₛ μ
  ‖u₁‖ = 1 ∧ ‖u₂‖ = 1 ∧ q₁ ≠ q₂ ∧
  σₛ ≠ 0 ∧ εₛ ≠ 0 ∧ μ ≠ 0 ∧
  ((σₑ/σₛ)^2+1) ≠ 0 ∧ (1+Real.rpow (εₑ/εₛ) (1/μ)) ≠ 0 ∧
  (1+χ*inner ℝ u₁ u₂) ≠ 0 ∧ (1-χ*inner ℝ u₁ u₂) ≠ 0 ∧
  (1+χ'*inner ℝ u₁ u₂) ≠ 0 ∧ (1-χ'*inner ℝ u₁ u₂) ≠ 0 ∧
  0 < 1-χ^2*(inner ℝ u₁ u₂)^2 ∧ 0 < gayBerneW rhat u₁ u₂ χ ∧
  (‖r‖-σ₀/Real.sqrt (gayBerneW rhat u₁ u₂ χ)) ≠ 0

def gayBerneOnDomain (ε₀ σ₀ σₑ σₛ εₑ εₛ μ : ℝ) (q₁ q₂ u₁ u₂ : V3)
    (_h : GayBerneValidDomain σ₀ σₑ σₛ εₑ εₛ μ q₁ q₂ u₁ u₂) : ℝ :=
  gayBerneModel ε₀ σ₀ σₑ σₛ εₑ εₛ μ q₁ q₂ u₁ u₂
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.gayBerneOnDomain；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\varphi_{\mathrm{GB}}(\boldsymbol q_1,\boldsymbol q_2,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=4\epsilon_{\mathrm{GB}}\left[\left(\frac{\sigma_0}{\Delta}\right)^{12}-\left(\frac{\sigma_0}{\Delta}\right)^6\right],`$；$`\epsilon_{\mathrm{GB}}(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2),`$；$`\Delta(\boldsymbol r,\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\Vert \boldsymbol r\Vert -\sigma_0/\sqrt{W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)},`$；$`\epsilon_1(\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=\epsilon_0[1-\chi^2(\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2)^2]^{-1/2},\qquad\epsilon_2(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2)=W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi'),`$；$`W(\hat{\boldsymbol r},\hat{\boldsymbol u}_1,\hat{\boldsymbol u}_2,\chi)\stackrel{\mathrm{def}}=1-\frac\chi2\left[\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1+\hat{\boldsymbol u}_2))^2}{1+\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}+\frac{(\hat{\boldsymbol r}\cdot(\hat{\boldsymbol u}_1-\hat{\boldsymbol u}_2))^2}{1-\chi\hat{\boldsymbol u}_1\cdot\hat{\boldsymbol u}_2}\right].`$；$`\chi=\frac{[\sigma_e/\sigma_s]^2-1}{[\sigma_e/\sigma_s]^2+1},\qquad\chi'=\frac{1-[\epsilon_e/\epsilon_s]^{1/\mu}}{1+[\epsilon_e/\epsilon_s]^{1/\mu}}.`$ | MD.Ch01.gayBerneModel，完整展开陈述见上一行及第4段 | 一致 |
| εGB=ε₁ε₂ | gayBerneEpsilonOne … * gayBerneEpsilonTwo …，没有平方ε₂ | 一致；旧正式定义平方与原页不同，未桥接 |
| ρ、χ、χ′及各向异性参数 | gayBerneModel的r/χ/χ′/Δ定义及原始定义文件 | 一致 |
| 21号网站建议修复 | MD.Ch01.gayBerneOnDomain | 原公式为总化辅助；有效域落实单位取向、非碰撞、根号严格正、参数及全部分母非零、Δ≠0；ε₂次数和Δ原样保留。 |

[EXTRA] [EXTRA] 原公式为总化辅助；有效域落实单位取向、非碰撞、根号严格正、参数及全部分母非零、Δ≠0；ε₂次数和Δ原样保留。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：原公式为总化辅助；有效域落实单位取向、非碰撞、根号严格正、参数及全部分母非零、Δ≠0；ε₂次数和Δ原样保留。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
全部代数展开在原书正常域上PASS：r=q₂−q₁、r̂=‖r‖⁻¹r，ε₁=ε₀/√(1−χ²(u₁·u₂)²)，ε₂=W(...,χ′)，W的两分母和正负号、χ与χ′的定义均一致。但Lean参数u₁,u₂仅为任意V3，不是原书的单位取向；q₁≠q₂、根号内严格正、σₛ/εₛ/μ及各有理式分母非零、Δ≠0均未编码。context\_notation已经明确这些域限定，却无相应[EXTRA]总化说明或有效域模型。总除法、Real.sqrt及Real.rpow会对非法参数继续返回值，因此完整域审校FAIL；不以旧库不同公式作为依据。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:526；MD.Ch01.gayBerneOnDomain。

## 1. MD-1.2-NewtonCompact · definition · 印刷p.18 / PDFp.41

### 2. 原文陈述

> In this book, we shall frequently use a compact, vectorial notation, where $`\boldsymbol q`$ and $`\dot{\boldsymbol q}`$ represent vectors of the positions and velocities, and $`\boldsymbol M`$ is a diagonal mass matrix, so the equations of motion (1.2) become

$$
\boldsymbol M\frac{\mathrm d^2}{\mathrm dt^2}\boldsymbol q=\boldsymbol F(\boldsymbol q)=-\nabla U(\boldsymbol q).\tag{1.3}
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def compactNewton {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : ℝ → Position n) (t : ℝ) : Prop :=
  HasDerivAt q (deriv q t) t ∧ HasDerivAt (deriv q) (deriv (deriv q) t) t ∧
  DifferentiableAt ℝ U (q t) ∧
  massOperator m (deriv (deriv q) t) = -gradient U (q t)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.compactNewton；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol M\frac{\mathrm d^2}{\mathrm dt^2}\boldsymbol q=\boldsymbol F(\boldsymbol q)=-\nabla U(\boldsymbol q).\quad\text{(1.3)}`$ | MD.Ch01.compactNewton，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 真实二阶可微资格写成HasDerivAt，避免总导数对不可微曲线给伪解。 | [EXTRA] |
| 21号网站建议修复 | MD.Ch01.compactNewton | 在原有两项真实时间导数资格后增加势能在q(t)处可微。 |

[EXTRA] 真实二阶可微资格写成HasDerivAt，避免总导数对不可微曲线给伪解。；[EXTRA] 在原有两项真实时间导数资格后增加势能在q(t)处可微。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：在原有两项真实时间导数资格后增加势能在q(t)处可微。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
时间一、二阶HasDerivAt确实阻止不可微q被总导数当伪解；massOperator通过Matrix.diagonal逐坐标作用，等式确为M q″=−gradient U。泛化维数n和任意对角实参数可作原式的代数模板，三维粒子物理使用须取n=3N及正质量三次重复。关键缺项是U:Position n→ℝ没有在q t可微的前提，gradient的总化定义仍可在不可微势点返回0，故未完整表达经典Newton力；[EXTRA]只修复了轨迹导数，没有修复势能梯度资格。域审校FAIL。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:540；MD.Ch01.compactNewton。

## 1. MD-1.2-DegreesFreedom · definition · 印刷p.18 / PDFp.41

### 2. 原文陈述

> The number of local directions in which the configurational (position) state can be varied is called the number of degrees of freedom $`N_d`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
/- Linear algebra auxiliary; geometric validity is stated by constraintdimension. -/
def linearizedConstraintDimension {n r : ℕ} (C : Position n → Position r) (q : Position n) :=
  Module.finrank ℝ (LinearMap.ker (fderiv ℝ C q).toLinearMap)

def degreesOfFreedom {n r : ℕ} (C : Position n → Position r) (c : Position r)
    (q : {x : Position n // C x = c ∧ ContDiffAt ℝ 1 C x ∧
      Function.Surjective (fderiv ℝ C x)}) : ℕ := linearizedConstraintDimension C q.val
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.degreesOfFreedom；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 在可微约束C局部正则层中以导数核维数表示；无约束取零约束。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.linearizedConstraintDimension; MD.Ch01.degreesOfFreedom | 只对C¹正则约束层的可行点定义自由度；原核维数更名为线性化辅助量，下一条补真实局部坐标等价。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.linearizedConstraintDimension; MD.Ch01.degreesOfFreedom | 只对C¹正则约束层的可行点定义自由度；原核维数更名为线性化辅助量，下一条补真实局部坐标等价。 |

[EXTRA] 在可微约束C局部正则层中以导数核维数表示；无约束取零约束。；[EXTRA] 19号：只对C¹正则约束层的可行点定义自由度；原核维数更名为线性化辅助量，下一条补真实局部坐标等价。

### 6. 审计结论

19号本地签名预审：只对C¹正则约束层的可行点定义自由度；原核维数更名为线性化辅助量，下一条补真实局部坐标等价。

网站：网站PASS（EAUDIT复审）。
PASS。linearizedConstraintDimension仅是线性代数辅助量，等于实线性映射fderiv C q的核的finrank。degreesOfFreedom的q不是任意点，而是C q=c、C在q为C¹、导数满射的可行点子类型；在该正则层由隐函数定理，核正是局部可行方向空间。n为构形维数、r为独立约束数，值为自然数；r=0包含无约束情形。没有把奇异点的线性化核维数冒充真实几何维数。与最新[EXTRA]及下一条局部坐标解释一致。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:554；MD.Ch01.degreesOfFreedom。

## 1. MD-1.2-ConstraintDimension · unnumbered_claim · 印刷p.18 / PDFp.41

### 2. 原文陈述

> For the N-body system in $`\mathbb R^3`$ without additional constraints there are $`N_d=N_c=3N`$ degrees of freedom. If $`r`$ independent constraints are present the number of degrees of freedom is $`N_d=N_c-r`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem constraintdimension {n r : ℕ} (C : Position n → Position r) (c : Position r)
    (q : {x : Position n // C x = c ∧ ContDiffAt ℝ 1 C x ∧
      Function.Surjective (fderiv ℝ C x)}) :
    degreesOfFreedom C c q + r = n ∧
    ∃ (U : Set (Position n)) (V : Set (Position (degreesOfFreedom C c q) × Position r))
      (φ : Position n → Position (degreesOfFreedom C c q) × Position r)
      (ψ : Position (degreesOfFreedom C c q) × Position r → Position n),
      IsOpen U ∧ IsOpen V ∧ q.val ∈ U ∧
      ContDiffOn ℝ 1 φ U ∧ ContDiffOn ℝ 1 ψ V ∧
      MapsTo φ U V ∧ MapsTo ψ V U ∧ LeftInvOn ψ φ U ∧ LeftInvOn φ ψ V ∧
      (∀ x ∈ U, C x = c ↔ (φ x).2 = 0) := by
  sorry

/-- Unconstrained three-dimensional N-particle specialization, not a geometry assumption. -/
theorem constraintdimension_unconstrained (N : ℕ) :
    linearizedConstraintDimension (fun _ : Position (3*N) => (0 : Position 0)) 0 = 3*N := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.constraintdimension；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 约束映射可微，独立约束=导数满射；n=Nc，r≤n由满射推出。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.constraintdimension; MD.Ch01.constraintdimension\_unconstrained | 保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.constraintdimension; MD.Ch01.constraintdimension\_unconstrained | 保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。 |

[EXTRA] 约束映射可微，独立约束=导数满射；n=Nc，r≤n由满射推出。；[EXTRA] 19号：保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。

### 6. 审计结论

19号本地签名预审：保留n−r及无约束3N分句，增加C¹正则层到d维自由坐标的真实双向局部图；一般隐函数图构造缺证明，sorry，旧秩零度不冒充几何结论。

网站：网站PASS（EAUDIT复审）。
PASS。主定理的q子类型明确C¹正则可行点和fderiv满射，保证r≤n；结论degreesOfFreedom+r=n避免自然数减法截断。全部局部图分句已核对：U,V开放、q∈U、φ/ψ为C¹、双向MapsTo及两侧LeftInvOn，使U与V局部微分同胚；C x=c当且仅当φ(x)第二分量为0，给出d维自由坐标的真实层结构。constraintdimension\_unconstrained另以Position (3N)上的零个约束给核维数3N，覆盖无约束分句。局部图构造的sorry仅是证明未完成，不使正确签名FAIL。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:562；MD.Ch01.constraintdimension。

## 1. MD-1.2-TotalEnergy · definition · 印刷p.18 / PDFp.41

### 2. 原文陈述

> The total energy of the N-body system is a function of positions and velocities,

$$
E(\boldsymbol q_1,\ldots,\boldsymbol q_N,\dot{\boldsymbol q}_1,\ldots,\dot{\boldsymbol q}_N)=\sum_{j=1}^{N}\frac{m_j\|\dot{\boldsymbol q}_j\|^2}{2}+U(\boldsymbol q_1,\ldots,\boldsymbol q_N).\tag{1.4}
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def particleTotalEnergy {N : ℕ} (m : Fin N → ℝ) (U : (Fin N → V3) → ℝ)
    (q v : Fin N → V3) : ℝ := (∑ j, m j * ‖v j‖^2 / 2) + U q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.particleTotalEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`E(\boldsymbol q_1,\ldots,\boldsymbol q_N,\dot{\boldsymbol q}_1,\ldots,\dot{\boldsymbol q}_N)=\sum_{j=1}^{N}\frac{m_j\Vert \dot{\boldsymbol q}_j\Vert ^2}{2}+U(\boldsymbol q_1,\ldots,\boldsymbol q_N).\quad\text{(1.4)}`$ | MD.Ch01.particleTotalEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
PASS。N个三维位置q、速度v和粒子质量m，U以完整构形Fin N→V3为自变量；定义恰是Σ\_j m\_j‖v\_j‖²/2+U(q)。此为相空间能量函数定义，v是独立速度变量，不需在本定义中绑定某条轨迹导数。m允许任意实数是该代数式的扩展，物理正质量子域自然包含其中，未声称未加前提的能量正性或守恒。没有漏掉求和粒子或把势能逐粒子重复相加。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:584；MD.Ch01.particleTotalEnergy。

## 1. MD-1.2-PairCancellation · unnumbered_claim · 印刷p.19 / PDFp.42

### 2. 原文陈述

> This means that the sum of all the forces will vanish.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem paircancellation :
  ∀ (N : ℕ) (F : Fin N → Fin N → V3),
    (∀ i, F i i = 0) → (∀ i j, F i j = -F j i) → ∑ i, ∑ j, F i j = 0 := by
  intro N F _ hanti
  have h : (∑ i, ∑ j, F i j) = -(∑ i, ∑ j, F i j) := by
    calc
      (∑ i, ∑ j, F i j) = ∑ j, ∑ i, F i j := Finset.sum_comm
      _ = ∑ j, ∑ i, -F j i := by
        apply Finset.sum_congr rfl
        intro j _
        apply Finset.sum_congr rfl
        intro i _
        exact hanti i j
      _ = -(∑ j, ∑ i, F j i) := by simp only [Finset.sum_neg_distrib]
  have hcoord (k : Fin 3) : (∑ i, ∑ j, F i j) k = 0 := by
    have hk := congrArg (fun v : V3 => v k) h
    simp only [PiLp.neg_apply] at hk
    linarith
  ext k
  exact hcoord k
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.paircancellation；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | Fi i=0，内部两体力反对称；无外力。 | [EXTRA] |

[EXTRA] Fi i=0，内部两体力反对称；无外力。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
PASS。对任意自然数N和V3值的全有序粒子对力表F，假设对角零及所有i,j反对称，结论全双和为零，恰是全部内力合力抵消。对角零其实由反对称在实向量空间已推出，冗余不改变意义；全双和与无自力的j≠i求和相符。无外力的解释已在前提力表及[EXTRA]中明确，没有把结论净力零预先当假设。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:591；MD.Ch01.paircancellation。

## 1. MD-1.2-MomentumConservation · unnumbered_claim · 印刷p.19 / PDFp.42

### 2. 原文陈述

> and thus the three components of the total momentum vector $`\boldsymbol p_{\mathrm{tot}}:=\sum_{i=1}^{N}\boldsymbol p_i`$ will be conserved quantities.

### 3. 原文证明

> Since

$$
\frac{\mathrm d\boldsymbol p_i}{\mathrm dt}=\boldsymbol F_i,
$$


> we have

$$
\sum_{i=1}^{N}\frac{\mathrm d\boldsymbol p_i}{\mathrm dt}=\sum_{i=1}^{N}\boldsymbol F_i=0
$$


按渲染原页逐字转录原文论证。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem momentum_conservation :
  ∀ (N : ℕ) (m : Fin N → ℝ) (v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I → IsPreconnected I →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, (∑ i, ∑ j, F t i j) = 0) ∧
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) ∧
    ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i • v a i) = ∑ i, m i • v b i := by
  intro N m v F I ho hi hanti hNewton
  have hz (t : ℝ) (ht : t ∈ I) : (∑ i, ∑ j, F t i j) = 0 := by
    apply paircancellation N (F t)
    · intro i
      ext k
      have h := congrArg (fun u : V3 => u k) (hanti t ht i i)
      simp only [PiLp.neg_apply] at h
      change (F t i i) k = 0
      linarith
    · exact hanti t ht
  have hd (t : ℝ) (ht : t ∈ I) : HasDerivAt (fun s => ∑ i, m i • v s i) 0 t := by
    have h := HasDerivAt.fun_sum (u := Finset.univ) (fun i _ => hNewton t ht i)
    rwa [hz t ht] at h
  refine ⟨hz,hd,?_⟩
  intro a ha b hb
  exact ho.is_const_of_deriv_eq_zero hi
    (fun t ht => (hd t ht).differentiableAt.differentiableWithinAt)
    (fun t ht => (hd t ht).deriv) ha hb
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.momentum\_conservation；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 两体力反向，净力相消 | F t i j = -F t j i → (∑ i, ∑ j, F t i j)=0 | 一致；净力为零是结论 |
| 全向量/每坐标动量守恒 | 真实HasDerivAt (∑ i,m i • v s i) 0及任意a,b∈I的值相等 | 一致 |
| 原文未显式量化的技术资格 | 真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。 | [EXTRA] |

[EXTRA] 真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。

### 6. 审计结论

审查后去掉旧桥接中净力零前提，由真实逐对作用反对称推出净力零和全向量/每坐标动量守恒，保留全部结论。

网站：网站PASS（EAUDIT复审）。
PASS。N任意，m为与时间无关的实质量，v给三维速度，pᵢ(t)=mᵢ•vᵢ(t)。I开放连通；F为全时间有序粒子对力，逐对反对称以及每个pᵢ的真实导数等于Σ\_jF\_ij为前提。三个完整结论依次是净内力零、总动量HasDerivAt零、任意a,b∈I的总动量相等；第三个向量等式同时给出三个分量守恒。质量正性不是这条代数守恒推论所必需；未把净力零或守恒偷放到假设中。[EXTRA]全部相符。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:616；MD.Ch01.momentum\_conservation。

## 1. MD-1.2-HarmonicSolution · Example 1.3 · 印刷p.19–20 / PDFp.42–43

### 2. 原文陈述

> Example 1.3 (Harmonic Oscillator) Consider the system

$$
\dot x=v,\qquad\dot v=-\Omega^2x.
$$


> This system describes the behavior of a particle with unit mass in one dimension, with energy function $`E(x,\dot x)=\dot x^2/2+\Omega^2x^2/2`$, where its motion is governed by a linear 2nd order equation $`\ddot x+\Omega^2x=0`$. The solution, for given $`x(0)=\xi`$, $`\dot x(0)=v(0)=\eta`$, is

$$
x(t)=\xi\cos(\Omega t)+\frac\eta\Omega\sin(\Omega t).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def harmonicEnergy {n : ℕ} (Ω : ℝ) (z : PhaseSpace n) : ℝ :=
  ‖z.2‖^2 / 2 + Ω^2 * ‖z.1‖^2 / 2

theorem harmonicEnergy_eq_massHamiltonian {n : ℕ} (Ω : ℝ) (z : PhaseSpace n) :
    harmonicEnergy Ω z = massHamiltonian (fun _ : Fin n => (1 : ℝ))
      (harmonicPotential Ω) z := by
  simp [harmonicEnergy, massHamiltonian, massSeparableEnergy,
    SeparableEnergy.hamiltonian, momentumKineticEnergy, harmonicPotential,
    nBodyKineticEnergy, EuclideanSpace.real_norm_sq_eq, Finset.sum_div,
    Finset.mul_sum, mul_div_assoc]

theorem harmonic_solution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n) :
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ)) (fun q => (-(Ω^2)) • q)
      univ univ (fun t => harmonicFlow Ω t z) ∧
    harmonicFlow Ω 0 z = z ∧
    (∀ t, (harmonicFlow Ω t z).1 = Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2) ∧
    (∀ t, harmonicEnergy Ω (harmonicFlow Ω t z) = harmonicEnergy Ω z) ∧
    (∀ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ)) (fun q => (-(Ω^2)) • q)
        univ univ γ → γ 0 = z → ∀ t, γ t = harmonicFlow Ω t z) := by
  refine ⟨harmonicFlow_isMechanicalSolution Ω hΩ z, harmonicFlow_zero Ω z,
    (fun _ => rfl), ?_, ?_⟩
  · intro t
    simpa only [harmonicEnergy_eq_massHamiltonian] using harmonicFlow_energy Ω hΩ z t
  · intro γ hγ hinit t
    have heq := mechanicalSolution_unique_on_preconnected_of_contDiffAt
      isOpen_univ isPreconnected_univ (mem_univ (0 : ℝ)) hγ
      (harmonicFlow_isMechanicalSolution Ω hΩ z)
      (fun s _ => mechanicalVectorField_contDiffAt _ _ (γ s) (by fun_prop))
      (by simpa using hinit)
    exact heq (mem_univ t)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.harmonic\_solution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\dot x=v,\qquad\dot v=-\Omega^2x.`$；$`x(t)=\xi\cos(\Omega t)+\frac\eta\Omega\sin(\Omega t).`$ | MD.Ch01.harmonic\_solution，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | Ω≠0是原式除法的域条件；n维解按坐标推广，原文为n=1。 | [EXTRA] |
| 21号网站建议修复 | MD.Ch01.harmonic\_solution | 补范数平方能量、与质量Hamiltonian的识别和守恒；复用已有ODE唯一性，短证任意同初值全时间机械解等于显式流（首条路线通过）。 |

[EXTRA] Ω≠0是原式除法的域条件；n维解按坐标推广，原文为n=1。；[EXTRA] 补范数平方能量、与质量Hamiltonian的识别和守恒；复用已有ODE唯一性，短证任意同初值全时间机械解等于显式流（首条路线通过）。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：补范数平方能量、与质量Hamiltonian的识别和守恒；复用已有ODE唯一性，短证任意同初值全时间机械解等于显式流（首条路线通过）。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
已写的harmonic\_solution本身正确：PASS其动力学、全实时间域、单位质量、初值和位置公式。PhaseSpace第二分量是动量，单位质量下等于速度；mechanicalVectorField的第一分量确为该速度，harmonicFlow第二分量也是位置的真实导数，n=1还原原式。按本任务“全部对象/完整结论”审校，仍有覆盖缺项：所给同source全部声明/依赖没有定义或连接原句的能量E=|v|²/2+Ω²|x|²/2；且只验证所构造的流，不含“任意满足该初值的解都由此公式给出”的唯一性结论。此FAIL是完整覆盖失败，不是现有显式式为假，不涉及sorry。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:659；MD.Ch01.harmonic\_solution。

## 1. MD-1.2-ScalarMechanical · Example 1.4 · 印刷p.20 / PDFp.43

### 2. 原文陈述

> Example 1.4 (Single Degree of Freedom) Consider a simple system with a single degree of freedom (with unit mass $`m=1`$ for simplicity) and energy function $`E(x,\dot x)=\dot x^2/2+U(x)`$ (which includes the harmonic oscillator as a special case). The equations of motion are

$$
\dot x=v,\qquad\dot v=-\frac{\partial U}{\partial x}.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def scalarMechanicalEnergy (U : ℝ → ℝ) (z : ℝ × ℝ) : ℝ :=
  z.2^2 / 2 + U z.1

/-- E explicitly names this model's prescribed mechanical energy. -/
def scalarMechanicalModel (U : ℝ → ℝ) (E : ℝ × ℝ → ℝ) (z : ℝ → ℝ × ℝ) : Prop :=
  E = scalarMechanicalEnergy U ∧
  ∀ t, DifferentiableAt ℝ U (z t).1 ∧ HasDerivAt z ((z t).2, -deriv U (z t).1) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.scalarMechanicalModel；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\dot x=v,\qquad\dot v=-\frac{\partial U}{\partial x}.`$ | MD.Ch01.scalarMechanicalModel，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.scalarMechanicalModel | 沿轨迹势能可微，禁止不可微处deriv默认零被解释为经典力。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.scalarMechanicalModel | 沿轨迹势能可微，禁止不可微处deriv默认零被解释为经典力。 |
| 21号网站建议修复 | MD.Ch01.scalarMechanicalModel | 补E\_U(x,v)=v²/2+U(x)，模型以显式能量参数E等于该定义连接；原有导数条件保留。 |

[EXTRA] [EXTRA] 19号：沿轨迹势能可微，禁止不可微处deriv默认零被解释为经典力。；[EXTRA] 补E\_U(x,v)=v²/2+U(x)，模型以显式能量参数E等于该定义连接；原有导数条件保留。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：补E\_U(x,v)=v²/2+U(x)，模型以显式能量参数E等于该定义连接；原有导数条件保留。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
scalarMechanicalModel的动力学部分PASS：任意实势U、实时间相轨迹z，逐时刻要求U在位置可微，HasDerivAt z (v,−U′(x))同时给出真实x′=v及v′=−U′，与单位质量方程相符，最新[EXTRA]也落实。完整条目仍FAIL：原句还定义E(x,ẋ)=ẋ²/2+U(x)，而所给全部当前声明只有ODE谓词；context\_notation提到的scalarPotentialEnergy并未给出定义或能量识别，不能把一个名字当成已经形式化。未要求本条之外的局部积分论证或能量守恒定理。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:689；MD.Ch01.scalarMechanicalModel。

## 1. MD-1.2-ScalarQuadrature · unnumbered_claim · 印刷p.20 / PDFp.43

### 2. 原文陈述

> Near this point, provided $`\eta\ne0`$, let us solve the equation $`E(x,v)=E(\xi,\eta)`$ for $`v`$ as a unique smooth function of $`x,\xi,\eta`$ using the implicit function theorem: $`v=V(x,\xi,\eta)`$. Inserting this into the differential equations we then find

$$
\frac{\mathrm dx}{\mathrm dt}=v=V(x,\xi,\eta).
$$


> This is a separable differential equation; it is therefore easily integrated from any provided initial value, $`x(0)=\xi`$, as a function of $`t`$, resulting in a relation $`x=X(t,\xi,\eta)`$. Then $`v=V(X(t,\xi,\eta),\xi,\eta)`$ and we see that it is possible to derive the formula for the solution $`(x,v)`$ as a function of $`t`$ and the initial conditions.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem scalar_quadrature (U : ℝ → ℝ) (hU : ContDiff ℝ ∞ U)
    (ξ η : ℝ) (hη : η ≠ 0) :
    ∃ δ > 0, ∃ ε > 0, ∃ V X : ℝ → ℝ → ℝ → ℝ,
      ContDiffOn ℝ ∞ (fun z : ℝ × ℝ × ℝ => V z.1 z.2.1 z.2.2)
        {z | |z.1-ξ| < δ ∧ |z.2.1-ξ| < δ ∧ |z.2.2-η| < δ} ∧
      ContDiffOn ℝ ∞ (fun z : ℝ × ℝ × ℝ => X z.1 z.2.1 z.2.2)
        {z | |z.1| < ε ∧ |z.2.1-ξ| < δ ∧ |z.2.2-η| < δ} ∧
      (∀ ζ κ, |ζ-ξ| < δ → |κ-η| < δ → V ζ ζ κ = κ ∧ X 0 ζ κ = ζ) ∧
      (∀ x ζ κ, |x-ξ| < δ → |ζ-ξ| < δ → |κ-η| < δ →
        scalarPotentialEnergy U (x,V x ζ κ) = scalarPotentialEnergy U (ζ,κ)) ∧
      (∀ x ζ κ v, |x-ξ| < δ → |ζ-ξ| < δ → |κ-η| < δ → |v-η| < δ →
        scalarPotentialEnergy U (x,v) = scalarPotentialEnergy U (ζ,κ) → v = V x ζ κ) ∧
      ∀ t ζ κ, |t| < ε → |ζ-ξ| < δ → |κ-η| < δ →
        HasDerivAt (fun s => X s ζ κ) (V (X t ζ κ) ζ κ) t ∧
        HasDerivAt (fun s => V (X s ζ κ) ζ κ) (-deriv U (X t ζ κ)) t ∧
        separableTimePrimitive (fun x => V x ζ κ) ζ (X t ζ κ) = t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.scalar\_quadrature；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\frac{\mathrm dx}{\mathrm dt}=v=V(x,\xi,\eta).`$ | MD.Ch01.scalar\_quadrature，完整展开陈述见上一行及第4段 | 一致 |
| V(x,ξ,η)光滑且能量式局部唯一确定速度 | 联合ContDiffOn ℝ ∞ V及隐式能量唯一性 | 一致 |
| 积分逆重建及初值参数光滑依赖 | 联合ContDiffOn ℝ ∞ X、实际ODE、X 0=ξ、积分=时间 | 一致；现有固定初值桥接不足 |
| 原文未显式量化的技术资格 | U光滑使原文smooth solutions和联合隐函数成立；η≠0保留原文非转向前提。 | [EXTRA] |

[EXTRA] U光滑使原文smooth solutions和联合隐函数成立；η≠0保留原文非转向前提。

### 6. 审计结论

已补完整x,ξ,η联合光滑参数化、局部唯一根、真实解与积分逆等式，未把固定初值局部定理当全条证明。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:697；MD.Ch01.scalar\_quadrature。

## 1. MD-1.2-UniformLJSystem · Example 1.5 · 印刷p.21 / PDFp.44

### 2. 原文陈述

> The energy of the system is

$$
E=\frac12\sum_{i=1}^{N}m\dot{\boldsymbol q}_i^2+\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{\mathrm{LJ}}(r_{ij}),
$$


> where $`r_{ij}=\|\boldsymbol q_i-\boldsymbol q_j\|`$ and the mass $`m`$ of an argon atom is $`6.69\times10^{-26}`$ kg.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def uniformLJSystem {N : ℕ} (m ε σ : ℝ) (q v : Fin N → V3) : ℝ :=
  (∑ i, m * ‖v i‖^2 / 2) + uniformLJEnergy ε σ q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.uniformLJSystem；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`E=\frac12\sum_{i=1}^{N}m\dot{\boldsymbol q}_i^2+\sum_{i=1}^{N-1}\sum_{j=i+1}^{N}\varphi_{\mathrm{LJ}}(r_{ij}),`$ | MD.Ch01.uniformLJSystem，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:719；MD.Ch01.uniformLJSystem。

## 1. MD-1.2-RadialLJForceLiteral · unnumbered_claim · 印刷p.21 / PDFp.44

### 2. 原文陈述

> The equations of motion are, for $`i=1,2,\ldots,N`$, using the chain rule,

$$
m\ddot{\boldsymbol q}_i=\sum_{j=1,\ j\ne i}^{N}\frac{\varphi'_{\mathrm{LJ}}(r_{ij})}{r_{ij}}(\boldsymbol q_i-\boldsymbol q_j) =-24\frac\epsilon\sigma\sum_{j=1,\ j\ne i}^{N}r_{ij}^{-1}\left[2\left(\frac\sigma{r_{ij}}\right)^{13}-\left(\frac\sigma{r_{ij}}\right)^7\right](../../\boldsymbol q_i-\boldsymbol q_j).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem radial_lj_force_literal {N : ℕ} (m ε σ : ℝ)
    (q : Fin N → V3) (a : Fin N → V3) (i : Fin N)
    (hε : 0 < ε) (hσ : 0 < σ)
    (hnc : ∀ j, i ≠ j → q i ≠ q j)
    (hnewton : m • a i = ljForce ε σ q i) :
    m • a i = ∑ j ∈ Finset.univ.erase i,
      (deriv (lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) ∧
    m • a i = (-24 * ε / σ) • (∑ j ∈ Finset.univ.erase i,
      (‖q i-q j‖⁻¹ * (2 * (σ / ‖q i-q j‖)^13 - (σ / ‖q i-q j‖)^7)) • (q i-q j)) := by
  sorry

/-- 修正版，对应原文 MD-1.2-RadialLJForceLiteral，改动：第一式补负梯度负号，第二式外系数由−24ε/σ改为+24ε/σ；其余对象和量词不变。 -/
theorem radial_lj_force_literal_corrected {N : ℕ} (m ε σ : ℝ)
    (q : Fin N → V3) (a : Fin N → V3) (i : Fin N)
    (hε : 0 < ε) (hσ : 0 < σ)
    (hnc : ∀ j, i ≠ j → q i ≠ q j)
    (hnewton : m • a i = ljForce ε σ q i) :
    m • a i = ∑ j ∈ Finset.univ.erase i,
      (-deriv (lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) ∧
    m • a i = (24 * ε / σ) • (∑ j ∈ Finset.univ.erase i,
      (‖q i-q j‖⁻¹ * (2 * (σ / ‖q i-q j‖)^13 - (σ / ‖q i-q j‖)^7)) • (q i-q j)) := by
  have hphi (r : ℝ) (hr : r ≠ 0) :
      deriv (Chapter01Review.lennardJonesPotential ε σ) r =
        (24*ε/r)*((σ/r)^6-2*(σ/r)^12) := by
    have hx := (hasDerivAt_const r σ).div (hasDerivAt_id r) hr
    have hd := ((hx.pow 12).sub (hx.pow 6)).const_mul (4*ε)
    convert hd.deriv using 1
    · rfl
    · simp only [Pi.div_apply, Pi.pow_apply, id_eq, Nat.cast_ofNat]
      norm_num only [Nat.reduceSub]
      field_simp [hr] <;> ring
  constructor
  · exact hnewton
  · rw [hnewton]
    unfold ljForce
    rw [Finset.smul_sum]
    apply Finset.sum_congr rfl
    intro j hj
    have hij : i ≠ j := (Finset.mem_erase.mp hj).1.symm
    have hr : ‖q i-q j‖ ≠ 0 := norm_ne_zero_iff.mpr (sub_ne_zero.mpr (hnc j hij))
    change (-deriv (Chapter01Review.lennardJonesPotential ε σ) ‖q i-q j‖ / ‖q i-q j‖) • (q i-q j) = _
    rw [hphi _ hr,smul_smul]
    congr 1
    field_simp [hr,hσ.ne'] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.radial\_lj\_force\_literal；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| $`m\ddot{\boldsymbol q}_i=\sum_{j=1,\ j\ne i}^{N}\frac{\varphi'_{\mathrm{LJ}}(r_{ij})}{r_{ij}}(\boldsymbol q_i-\boldsymbol q_j)\lt br\gt =-24\frac\epsilon\sigma\sum_{j=1,\ j\ne i}^{N}r_{ij}^{-1}\left[2\left(\frac\sigma{r_{ij}}\right)^{13}-\left(\frac\sigma{r_{ij}}\right)^7\right](../../\boldsymbol q_i-\boldsymbol q_j).`$ | MD.Ch01.radial\_lj\_force\_literal，完整展开陈述见上一行及第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 正ε,σ及非碰撞；hnewton采用式(1.3)负梯度定义，未把字面错误结果放入假设。 | [EXTRA] |

[EXTRA] 正ε,σ及非碰撞；hnewton采用式(1.3)负梯度定义，未把字面错误结果放入假设。

### 6. 审计结论

Newton力为−∇U；印刷式把径向势梯度当成力，两个等号均反号。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
radial\_lj\_force\_literal：字面忠实性PASS；对象、有限和排除自粒子、正ε/σ、固定i的非碰撞和负梯度Newton前提都相符，但原书力符号与式1.3冲突，故数学陈述需NEEDS\_HUMAN，不能仅因其为假而把字面版判转录FAIL。radial\_lj\_force\_literal\_corrected：PASS；在相同全部对象、量词与前提下，第一式改为−φ′/r，第二式系数+24ε/σ，符合ljForce实际定义。对r≠0有φ′=24ε/r[(σ/r)^6−2(σ/r)^12]，两修正分句均正确；不需要额外假设a来自某条已存在轨迹。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:726；MD.Ch01.radial\_lj\_force\_literal。

## 1. MD-1.2-LJCoordinateScaling · unnumbered_claim · 印刷p.21 / PDFp.44

### 2. 原文陈述

> Now introduce the change of variables

$$
\boldsymbol Q_i=\sigma^{-1}\boldsymbol q_i,\qquad i=1,2,\ldots,N,
$$


> then $`\dot{\boldsymbol q}_i=\sigma\dot{\boldsymbol Q}_i`$, $`\ddot{\boldsymbol q}_i=\sigma\ddot{\boldsymbol Q}_i`$, and $`\|\boldsymbol q_i-\boldsymbol q_j\|=\sigma\|\boldsymbol Q_i-\boldsymbol Q_j\|`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem lj_coordinate_scaling (Q : ℝ → V3) (σ t : ℝ) (v a : V3)
    (hσ : 0 < σ) (hv : HasDerivAt Q v t) (ha : HasDerivAt (deriv Q) a t) :
    HasDerivAt (fun s => σ • Q s) (σ • v) t ∧
    HasDerivAt (fun s => σ • deriv Q s) (σ • a) t ∧
    ∀ r s : V3, ‖σ • r - σ • s‖ = σ * ‖r-s‖ := by
  refine ⟨hv.const_smul σ, ha.const_smul σ, ?_⟩
  intro r s
  rw [← smul_sub, norm_smul, Real.norm_eq_abs, abs_of_pos hσ]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.lj\_coordinate\_scaling；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol Q_i=\sigma^{-1}\boldsymbol q_i,\qquad i=1,2,\ldots,N,`$ | MD.Ch01.lj\_coordinate\_scaling，完整展开陈述见上一行及第4段 | 一致 |
| 一阶、二阶及所有距离缩放 | 两个HasDerivAt结论及∀r s, ‖σ•r-σ•s‖=σ*‖r-s‖ | 一致 |
| 原文未显式量化的技术资格 | σ>0使范数缩放无绝对值；实际一阶/二阶导数资格。 | [EXTRA] |

[EXTRA] σ>0使范数缩放无绝对值；实际一阶/二阶导数资格。

### 6. 审计结论

实际导数缩放与全部距离缩放结论均已保留；σ正保证原文范数缩放不缺绝对值。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:775；MD.Ch01.lj\_coordinate\_scaling。

## 1. MD-1.2-LJTimeScaling · unnumbered_claim · 印刷p.21–22 / PDFp.44–45

### 2. 原文陈述

> Thus we see that if we make the additional time transformation

$$
\tau=\alpha t,\qquad\alpha^2=\frac\epsilon{m\sigma^2},
$$


> then the equations become

$$
\frac{\mathrm d^2\boldsymbol Q_i}{\mathrm d\tau^2}=-\sum_{j=1,\ j\ne i}^{N}\frac{\hat\varphi'_{\mathrm{LJ}}(R_{ij})}{R_{ij}}(\boldsymbol Q_i-\boldsymbol Q_j).
$$


> This means that a natural choice for the unit of time is

$$
\alpha^{-1}=\sigma\sqrt{\frac m\epsilon}\approx2.17\times10^{-12}\mathrm s.
$$


> By using the units given here, we may work with a simplified form of the Lennard-Jones system involving unit masses and a parameter-independent potential energy function.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem ljtimescaling :
  ∀ (N : ℕ) (m ε σ α : ℝ) (Q : ℝ → Fin N → V3),
    0 < m → 0 < ε → 0 < σ → 0 < α → α^2=ε/(m*σ^2) →
    (∀ i, ContDiff ℝ 2 (fun t => Q t i)) →
    (∀ t i j, i ≠ j → Q t i ≠ Q t j) →
    (((∀ t i, m • deriv (deriv (fun s => σ • Q (α*s) i)) t =
      ljForce ε σ (fun j => σ • Q (α*t) j) i) ↔
    ∀ τ i, deriv (deriv (fun s => Q s i)) τ = ljForce 1 1 (Q τ) i)) ∧
    α⁻¹ = σ * Real.sqrt (m / ε) := by
  intro N m ε σ α Q hm he hs ha hscale hQ hnc
  have hfirst (i : Fin N) (t : ℝ) :
      deriv (fun s => σ • Q (α*s) i) t = (σ*α) • deriv (fun s => Q s i) (α*t) := by
    have hd := ((hQ i).differentiable (by norm_num) (α*t)).hasDerivAt.scomp t
      ((hasDerivAt_id t).const_mul α)
    simpa [Function.comp_def, Pi.smul_def, smul_smul] using (hd.const_smul σ).deriv
  have hsecond (i : Fin N) (t : ℝ) :
      deriv (deriv (fun s => σ • Q (α*s) i)) t =
        (σ*α^2) • deriv (deriv (fun s => Q s i)) (α*t) := by
    have hf : deriv (fun s => σ • Q (α*s) i) = fun s => (σ*α) • deriv (fun s => Q s i) (α*s) :=
      funext (hfirst i)
    rw [hf]
    have hQi : ContDiff ℝ (1+1) (fun s => Q s i) := hQ i
    have hd := (hQi.deriv'.differentiable (by norm_num) (α*t)).hasDerivAt.scomp t
      ((hasDerivAt_id t).const_mul α)
    simpa [Function.comp_def, Pi.smul_def, smul_smul,pow_two,mul_assoc] using (hd.const_smul (σ*α)).deriv
  have hphi (e s r : ℝ) (hr : r ≠ 0) :
      deriv (Chapter01Review.lennardJonesPotential e s) r =
        (24*e/r)*((s/r)^6-2*(s/r)^12) := by
    have hx := (hasDerivAt_const r s).div (hasDerivAt_id r) hr
    have hd := ((hx.pow 12).sub (hx.pow 6)).const_mul (4*e)
    convert hd.deriv using 1
    · rfl
    · simp only [Pi.div_apply, Pi.pow_apply, id_eq, Nat.cast_ofNat]
      norm_num only [Nat.reduceSub]
      field_simp [hr] <;> ring
  have hforce (t : ℝ) (i : Fin N) :
      ljForce ε σ (fun j => σ • Q t j) i = (ε/σ) • ljForce 1 1 (Q t) i := by
    unfold ljForce
    rw [Finset.smul_sum]
    apply Finset.sum_congr rfl
    intro j hj
    have hij : i ≠ j := (Finset.mem_erase.mp hj).1.symm
    have hr : 0 < ‖Q t i-Q t j‖ := norm_pos_iff.mpr (sub_ne_zero.mpr (hnc t i j hij))
    have hd : pairDistance (σ • Q t i) (σ • Q t j) = σ * pairDistance (Q t i) (Q t j) := by
      simp [pairDistance,← smul_sub,norm_smul,Real.norm_eq_abs,abs_of_pos hs]
    change (-deriv (Chapter01Review.lennardJonesPotential ε σ) (pairDistance (σ • Q t i) (σ • Q t j)) / pairDistance (σ • Q t i) (σ • Q t j)) • (σ • Q t i - σ • Q t j) = _
    rw [hphi _ _ _ (by rw [hd]; exact ne_of_gt (mul_pos hs hr)),hphi 1 1 (pairDistance (Q t i) (Q t j)) (ne_of_gt hr),hd]
    rw [← smul_sub,smul_smul,smul_smul]
    congr 1
    dsimp [pairDistance]
    field_simp [hs.ne',hr.ne'] <;> ring
  have hcoeff : m*(σ*α^2) = ε/σ := by
    rw [hscale]
    field_simp [hs.ne',hm.ne'] <;> ring
  have hunit : α⁻¹ = σ*Real.sqrt (m/ε) := by
    apply (sq_eq_sq₀ (inv_nonneg.mpr ha.le) (mul_nonneg hs.le (Real.sqrt_nonneg _))).mp
    rw [mul_pow,Real.sq_sqrt (div_nonneg hm.le he.le),inv_pow,hscale]
    field_simp [hm.ne',hs.ne',he.ne'] <;> ring
  refine ⟨?_,hunit⟩
  constructor
  · intro h τ i
    have hh := h (τ/α) i
    rw [hsecond,hforce,smul_smul,hcoeff] at hh
    have ht : α*(τ/α) = τ := by field_simp [ha.ne']
    rw [ht] at hh
    have hc := congrArg (fun v : V3 => (σ/ε) • v) hh
    simpa [smul_smul,div_eq_mul_inv,hs.ne',he.ne',mul_assoc,mul_comm,mul_left_comm] using hc
  · intro h t i
    rw [hsecond,hforce,smul_smul,hcoeff,h (α*t) i]

/- Argon SI specialization: the printed approximation uses an explicit 0.01 ps tolerance. -/
theorem ljtimescaling_argon :
    |(3.4 / 10^10 : ℝ) * Real.sqrt ((6.69 / 10^26) / (1.65 / 10^21)) -
      2.17 / 10^12| < 0.01 / 10^12 := by
  have hs := Real.sq_sqrt (show (0 : ℝ) ≤ (6.69 / 10^26) / (1.65 / 10^21) by norm_num)
  have hp := Real.sqrt_nonneg ((6.69 / 10^26 : ℝ) / (1.65 / 10^21))
  rw [abs_lt]
  constructor <;> nlinarith
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.ljtimescaling；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\tau=\alpha t,\qquad\alpha^2=\frac\epsilon{m\sigma^2},`$；$`\frac{\mathrm d^2\boldsymbol Q_i}{\mathrm d\tau^2}=-\sum_{j=1,\ j\ne i}^{N}\frac{\hat\varphi'_{\mathrm{LJ}}(R_{ij})}{R_{ij}}(\boldsymbol Q_i-\boldsymbol Q_j).`$；$`\alpha^{-1}=\sigma\sqrt{\frac m\epsilon}\approx2.17\times10^{-12}\mathrm s.`$ | MD.Ch01.ljtimescaling，完整展开陈述见上一行及第4段 | 一致 |
| 时间缩放得到无参数单位质量系统 | 真实C2非碰撞Q的原Newton系统 ↔ ∀τ i,Q″=ljForce 1 1 | 一致 |
| 单位时间 | α⁻¹=σ*Real.sqrt (m/ε) | 一致 |
| 原文未显式量化的技术资格 | m,ε,σ,α正；真实C2非碰撞轨迹。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.ljtimescaling; MD.Ch01.ljtimescaling\_argon | 补原书氩m=6.69×10⁻²⁶kg、ε=1.65×10⁻²¹J、σ=3.4×10⁻¹⁰m的2.17ps近似，显式容差0.005ps；保留原双向缩放和时间单位证明。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.ljtimescaling; MD.Ch01.ljtimescaling\_argon | 补原书氩m=6.69×10⁻²⁶kg、ε=1.65×10⁻²¹J、σ=3.4×10⁻¹⁰m的2.17ps近似，显式容差0.005ps；保留原双向缩放和时间单位证明。 |
| 21号网站建议修复 | MD.Ch01.ljtimescaling | 仅[EXTRA]容差0.005ps改为0.01ps；两个定理逐字未改。 |

[EXTRA] m,ε,σ,α正；真实C²非碰撞轨迹。；[EXTRA] 氩参数m=6.69×10⁻²⁶kg、ε=1.65×10⁻²¹J、σ=3.4×10⁻¹⁰m；实际ljtimescaling\_argon结论采用显式容差0.01ps，非旧说明的0.005ps。给定参数下0.005ps界不成立；原书只写约2.17ps。保留双向缩放和时间单位结论。；[EXTRA] 本条采用显式容差0.01ps；两个定理保持不变。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：仅[EXTRA]容差0.005ps改为0.01ps；两个定理逐字未改。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
ljtimescaling：PASS。全部正参数、C²非碰撞Q、q(t)=σQ(αt)及α²关系明确；结论是有量纲Newton方程与全τ的单位参数方程双向等价，并给正确时间单位，反向时间覆盖由α>0保证。ljtimescaling\_argon：按其实际签名PASS，给|τ−2.17ps|<0.01ps，常数和单位换算正确。但本条最新[EXTRA]明说显式容差0.005ps，实际结论却为0.01ps；且给定精确十进制参数下0.005ps界是假的。故接收材料的[EXTRA]一致性FAIL，不能把0.01当已证明0.005。corrected\_json只将说明改成实际成立的0.01ps，不改原书近似或工程。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:789；MD.Ch01.ljtimescaling。

## 1. MD-1.3-Lagrangian · definition · 印刷p.22 / PDFp.45

### 2. 原文陈述

> For the system (1.3) with N atoms and $`N_c=3N`$ configuration coordinates, the Lagrangian is

$$
L\stackrel{\mathrm{def}}=\frac{\dot{\boldsymbol q}^{T}\boldsymbol M\dot{\boldsymbol q}}2-U(\boldsymbol q).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def fixedMassLagrangian {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (q : Position n) (v : Velocity n) : ℝ := nBodyKineticEnergy m v - U q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.fixedMassLagrangian；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`L\stackrel{\mathrm{def}}=\frac{\dot{\boldsymbol q}^{T}\boldsymbol M\dot{\boldsymbol q}}2-U(\boldsymbol q).`$ | MD.Ch01.fixedMassLagrangian，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:876；MD.Ch01.fixedMassLagrangian。

