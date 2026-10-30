[上一部分](part02.zh-CN.md) / [目录](../../CH01_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

## 1. MD-1.3-GeneralizedCoordinates · unnumbered_claim · 印刷p.23 / PDFp.46

### 2. 原文陈述

> When we introduce a smooth change of variables $`\boldsymbol q=\boldsymbol\Phi(\boldsymbol Q)`$, where $`\boldsymbol\Phi:\mathbb R^{N_c}\to\mathbb R^{N_c}`$, this induces a corresponding transformation of the velocity vector by

$$
\dot{\boldsymbol q}=\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q},
$$


> where $`\boldsymbol\Phi'`$ is the $`N_c\times N_c`$ Jacobian matrix of $`\boldsymbol\Phi`$. Then the Lagrangian of the system is transformed to

$$
\widetilde L=\frac{\dot{\boldsymbol Q}^{T}\boldsymbol\Phi'(\boldsymbol Q)^{T}\boldsymbol M\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q}}2-U(\boldsymbol\Phi(\boldsymbol Q)),
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem generalized_coordinates {n k : ℕ} (m : CoordinateMasses n)
    (U : PotentialEnergy n) (Φ : Position k → Position n)
    (J : Matrix (Fin n) (Fin k) ℝ) (q : ℝ → Position k) (V : Velocity k) (t : ℝ)
    (hΦ : HasFDerivAt Φ J.toEuclideanLin.toContinuousLinearMap (q t))
    (hq : HasDerivAt q V t) :
    HasDerivAt (fun s => Φ (q s)) (J.toEuclideanLin V) t ∧
    massLagrangian m U (Φ (q t)) (J.toEuclideanLin V) =
      inner ℝ V ((generalizedMassMatrix m J).toEuclideanLin V) / 2 - U (Φ (q t)) := by
  exact ⟨hasDerivAt_coordinateChange Φ J q V t hΦ hq,
    massLagrangian_coordinateChange m U Φ J (q t) V⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.generalized\_coordinates；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\dot{\boldsymbol q}=\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q},`$；$`\widetilde L=\frac{\dot{\boldsymbol Q}^{T}\boldsymbol\Phi'(\boldsymbol Q)^{T}\boldsymbol M\boldsymbol\Phi'(\boldsymbol Q)\dot{\boldsymbol Q}}2-U(\boldsymbol\Phi(\boldsymbol Q)),`$ | MD.Ch01.generalized\_coordinates，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 原文smooth可在本结论弱化至点态真实可微；k可小于n，含原文约束推广。 | [EXTRA] |

[EXTRA] 原文smooth可在本结论弱化至点态真实可微；k可小于n，含原文约束推广。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
PASS。Φ:Position k→Position n，J为n×k矩阵；hΦ明确J是q(t)处的真实Fréchet导数，hq明确q的实际速度V。第一结论通过链式法则给d(Φ∘q)/dt=JV；第二结论把massLagrangian的Σ\_i m\_i v\_i²/2−U替换成⟨V,(Jᵀdiag(m)J)V⟩/2−U(Φ(q(t)))，矩阵排列、转置及系数均无误。标准实欧氏内积即原式行列乘积。原文smooth在点态结论中弱化至真实可微、k不必等于n，都是[EXTRA]已说明且成立的推广；本条代数恒等式不需正质量或满秩，正则可逆性由下一条另行处理。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:883；MD.Ch01.generalized\_coordinates。

## 1. MD-1.3-GeneralizedMassRegular · unnumbered_claim · 印刷p.23 / PDFp.46

### 2. 原文陈述

> We will assume that any such changes of variables are regular transformations in the sense that $`\boldsymbol\Phi'`$ is of full rank and the resulting generalized mass matrix is invertible.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem generalizedmassregular :
  ∀ {n k : ℕ} (m : CoordinateMasses n)
    (J : Matrix (Fin n) (Fin k) ℝ) (hm : ∀ i, 0 < m i)
    (hJ : Function.Injective J.mulVec),
    IsUnit (generalizedMassMatrix m J) := by
  exact @MolecularDynamics.generalizedMassMatrix_isUnit
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.generalizedmassregular；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 正粒子质量；full rank为Jacobian列单射，符合n≥k。 | [EXTRA] |

[EXTRA] 正粒子质量；full rank为Jacobian列单射，符合n≥k。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
PASS。m给n个坐标质量且逐个严格正，J为n×k矩阵，Injective J.mulVec是满列秩，自动保证k≤n，符合原书约束参数化情形。generalizedMassMatrix实为Jᵀdiag(m)J；对非零v，由Jv≠0有vᵀJᵀMJv=Σ\_i m\_i(Jv)_i²>0，因此该k×k矩阵可逆。IsUnit正是矩阵环中的可逆性，未预先假设结论；k=0情形亦正常。J作为任意满足满列秩的矩阵推广覆盖真实Jacobian的情形；[EXTRA]正质量及列单射均落实。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:898；MD.Ch01.generalizedmassregular。

## 1. MD-1.4-ConvexLegendre · definition · 印刷p.24 / PDFp.47

### 2. 原文陈述

> Abstractly, a Legendre transformation of a given convex function $`g=g(\boldsymbol\xi):\mathbb R^m\to\mathbb R`$ is a new function $`\widetilde g=\widetilde g(\boldsymbol\eta):\mathbb R^m\to\mathbb R`$ defined by

$$
\widetilde g(\boldsymbol\eta)=\sup_{\boldsymbol\xi}(\boldsymbol\eta^T\boldsymbol\xi-g(\boldsymbol\xi)),
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def legendreTransform {n : ℕ} (g : Position n → ℝ) (η : Position n) : EReal :=
  ⨆ θ : Position n, ((inner ℝ η θ - g θ : ℝ) : EReal)

/-- 修正版，对应原文 MD-1.4-ConvexLegendre，改动：新增原书“任意凸函数的变换处处实值”的literal陈述；默认EReal扩展实数，并给有界时实值备选。 -/
theorem legendreTransform_literal {n : ℕ} (g : Position n → ℝ)
    (hg : ConvexOn ℝ univ g) :
    ∀ η : Position n, ∃ r : ℝ, IsLUB (Set.range (fun θ => inner ℝ η θ - g θ)) r := by
  sorry

/-- 修正版，对应原文 MD-1.4-ConvexLegendre，改动：允许上确界为+∞。 -/
def legendreTransform_corrected {n : ℕ} (g : Position n → ℝ) (η : Position n) : EReal :=
  ⨆ θ : Position n, ((inner ℝ η θ - g θ : ℝ) : EReal)

/-- 修正版，对应原文 MD-1.4-ConvexLegendre，改动：实值版显式要求有上界。 -/
theorem legendreTransform_corrected_b {n : ℕ} (g : Position n → ℝ) (η : Position n)
    (hb : BddAbove (Set.range (fun θ => inner ℝ η θ - g θ))) :
    IsLUB (Set.range (fun θ => inner ℝ η θ - g θ))
      (sSup (Set.range (fun θ => inner ℝ η θ - g θ))) := by
  exact isLUB_csSup (Set.range_nonempty _) hb
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.legendreTransform；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| $`\widetilde g(\boldsymbol\eta)=\sup_{\boldsymbol\xi}(\boldsymbol\eta^T\boldsymbol\xi-g(\boldsymbol\xi)),`$ | MD.Ch01.legendreTransform，完整展开陈述见上一行及第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 值域采用EReal，因一般凸函数的共轭可为+∞；原文写R需要额外有限性条件。 | [EXTRA] |

[EXTRA] 值域采用EReal，因一般凸函数的共轭可为+∞；原文写R需要额外有限性条件。

### 6. 审计结论

凸性不能保证共轭函数每一点有限；实数sSup在无上界时的总化值不能充当真实上确界。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
legendreTransform 及 _corrected：PASS，任意 n、g:Position n→ℝ、η，EReal 的 iSup 正确实现扩展实共轭；未要求凸性是对所有实函数定义的合理推广，并未声称其处处实值。_literal：忠实性 PASS，ConvexOn univ 的任意 g 对每个 η 有实 IsLUB，正是原书实值断言，但数学上错误。_corrected\_b：PASS，固定 η 的 BddAbove 加非空 range 足以推出实 sSup 的 IsLUB；凸性不是此上确界事实所必需。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:913；MD.Ch01.legendreTransform。

## 1. MD-1.4-HamiltonEquations · definition · 印刷p.24 / PDFp.47

### 2. 原文陈述

> The equations of motion can be written

$$
\dot{\boldsymbol q}=\frac{\partial H}{\partial\boldsymbol p},\qquad\dot{\boldsymbol p}=-\frac{\partial H}{\partial\boldsymbol q}.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def hamiltonEquationsOn {n : ℕ} (H : PhaseSpace n → ℝ)
    (I : Set ℝ) (q p : ℝ → Position n) : Prop :=
  ∀ t ∈ I, DifferentiableAt ℝ (fun v => H (q t,v)) (p t) ∧
    DifferentiableAt ℝ (fun x => H (x,p t)) (q t) ∧
    HasDerivAt q (gradient (fun v => H (q t,v)) (p t)) t ∧
    HasDerivAt p (-gradient (fun x => H (x,p t)) (q t)) t

def hamiltonEquations {n : ℕ} (H : PhaseSpace n → ℝ) (q p : ℝ → Position n) : Prop :=
  hamiltonEquationsOn H univ q p
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hamiltonEquations；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\dot{\boldsymbol q}=\frac{\partial H}{\partial\boldsymbol p},\qquad\dot{\boldsymbol p}=-\frac{\partial H}{\partial\boldsymbol q}.`$ | MD.Ch01.hamiltonEquations，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.hamiltonEquationsOn; MD.Ch01.hamiltonEquations | 沿轨迹两偏函数真实可微，补时间域版；全时间名称保留作univ特例。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.hamiltonEquationsOn; MD.Ch01.hamiltonEquations | 沿轨迹两偏函数真实可微，补时间域版；全时间名称保留作univ特例。 |

[EXTRA] [EXTRA] 19号：沿轨迹两偏函数真实可微，补时间域版；全时间名称保留作univ特例。

### 6. 审计结论

19号本地签名预审：沿轨迹两偏函数真实可微，补时间域版；全时间名称保留作univ特例。

网站：网站PASS（EAUDIT复审）。
hamiltonEquationsOn：任意 n、实值 H、任意时间集合 I 和 q/p 曲线；对每个 t∈I，要求两个冻结变量偏函数真实可微及 q′=∇pH、p′=-∇qH，符号、求值点及量词正确。时间导数用 HasDerivAt（不是总化 deriv），边界仍要求环境导数，与所披露资格一致。hamiltonEquations 恰为 I=univ。没有把偏导存在或全时间解存在当作自动结论。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:944；MD.Ch01.hamiltonEquations。

## 1. MD-1.4-HamiltonFixedMass · unnumbered_claim · 印刷p.24 / PDFp.47

### 2. 原文陈述

> For constant $`\boldsymbol M`$ we obtain the dynamical equations,

$$
\dot{\boldsymbol q}=\boldsymbol M^{-1}\boldsymbol p,\qquad\dot{\boldsymbol p}=\boldsymbol F=-\partial U/\partial\boldsymbol q.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hamilton_fixed_mass {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q p : Position n) (hM : M.PosDef)
    (hU : DifferentiableAt ℝ U q) :
    HasGradientAt (fun v => variableMassHamiltonian (fun _ => M) U q v)
      (matrixAction M⁻¹ p) p ∧
    HasGradientAt (fun x => variableMassHamiltonian (fun _ => M) U x p)
      (gradient U q) q := by
  let B := Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹
  have hsym := Matrix.isSymmetric_toEuclideanLin_iff.mpr hM.inv.isHermitian
  have hKD : HasFDerivAt (fun v : Position n => inner ℝ v (B v)/2)
      (InnerProductSpace.toDual ℝ (Position n) (B p)) p := by
    have hd := (hasFDerivAt_id (𝕜 := ℝ) p).inner ℝ B.hasFDerivAt
    convert hd.mul_const ((2:ℝ)⁻¹) using 1
    · simp only [div_eq_mul_inv, id_eq]
    · ext v
      simp [fderivInnerCLM_apply, InnerProductSpace.toDual_apply_apply]
      have hs : inner ℝ p (B v) = inner ℝ (B p) v := (hsym p v).symm
      rw [hs, real_inner_comm v (B p)]
      ring
  constructor
  · rw [hasGradientAt_iff_hasFDerivAt]
    exact hKD.add_const (U q)
  · rw [hasGradientAt_iff_hasFDerivAt]
    exact hU.hasGradientAt.hasFDerivAt.const_add (inner ℝ p (B p)/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hamilton\_fixed\_mass；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\dot{\boldsymbol q}=\boldsymbol M^{-1}\boldsymbol p,\qquad\dot{\boldsymbol p}=\boldsymbol F=-\partial U/\partial\boldsymbol q.`$ | MD.Ch01.hamilton\_fixed\_mass，完整展开陈述见上一行及第4段 | 一致 |
| 一般固定矩阵M的两Hamilton偏梯度 | M.PosDef；动量梯度matrixAction M⁻¹ p，位置梯度gradient U q | 一致；保留一般SPD矩阵 |
| 原文未显式量化的技术资格 | 常质量矩阵M对称正定，来自机械模型满秩坐标变换；U真实可微。 | [EXTRA] |

[EXTRA] 常质量矩阵M对称正定，来自机械模型满秩坐标变换；U真实可微。

### 6. 审计结论

保留一般常质量矩阵，两个实际梯度给出全部Hamilton方程分量；旧库对角特例不匹配此忠实签名。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:951；MD.Ch01.hamilton\_fixed\_mass。

## 1. MD-1.4-HamiltonLagrangeEquivalence · unnumbered_claim · 印刷p.25 / PDFp.48

### 2. 原文陈述

> More generally, for molecular models, the Hamiltonian and Lagrangian formulations are interchangeable, but the use of the Hamiltonian form is preferred for allowing simplified description of the geometric character of the solutions of the system as we discuss in Chaps. 2–4.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hamiltonlagrangeequivalence :
  ∀ (n : ℕ) (M : Position n → Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (q v : ℝ → Position n) (I : Set ℝ),
    IsOpen I → ContDiff ℝ 2 M → ContDiff ℝ 2 U →
    (∀ x, (M x).PosDef) → (∀ t ∈ I, HasDerivAt q (v t) t) →
    ((∀ t ∈ I, HasDerivAt (fun s => gradient (quadraticL M U (q s)) (v s))
      (gradient (fun x => quadraticL M U x (v t)) (q t)) t) ↔
    ∀ t ∈ I, let p := fun s => (M (q s)).toEuclideanLin (v s)
      HasDerivAt q (gradient (quadraticH M U (q t)) (p t)) t ∧
      HasDerivAt p (-gradient (fun x => quadraticH M U x (p t)) (q t)) t) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hamiltonlagrangeequivalence；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 一般配置相关M C2、U C2、M逐点正定；轨迹q′=v真实且时间域开放。 | [EXTRA] |

[EXTRA] 一般配置相关M C2、U C2、M逐点正定；轨迹q′=v真实且时间域开放。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，证明尚未完成。

网站：网站PASS（EAUDIT复审）。
任意 n、配置相关 M/U、q/v 及开放 I；C² 和逐点对称正定 M 保证 Legendre 可逆及所用偏梯度真实。q′=v 单独为前提；左侧是 d/dt ∇vL=∇qL，右侧以 p(s)=M(q(s))v(s) 同时要求两条 Hamilton 方程，符号和冻结速度/动量位置正确。不是仅常质量特例，未假设待证等价。C²为充分的偏强资格，已披露；关于几何描述偏好的文字是说明而非额外可形式化定理。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:980；MD.Ch01.hamiltonlagrangeequivalence。

## 1. MD-1.4-PhaseSpace · definition · 印刷p.25 / PDFp.48

### 2. 原文陈述

> The set of all positions and momenta for which the energy is finite is termed the phase space. The instantaneous state of a molecular system involving many, say N, particles moving in $`\mathbb R^3`$ is described by coordinates and positions, i.e., by a point in $`\mathbb R^{6N}`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def finiteEnergyPhaseDomain {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}





/-- 修正版，对应原文 MD-1.4-PhaseSpace，改动：有限能量位置×动量定义保留；把后句coordinates and positions按前句解释为位置与动量，并显式核验6N维。 -/
def finiteEnergyPhaseDomain_corrected {n : ℕ} (H : PhaseSpace n → EReal) : Set (PhaseSpace n) :=
  {z | H z ≠ ⊤ ∧ H z ≠ ⊥}

theorem finiteEnergyPhaseDomain_corrected_dimension (N : ℕ) :
    Module.finrank ℝ (PhaseSpace (3*N)) = 6*N := by
  simp [PhaseSpace,Position,Momentum]
  omega
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.finiteEnergyPhaseDomain；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 采用扩展实值H以明确排除奇异无穷能量；PhaseSpace n底层是位置×动量，n=3N。 | [EXTRA] |

[EXTRA] 采用扩展实值H以明确排除奇异无穷能量；PhaseSpace n底层是位置×动量，n=3N。

### 6. 审计结论

后句重复位置，疑为positions/momenta文字笔误；前句定义及R^{6N}支持位置×动量解释。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；限定解释=网站PASS。
finiteEnergyPhaseDomain 与 _corrected：PASS，PhaseSpace n=Position n×Momentum n，H:EReal，排除顶和底恰表示有限实能量。_corrected\_dimension：PASS，任意 N，包括0，证明的是环境向量空间 PhaseSpace(3*N) 的实维数 6*N，不是断言任意有限能量子集自身为6N维流形。修正版按前句把笔误理解成位置与动量合理；原文笔误仍需人工确认。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:996；MD.Ch01.finiteEnergyPhaseDomain。

## 1. MD-1.5-LocalExistUnique · unnumbered_claim · 印刷p.25 / PDFp.48

### 2. 原文陈述

> One of the most important properties of a typical classical molecular Hamiltonian system is the existence and uniqueness of solutions started from a generic initial condition.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem local_exist_unique {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (Q : Set (Position n)) (hQ : IsOpen Q) (t₀ : ℝ) (z₀ : PhaseSpace n) (hz : z₀.1 ∈ Q)
    (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 (fun x => -gradient U x) q) :
    (∃ ε γ, IsLocalMechanicalIVP m (fun q => -gradient U q) Q t₀ z₀ ε γ) ∧
    ∀ I γ η, IsOpen I → t₀ ∈ I →
      IsMechanicalSolutionOn m (fun q => -gradient U q) Q I γ →
      IsMechanicalSolutionOn m (fun q => -gradient U q) Q I η →
      γ t₀ = z₀ → η t₀ = z₀ → γ =ᶠ[𝓝 t₀] η := by
  constructor
  · exact exists_localMechanicalIVP_open_of_force_contDiffAt m _ Q hQ t₀ z₀ hz (hreg _ hz)
  · intro I γ η hI ht hγ hη hi hj
    exact mechanicalSolution_eventually_unique_of_contDiffAt m _ Q I t₀ γ η z₀ hI ht hγ hη hi hj
      (mechanicalVectorField_contDiffAt m _ z₀ (hreg _ hz))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.local\_exist\_unique；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | generic初值解释为开放非奇异域中的合法初值；力C1是原文存在唯一性背景。固定对角质量模型。 | [EXTRA] |

[EXTRA] generic初值解释为开放非奇异域中的合法初值；力C1是原文存在唯一性背景。固定对角质量模型。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
固定对角质量、开放非奇异配置域 Q，z₀.1∈Q，任意 t₀；力 -∇U 在Q各点 C¹。存在 ε>0、γ(t₀)=z₀、两侧开时间区间上的真实机械积分曲线并留Q；任意共同开放时间域上的同初值解在 t₀ 邻域最终相等，正确表达局部唯一而非全函数相等。CoordinateMasses 只是实函数，未要求正/非零，故这是总化矩阵逆向量场的较广ODE定理；用于物理 Hamilton 模型须另有正质量背景，不能由本条推出零质量物理模型。数学上的局部存在唯一结论仍对该较广定义正确，未增加隐蔽结论。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1016；MD.Ch01.local\_exist\_unique。

## 1. MD-1.5-EnergySurface · definition · 印刷p.25 / PDFp.48

### 2. 原文陈述

> For given $`E_0\geq U_{\min}`$ define $`\Sigma_{E_0}=\{(\boldsymbol q,\boldsymbol p)\mid H(\boldsymbol q,\boldsymbol p)=E_0\}`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def energySurface {n : ℕ} (H : PhaseSpace n → ℝ) (E : ℝ) := {z | H z = E}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.energySurface；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1034；MD.Ch01.energySurface。

## 1. MD-1.5-EnergyBounds · unnumbered_claim · 印刷p.25 / PDFp.48

### 2. 原文陈述

> Assume that $`U`$ is a potential energy function which is bounded below, $`U\geq U_{\min}`$. For given $`E_0\geq U_{\min}`$ define $`\Sigma_{E_0}=\{(\boldsymbol q,\boldsymbol p)\mid H(\boldsymbol q,\boldsymbol p)=E_0\}`$. Then, for $`(\boldsymbol q,\boldsymbol p)\in\Sigma_{E_0}`$ we have

$$
\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2+U(\boldsymbol q)=E_0\Rightarrow\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2=E_0-U(\boldsymbol q)\leq E_0-U_{\min}.
$$


> $`\boldsymbol M^{-1}`$ is a positive definite matrix (assumed here to be constant), so we can infer that the momenta are bounded at fixed total energy. We would like to say something similar for positions. We have, at energy $`E_0`$,

$$
U_{\min}\leq U(\boldsymbol q)\leq E_0.
$$



### 3. 原文证明

> Then, for $`(\boldsymbol q,\boldsymbol p)\in\Sigma_{E_0}`$ we have

$$
\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2+U(\boldsymbol q)=E_0\Rightarrow\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2=E_0-U(\boldsymbol q)\leq E_0-U_{\min}.
$$


> $`\boldsymbol M^{-1}`$ is a positive definite matrix (assumed here to be constant), so we can infer that the momenta are bounded at fixed total energy. We would like to say something similar for positions. We have, at energy $`E_0`$,

$$
U_{\min}\leq U(\boldsymbol q)\leq E_0.
$$


原页能量不等式及正定推界论证逐字引用；与陈述合引部分保留，未添加原书没有的证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem energy_bounds {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (E₀ Umin : ℝ) (hM : (M⁻¹).PosDef)
    (hU : ∀ q, Umin ≤ U q) :
    (∀ q p, variableMassHamiltonian (fun _ => M) U q p = E₀ →
      inner ℝ p (matrixAction M⁻¹ p) / 2 = E₀ - U q ∧
      inner ℝ p (matrixAction M⁻¹ p) / 2 ≤ E₀ - Umin ∧ Umin ≤ U q ∧ U q ≤ E₀) ∧
    ∃ R : ℝ, ∀ q p, variableMassHamiltonian (fun _ => M) U q p = E₀ → ‖p‖ ≤ R := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.energy\_bounds；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2+U(\boldsymbol q)=E_0\Rightarrow\frac{\boldsymbol p^T\boldsymbol M^{-1}\boldsymbol p}2=E_0-U(\boldsymbol q)\leq E_0-U_{\min}.`$；$`U_{\min}\leq U(\boldsymbol q)\leq E_0.`$ | MD.Ch01.energy\_bounds，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | U定义在整个欧氏位置域；保持一般常M⁻¹正定，未换成固定对角特例。 | [EXTRA] |

[EXTRA] U定义在整个欧氏位置域；保持一般常M⁻¹正定，未换成固定对角特例。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1040；MD.Ch01.energy\_bounds。

## 1. MD-1.5-UniformLevelsCompact · unnumbered_claim · 印刷p.26 / PDFp.49

### 2. 原文陈述

> What is needed is an assumption that the level sets $`\widehat\Sigma_\alpha=\{\boldsymbol q\mid U(\boldsymbol q)=\alpha\}`$ are bounded uniformly for $`\alpha\in[U_{\min},E_0]`$. Then it follows that solutions satisfying the energy constraint remain confined to a compact (closed and bounded) set.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem uniform_levels_compact {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (E₀ Umin : ℝ) (hM : (M⁻¹).PosDef)
    (hU : Continuous U) (hlower : ∀ q, Umin ≤ U q)
    (hlevels : ∃ R : ℝ, ∀ α ∈ Icc Umin E₀, ∀ q, U q = α → ‖q‖ ≤ R) :
    IsCompact {z : PhaseSpace n | variableMassHamiltonian (fun _ => M) U z.1 z.2 = E₀} := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.uniform\_levels\_compact；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | U连续保证能量层闭；一般常逆质量正定继承p.25；无奇异域的全欧氏模型，若有奇异域需紧集留域。 | [EXTRA] |

[EXTRA] U连续保证能量层闭；一般常逆质量正定继承p.25；无奇异域的全欧氏模型，若有奇异域需紧集留域。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1053；MD.Ch01.uniform\_levels\_compact。

## 1. MD-1.5-CompactContinuation · unnumbered_claim · 印刷p.25–26 / PDFp.48–49

### 2. 原文陈述

> The uniqueness of solutions is easily verified in the usual way (as for the local result for uniqueness of solutions). The key point is that, with the energy constraint, solutions typically remain bounded for all time.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
/- General confinement helper retained separately from the Hamiltonian result. -/
theorem compact_continuation_aux {n : ℕ} (m : CoordinateMasses n) (F : Force n)
    (Q : Set (Position n)) (K : Set (PhaseSpace n)) (z₀ : PhaseSpace n)
    (hm : ∀ i, 0 < m i) (hQ : IsOpen Q) (hreg : ∀ q ∈ Q, ContDiffAt ℝ 1 F q)
    (hK : IsCompact K) (hKQ : ∀ z ∈ K, z.1 ∈ Q) (hz : z₀ ∈ K)
    (hconfine : ∀ a b γ, 0 ∈ Ioo a b → IsMechanicalSolutionOn m F Q (Ioo a b) γ →
      γ 0 = z₀ → ∀ t ∈ Ioo a b, γ t ∈ K) :
    ∃ γ, IsMechanicalSolutionOn m F Q univ γ ∧ γ 0 = z₀ ∧ ∀ t, γ t ∈ K := by
  sorry

theorem compact_continuation {n : ℕ} (m : CoordinateMasses n) (U : PotentialEnergy n)
    (z₀ : PhaseSpace n) (hm : ∀ i, 0 < m i) (hU : ContDiff ℝ 2 U)
    (hlower : ∃ b : ℝ, ∀ q, b ≤ U q)
    (hconfine : ∀ E : ℝ, Bornology.IsBounded {q : Position n | U q ≤ E}) :
    ∃ γ : ℝ → PhaseSpace n,
      IsMechanicalSolutionOn m (fun q => -gradient U q) univ univ γ ∧ γ 0 = z₀ ∧
      (∀ t, massHamiltonian m U (γ t) = massHamiltonian m U z₀) ∧
      Bornology.IsBounded (Set.range γ) ∧
      (∀ η : ℝ → PhaseSpace n,
        IsMechanicalSolutionOn m (fun q => -gradient U q) univ univ η → η 0 = z₀ → η = γ) ∧
      (∀ a b η, 0 ∈ Ioo a b →
        IsMechanicalSolutionOn m (fun q => -gradient U q) univ (Ioo a b) η → η 0 = z₀ →
        ∀ t ∈ Ioo a b, η t = γ t) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.compact\_continuation；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 共同紧集包含于开放非奇异域；hconfine仅关于既有局部解，不假设全局解；力C1和固定对角机械模型。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.compact\_continuation\_aux; MD.Ch01.compact\_continuation | 主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.compact\_continuation\_aux; MD.Ch01.compact\_continuation | 主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。 |

[EXTRA] 共同紧集包含于开放非奇异域；hconfine仅关于既有局部解，不假设全局解；力C1和固定对角机械模型。；[EXTRA] 19号：主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。

### 6. 审计结论

19号本地签名预审：主条补真实U、正质量、势能下界/有界次水平集、全时间存在、同初值局部及全局唯一、有界和能量守恒；一般紧集延拓另名辅助，不把能量限域结论当假设。

网站：网站PASS（EAUDIT复审）。
aux：正质量、开放Q、C¹力、紧K⊂Q×P、初值在K，hconfine只量化已有局部解，不循环假设全局存在；结论是全实时间解且留K。主条：任意初值、正对角质量、全域C²实势、统一下界以及每个次水平集有界；结论同时含全时间机械解、初值、能量守恒、轨道有界、全局解函数唯一以及含0开区间上的局部解逐点唯一。闭次水平集由连续性给出，有限维闭有界给紧性；动量界由能量和正质量给出。原书p26的能级集在α区间上一致有界正对应次水平集有界，已展开背景，不把仅能量守恒误作普遍位置有界。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1074；MD.Ch01.compact\_continuation。

## 1. MD-1.5-Nonconfining · unnumbered_claim · 印刷p.26 / PDFp.49

### 2. 原文陈述

> The assumption on $`U`$ is not satisfied by some simple potentials. For example consider $`U(x,y)=x^2`$ which is completely independent of $`y`$ and so places no restriction on that variable for constant energy.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem nonconfining :
  ¬ Bornology.IsBounded {q : Position 2 | (q 0)^2 = 1} := by
  intro h
  obtain ⟨R,hR⟩ := h.exists_norm_le
  let q : Position 2 := WithLp.toLp 2 ![1,|R|+1]
  have hb : ‖q‖ ≤ R := hR q (by simp [q])
  have hv : |R|+1 ≤ ‖q‖ := by
    simpa [q, abs_of_nonneg (by positivity : 0 ≤ |R|+1)] using PiLp.norm_apply_le q (1 : Fin 2)
  have := le_abs_self R
  linarith
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.nonconfining；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1093；MD.Ch01.nonconfining。

## 1. MD-1.5.1-FlowMap · definition · 印刷p.26 / PDFp.49

### 2. 原文陈述

> Consider now the initial value problem

$$
\dot{\boldsymbol z}=f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi,\tag{1.5}
$$


> in a $`m`$-dimensional space. If we assume that $`f`$ corresponds to a molecular Hamiltonian system satisfying the assumptions of the existence and uniqueness result of the previous subsection, then we may define a mapping from a point in phase space to the point $`t`$ units later along the time-evolution starting from the initial point. We refer to this map as the flow map and denote it by $`\mathcal F_t`$. $`\mathcal F_t(\boldsymbol\xi)=\boldsymbol z(t)`$ solves the initial value problem (1.5).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def flowMap {n : ℕ} (f : Position n → Position n) (F : ℝ → Position n → Position n) : Prop :=
  (∀ ξ, F 0 ξ = ξ) ∧ ∀ ξ t, HasDerivAt (fun s => F s ξ) (f (F t ξ)) t
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.flowMap；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\dot{\boldsymbol z}=f(\boldsymbol z),\qquad\boldsymbol z(0)=\boldsymbol\xi,\quad\text{(1.5)}`$ | MD.Ch01.flowMap，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1108；MD.Ch01.flowMap。

## 1. MD-1.5.1-FlowEnergy · unnumbered_claim · 印刷p.26 / PDFp.49

### 2. 原文陈述

> The flow map of a Hamiltonian system conserves its Hamiltonian, thus

$$
H(\mathcal F_t(\boldsymbol\xi))\equiv H(\boldsymbol\xi).
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem flow_energy {n : ℕ} (H : PhaseSpace n → ℝ)
    (F : ℝ → PhaseSpace n → PhaseSpace n) (hH : Differentiable ℝ H)
    (hF : ∀ ξ, F 0 ξ = ξ ∧ ∀ t, HasDerivAt (fun s => F s ξ) (symplecticGradient H (F t ξ)) t) :
    ∀ ξ t, H (F t ξ) = H ξ := by
  intro ξ t
  have hd (s : ℝ) : HasDerivAt (fun u => H (F u ξ)) 0 s := by
    let z := F s ξ
    let A := fderiv ℝ H z
    have hA : HasFDerivAt H A z := (hH z).hasFDerivAt
    have hq := hA.comp z.1 ((hasFDerivAt_id (𝕜 := ℝ) z.1).prodMk (hasFDerivAt_const (𝕜 := ℝ) z.2 z.1))
    have hp := hA.comp z.2 ((hasFDerivAt_const (𝕜 := ℝ) z.1 z.2).prodMk (hasFDerivAt_id (𝕜 := ℝ) z.2))
    simp only [Function.comp_def, id_eq] at hq hp
    let gq := gradient (fun q => H (q,z.2)) z.1
    let gp := gradient (fun p => H (z.1,p)) z.2
    have eqQ (v : Position n) : A (v,0) = inner ℝ gq v := by
      rw [inner_gradient_left, hq.fderiv]
      rfl
    have eqP (v : Position n) : A (0,v) = inner ℝ gp v := by
      rw [inner_gradient_left, hp.fderiv]
      rfl
    have hz : A (symplecticGradient H z) = 0 := by
      change A (gp,-gq) = 0
      have he : (gp,-gq) = (gp,0)+(0,-gq) := by simp
      rw [he, map_add, eqQ, eqP, inner_neg_right, real_inner_comm gq gp]
      ring
    have hh := hA.comp_hasDerivAt s ((hF ξ).2 s)
    have he : A (symplecticGradient H (F s ξ)) = 0 := hz
    rw [he] at hh
    simpa only [Function.comp_def] using hh
  have hc := is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0
  simpa [(hF ξ).1] using hc
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.flow\_energy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`H(\mathcal F_t(\boldsymbol\xi))=H(\boldsymbol\xi).`$ | MD.Ch01.flow\_energy，完整展开陈述见上一行及第4段 | 一致 |
| 一般Hamilton流保能量，所有初值与时间 | ∀ξ t,H(F t ξ)=H ξ；hF为实际symplecticGradient H的ODE | 一致；守恒未作前提 |
| 原文未显式量化的技术资格 | H可微及F为真实全局Hamilton流（初值和ODE，不含守恒结论）。 | [EXTRA] |

[EXTRA] H可微及F为真实全局Hamilton流（初值和ODE，不含守恒结论）。

### 6. 审计结论

已改一般H和一般Hamilton流，保留所有初值/时间守恒，未把机械可分离特例当通用证明。

网站：网站PASS（EAUDIT复审）。
任意有限维相空间、可微实H、全时间F。hF只含F(0,ξ)=ξ及真实Hamilton ODE，不预设守恒。结论对每个初值和每个实t均为H(F(t,ξ))=H(ξ)；symplecticGradient 的两个偏梯度及负号正确。可微H足以链式求导得到沿轨道导数为零，不必额外C¹。声明数学等号正确，源JSON恢复书面恒等号。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1115；MD.Ch01.flow\_energy。

## 1. MD-1.5.1-HarmonicPhaseFlow · definition · 印刷p.27 / PDFp.50

### 2. 原文陈述

> for which the solution subject to initial values $`q(0)=q_0,p(0)=p_0`$ is

$$
\begin{pmatrix}q(t)\\p(t)\end{pmatrix}=\mathcal F_t\begin{pmatrix}q_0\\p_0\end{pmatrix}\equiv\begin{pmatrix}q_0\cos(\Omega t)+p_0\sin(\Omega t)/\Omega\\-q_0\Omega\sin(\Omega t)+p_0\cos(\Omega t)\end{pmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def harmonicPhaseFlow {n : ℕ} (Ω t : ℝ) (z : PhaseSpace n) : PhaseSpace n :=
  (Real.cos (Ω*t) • z.1 + (Real.sin (Ω*t)/Ω) • z.2,
    (-Ω*Real.sin (Ω*t)) • z.1 + Real.cos (Ω*t) • z.2)

theorem harmonicPhaseFlow_solution {n : ℕ} (Ω : ℝ) (hΩ : Ω ≠ 0) (z : PhaseSpace n) :
    harmonicPhaseFlow Ω 0 z = z ∧
    IsMechanicalSolutionOn (fun _ : Fin n => (1 : ℝ))
      (fun q => (-(Ω^2)) • q) univ univ (fun t => harmonicPhaseFlow Ω t z) := by
  constructor
  · simp [harmonicPhaseFlow]
  · exact harmonicFlow_isMechanicalSolution Ω hΩ z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.harmonicPhaseFlow；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\begin{pmatrix}q(t)\cr p(t)\end{pmatrix}=\mathcal F_t\begin{pmatrix}q_0\cr p_0\end{pmatrix}=\begin{pmatrix}q_0\cos(\Omega t)+p_0\sin(\Omega t)/\Omega\cr -q_0\Omega\sin(\Omega t)+p_0\cos(\Omega t)\end{pmatrix}.`$ | MD.Ch01.harmonicPhaseFlow，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.harmonicPhaseFlow; MD.Ch01.harmonicPhaseFlow\_solution | 保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.harmonicPhaseFlow; MD.Ch01.harmonicPhaseFlow\_solution | 保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。 |

[EXTRA] [EXTRA] 19号：保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。

### 6. 审计结论

19号本地签名预审：保留教材表达式为辅助总函数；解身份明确Ω≠0并补初值和真实ODE，不把Ω=0总化公式当自由粒子解。

网站：网站PASS（EAUDIT复审）。
harmonicPhaseFlow 的两个分量与原式一致，n维共同频率推广合法。总函数本身允许Ω=0，但 harmonicPhaseFlow\_solution 明确 hΩ:Ω≠0，结论含初值及单位质量、力 -(Ω²)q 的全时间真实积分曲线；没有声称零频总化式仍满足自由粒子方程。全部 [EXTRA] 已兑现。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1152；MD.Ch01.harmonicPhaseFlow。

## 1. MD-1.5.1-SpectralSolution · unnumbered_claim · 印刷p.27 / PDFp.50

### 2. 原文陈述

> If $`\boldsymbol A`$ has a basis of eigenvectors $`\boldsymbol\eta_i`$, $`i=1,\ldots,m`$, with corresponding eigenvalues $`\lambda_1,\lambda_2,\ldots,\lambda_m`$, then we may write the solution at time $`t`$ as

$$
\boldsymbol z(t)=\sum_{i=1}^{m}c_i e^{\lambda_i(t-t_0)}\boldsymbol\eta_i
$$


> where the coefficients $`c_i`$ are obtained by solving the equation

$$
\boldsymbol z(t_0)\equiv \boldsymbol\xi=\sum_{i=1}^{m}c_i\boldsymbol\eta_i.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem spectralsolution :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℂ E] [CompleteSpace E] {ι : Type*} [Fintype ι]
    (A : E →L[ℂ] E) (b : Module.Basis ι ℂ E) (ν : ι → ℂ)
    (hb : ∀ i, A (b i) = ν i • b i) (z : E) (t : ℝ),
    complexExponentialFlow A t z =
      ∑ i, (b.repr z i * Complex.exp (ν i * (t : ℂ))) • b i := by
  exact @MolecularDynamics.complexExponentialFlow_eigenbasis
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.spectralsolution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol z(t)=\sum_{i=1}^{m}c_i e^{\lambda_i(t-t_0)}\boldsymbol\eta_i`$；$`\boldsymbol z(t_0)=\boldsymbol\xi=\sum_{i=1}^{m}c_i\boldsymbol\eta_i.`$ | MD.Ch01.spectralsolution，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 有限维复数特征基；在公式中以t-t0调用零初时流；coeff=b.repr ξ。 | [EXTRA] |

[EXTRA] 有限维复数特征基；在公式中以t-t0调用零初时流；coeff=b.repr ξ。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
任意完备复赋范空间、有穷索引全基 b，A复连续线性、各基向量对应复特征值ν。有限基保证有限维；没有偷换实谱。公式对所有实elapsed time t和初值z，以b.repr z为系数，给复算子流的谱展开。将t实例化为目标时间减t₀即可得到原式；基坐标本身满足初值展开，省去显式t₀是时间平移的等价参数化。complexExponentialFlow 经 restrictScalars ℝ 的算子指数仍是原复线性系统的真实流。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1168；MD.Ch01.spectralsolution。

## 1. MD-1.5.1-BasisCoefficients · unnumbered_claim · 印刷p.27 / PDFp.50

### 2. 原文陈述

> (ii) with our assumption that the $`\{\boldsymbol\eta_i\}`$ form a basis, the calculation of the coefficients is always possible, since the matrix $`\boldsymbol X`$ whose columns are the eigenvectors will be invertible, that is, the coefficients $`c_i`$ can be enumerated as the components of a vector $`\boldsymbol c`$ which satisfies the square linear system

$$
\boldsymbol\xi=\boldsymbol X\boldsymbol c.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem basis_coefficients {m : ℕ} {𝕜 : Type*} [RCLike 𝕜]
    (b : Module.Basis (Fin m) 𝕜 (EuclideanSpace 𝕜 (Fin m)))
    (z : EuclideanSpace 𝕜 (Fin m)) :
    IsUnit (basisColumnMatrix b) ∧ (basisColumnMatrix b).mulVec (b.repr z) = WithLp.ofLp z ∧
    (basisColumnMatrix b)⁻¹.mulVec (WithLp.ofLp z) = b.repr z := by
  exact ⟨basisColumnMatrix_isUnit b, basisColumnMatrix_mulVec_repr b z,
    basisColumnMatrix_inverse_coefficients b z⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.basis\_coefficients；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol\xi=\boldsymbol X\boldsymbol c.`$ | MD.Ch01.basis\_coefficients，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | RCLike域包含实/复两种；真实有限基。 | [EXTRA] |

[EXTRA] RCLike域包含实/复两种；真实有限基。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
任意m、RCLike域、EuclideanSpace 的完整 Fin m 基。basisColumnMatrix i j=b j i 确实以基向量作列；结论同时给矩阵可逆、X(b.repr z)=z以及X⁻¹z=b.repr z，包含可计算坐标及其唯一性依据，实复均覆盖。不要求特征向量性质是此线性代数子命题的合理推广。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1180；MD.Ch01.basis\_coefficients。

## 1. MD-1.5.1-MatrixExponentialSolution · unnumbered_claim · 印刷p.27 / PDFp.50

### 2. 原文陈述

> An alternative expression for the solution is in terms of the exponential of the matrix $`\boldsymbol A`$ scaled by time,

$$
\boldsymbol z(t)=e^{\boldsymbol A(t-t_0)}\boldsymbol\xi.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem matrixexponentialsolution :
  ∀ {m : ℕ} (A : Matrix (Fin m) (Fin m) ℝ)
    (z : Position m) (t₀ : ℝ) (γ : ℝ → Position m)
    (hγ : ∀ t, HasDerivAt γ (WithLp.toLp 2 (A.mulVec (γ t))) t)
    (hinit : γ t₀ = z),
    γ = fun t => matrixExponentialFlow A (t - t₀) z := by
  exact @MolecularDynamics.matrixExponentialFlow_unique
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.matrixexponentialsolution；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol z(t)=e^{\boldsymbol A(t-t_0)}\boldsymbol\xi.`$ | MD.Ch01.matrixexponentialsolution，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
任意实m×m矩阵A、初值z、实t₀及全时间γ；hγ给真实导数γ′=Aγ，hinit给初值。结论是整个函数等于t↦matrixExponentialFlow A(t-t₀)z。依摘录展开为 exp((t-t₀)•A的连续算子表示)作用于z；有限维矩阵和连续线性算子代数同构保存指数，确为原式e^{A(t-t₀)}z。无对角化或实谱额外假设；本条是任意已给解的表示/唯一性，不单独新增存在结论。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1192；MD.Ch01.matrixexponentialsolution。

## 1. MD-1.5.1-MatrixExpSeries · unnumbered_claim · 印刷p.27–28 / PDFp.50–51

### 2. 原文陈述

> Alternatively, we may think of $`\exp(\boldsymbol A)`$ as the sum of the exponential series

$$
e^{\boldsymbol A}=\boldsymbol I+\boldsymbol A+\frac1{2!}\boldsymbol A^2+\frac1{3!}\boldsymbol A^3+\cdots
$$


> although this is seldom the most efficient method to compute it (this series converges for all matrices $`\boldsymbol A`$, and so in fact the exponential expression for the solution of the linear system is well defined even in the absence of a full set of eigenvectors).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem matrix_exp_series {n : ℕ} (A : Matrix (Fin n) (Fin n) ℝ) :
    HasSum (fun k : ℕ => ((k.factorial : ℝ)⁻¹) • A^k) (NormedSpace.exp A) := by
  exact MolecularDynamics.Chapter01Review.matrixExponentialSeries_hasSum A
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.matrix\_exp\_series；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`e^{\boldsymbol A}=\boldsymbol I+\boldsymbol A+\frac1{2!}\boldsymbol A^2+\frac1{3!}\boldsymbol A^3+\cdots`$ | MD.Ch01.matrix\_exp\_series，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1204；MD.Ch01.matrix\_exp\_series。

## 1. MD-1.5.2-FirstIntegral · definition · 印刷p.28 / PDFp.51

### 2. 原文陈述

> Another term for constant of motion is first integral. In general, if we have a dynamical system $`\dot{\boldsymbol z}=f(\boldsymbol z)`$, a first integral is a smooth function $`I(\boldsymbol z)`$ which is constant along solutions, for all values of the initial condition.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def smoothFirstIntegral {n : ℕ} (f : Position n → Position n) (Q : Set (Position n))
    (I : Position n → ℝ) : Prop := ContDiffOn ℝ ∞ I Q ∧ IsFirstIntegralOn f Q I
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.smoothFirstIntegral；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
smoothFirstIntegral 的对象是有限维实欧氏空间上的向量场 f、区域 Q 和实值 I；结论同时要求 Q 上 C∞ 及 IsFirstIntegralOn。后者遍历所有开放时间区间、所有留在 Q 中并满足真实 HasDerivAt 的解，再量化任意两时刻，准确表达所有初值解上的常性，不偷加全局存在。Q 是原文定义的区域化参数；取 univ 即全空间版本。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1212；MD.Ch01.smoothFirstIntegral。

## 1. MD-1.5.2-FirstIntegralCriterion · unnumbered_claim · 印刷p.28 / PDFp.51

### 2. 原文陈述

> Since this should hold everywhere, the condition for $`I`$ to be a first integral is that $`\nabla I\cdot f\equiv0`$.

### 3. 原文证明

> Let $`\boldsymbol z(t):t\in\mathbb R`$ be a solution, then

$$
I(\boldsymbol z(t))\equiv I(\boldsymbol z(0))\Rightarrow0\equiv\frac{\mathrm d}{\mathrm dt}I(\boldsymbol z(t))=\nabla I(\boldsymbol z(t))\cdot\dot{\boldsymbol z}(t)=\nabla I(\boldsymbol z(t))\cdot f(\boldsymbol z(t)).
$$


按渲染原页逐字转录原文论证。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem firstintegralcriterion :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [CompleteSpace E] (f : E → E) (Q : Set E) (J : E → ℝ)
    (hQ : IsOpen Q) (hf : ∀ x ∈ Q, ContDiffAt ℝ 1 f x)
    (hJ : ∀ x ∈ Q, DifferentiableAt ℝ J x),
    IsFirstIntegralOn f Q J ↔ ∀ x ∈ Q, fderiv ℝ J x (f x) = 0 := by
  exact @MolecularDynamics.isFirstIntegralOn_iff_differential
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.firstintegralcriterion；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 开放域、f局部C1确保每个初值局部解存在；I可微；微分作用=梯度内积另由firstIntegral\_gradient\_criterion。 | [EXTRA] |

[EXTRA] 开放域、f局部C1确保每个初值局部解存在；I可微；微分作用=梯度内积另由firstIntegral\_gradient\_criterion。

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：网站PASS（EAUDIT复审）。
对任意完备实赋范空间 E，开放 Q、Q 上局部 C¹ 向量场和可微 J，给出第一积分与每点 dJ(f)=0 的双向等价。完备性、局部 C¹ 和开放域提供从每个初值出发的局部解，从而必要方向不因缺乏解而真空成立；充分方向由链式法则及区间连通性成立。以连续线性微分替代梯度内积是等价且更一般的表达，未把梯度相等式当作额外结论。原文 smooth 类的判据在更弱可微类中仍成立。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1219；MD.Ch01.firstintegralcriterion。

