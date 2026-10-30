[上一部分](part05.zh-CN.md) / [目录](../../CH01_BLUEPRINT.zh-CN.md) / [下一部分](part07.zh-CN.md)

## 1. MD-1.6-HexagonalLattice · unnumbered_claim · 印刷p.35 / PDFp.58

### 2. 原文陈述

> it can be viewed as a rhombic lattice with $`n_x=n_y`$ and $`\theta=120^\circ`$; it can also be viewed as a rhombic lattice with $`\theta=60^\circ`$

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem hexagonal_lattice_two_bases (a : ℝ) :
    rhombicLattice a a (2*Real.pi/3) = rhombicLattice a a (Real.pi/3) := by
  ext x
  have hc : Real.cos (2*Real.pi/3) = -(1/2:ℝ) := by
    rw [show 2*Real.pi/3 = Real.pi-Real.pi/3 by ring, Real.cos_pi_sub, Real.cos_pi_div_three]
  have hs : Real.sin (2*Real.pi/3) = Real.sqrt 3/2 := by
    rw [show 2*Real.pi/3 = Real.pi-Real.pi/3 by ring, Real.sin_pi_sub, Real.sin_pi_div_three]
  constructor
  · rintro ⟨k,l,rfl⟩
    refine ⟨k-l,l,?_⟩
    congr 1
    ext i
    fin_cases i <;> simp [hc, hs,
      Real.cos_pi_div_three, Real.sin_pi_div_three] <;> push_cast <;> ring
  · rintro ⟨k,l,rfl⟩
    refine ⟨k+l,l,?_⟩
    congr 1
    ext i
    fin_cases i <;> simp [hc, hs,
      Real.cos_pi_div_three, Real.sin_pi_div_three] <;> push_cast <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hexagonal\_lattice\_two\_bases；完整当前陈述及同组辅助定义见本条第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:1985；MD.Ch01.hexagonal\_lattice\_two\_bases。

## 1. MD-1.6-UnitCell · definition · 印刷p.35 / PDFp.58

### 2. 原文陈述

> The unit cell is a description of the arrangement of atoms within a box; unit cells may be stacked in each direction to describe an atomic lattice.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def unitCellLattice (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3) : Set V3 :=
  {q | ∃ k : Fin 3 → ℤ, ∃ u ∈ motif,
    q = B.toEuclideanLin (WithLp.toLp 2 (fun i => (k i : ℝ))) + u}

/-- Half-open cell B([0,1)^3), with boundary representatives fixed by coordinates. -/
def unitCellBox (B : Matrix (Fin 3) (Fin 3) ℝ) : Set V3 :=
  B.toEuclideanLin '' {x : V3 | ∀ i, 0 ≤ x i ∧ x i < 1}

def UnitCellValidDomain (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3) : Prop :=
  B.det ≠ 0 ∧ motif.Finite ∧ motif.Nonempty ∧ motif ⊆ unitCellBox B

def unitCellOnDomain (B : Matrix (Fin 3) (Fin 3) ℝ) (motif : Set V3)
    (_h : UnitCellValidDomain B motif) : Set V3 := unitCellLattice B motif
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.unitCellOnDomain；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 21号网站建议修复 | MD.Ch01.unitCellOnDomain | 一般平移并集unitCellLattice保留；晶胞入口要求det B≠0及motif有限非空且位于B([0,1)³)。 |

[EXTRA] [EXTRA] 一般平移并集unitCellLattice保留；晶胞入口要求det B≠0及motif有限非空且位于B([0,1)³)。

### 6. 审计结论

21号按网站suggested\_fix修复并本地核验：一般平移并集unitCellLattice保留；晶胞入口要求det B≠0及motif有限非空且位于B([0,1)³)。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
MD.Ch01.unitCellLattice：FAIL（对象域/晶胞资格）。平移公式和存在量词准确编码了以三个生成向量重复 motif 的操作，但 B:Matrix (Fin 3) (Fin 3) ℝ 不是三维基的类型；B 可以奇异或为0。motif:Set V3 也未声明为盒内有限原子排列，甚至允许 motif=整个ℝ³。故定义输出不一定是三维离散原子晶格，不能仅靠 context\_notation 的自然语言声称已经落实原书的“within a box”和“each direction”。此构造可保留为平移并集函数；缺失的是作为原书 unit cell 的有效输入资格，而非要求每个晶胞只能有一个原子。[EXTRA] 为空，未提供这些资格。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2022；MD.Ch01.unitCellOnDomain。

## 1. MD-1.6-FCCStacking · definition · 印刷p.36 / PDFp.59

### 2. 原文陈述

> The fcc lattice corresponds to the common arrangement by which cannonballs are stacked into pyramidal structures; it can be viewed as a periodic stacking (ABCABC. . . ) of three hexagonally structured planar layers, as illustrated in Fig. 1.18.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def fccStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 3
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.fccStacking；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 将图示ABC编码为单位边长等边三角层，层高sqrt(2/3)及偏移由close-packed图示编码，正文未列数值公式。 | [EXTRA] |

[EXTRA] 将图示ABC编码为单位边长等边三角层，层高sqrt(2/3)及偏移由close-packed图示编码，正文未列数值公式。

### 6. 审计结论

ABC三周期保留；旧库附带具体几何层高和偏移不是正文逐字公式，需要导师确认图示编码。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.fccStacking：PASS。x∈ℝ³，当且仅当存在任意整数 k，使 z=k√(2/3)，且平面坐标落在 triangularLayer(j/2,j√3/6)，j=k mod3。triangularLayer(u,v) 的点为 (p+r/2+u,r√3/2+v)，p,r∈ℤ，是单位最近邻间距的等边三角点阵。余数0,1,2分别给 A、B、C 三个不同平移类；其顺序每三层重复。设 s=(1/2,√3/6)，则3s=(3/2,√3/2)为底层格向量，所以 C 后回到 A 正合 ABC 堆积；层高√(2/3)与水平孔位偏移共同给单位接触距离。k 可负，正模数的整数余数仍遍历0,1,2，覆盖双向无限晶格。固定尺度、坐标与取向是[EXTRA]明确说明的图示具体实现，并非正文声称给出了这些数值公式。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2030；MD.Ch01.fccStacking。

## 1. MD-1.6-HCPStacking · definition · 印刷p.36 / PDFp.59

### 2. 原文陈述

> Also shown in Fig. 1.18 is the hcp lattice, which, on the other hand, alternates two distinct planar lattices.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def hcpStacking : Set V3 :=
  {x | ∃ k : ℤ, let j := k % 2
    x 2 = k*Real.sqrt (2/3) ∧
      WithLp.toLp 2 ![x 0,x 1] ∈ triangularLayer ((j:ℝ)/2) ((j:ℝ)*Real.sqrt 3/6)}
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.hcpStacking；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |
| 原文未显式量化的技术资格 | 图示AB两个三角层，单位化层高及偏移是具体close-packed图示编码。 | [EXTRA] |

[EXTRA] 图示AB两个三角层，单位化层高及偏移是具体close-packed图示编码。

### 6. 审计结论

AB两周期保留；具体几何参数来源图示而非正文公式，需导师确认编码。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.hcpStacking：PASS。任意整数 k 给定高度 k√(2/3)，j=k mod2∈{0,1}，其平面层为 triangularLayer(j/2,j√3/6)。展开 triangularLayer，A 是零偏移的单位三角层，B 相对 A 偏移 (1/2,√3/6)，该偏移不在底层三角格中，故确为两种不同层；k+2 与 k 的平面位置一致而高度相差2√(2/3)，实现 ABAB。层高及孔位偏移给正确密堆积单位接触尺度。不存在误用三余数造成ABC的问题。[EXTRA]已说明单位化数值来自图示的具体密堆积编码，正文的两层交替信息得到完整保存。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2039；MD.Ch01.hcpStacking。

## 1. MD-1.6.1-MinimumGradientZero · unnumbered_claim · 印刷p.36–37 / PDFp.59–60

### 2. 原文陈述

> Regardless of the choice of boundary and/or the inclusion of non-pairwise potentials, the minimum of the potential energy occurs where

$$
\nabla U=0,
$$


> which gives in general a nonlinear system of $`N_c`$ equations in $`N_c`$ unknowns to be solved for the position vector $`\boldsymbol q^*`$ associated to mechanical equilibrium.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem minimumgradientzero :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n),
    DifferentiableAt ℝ U q → IsLocalMin U q → gradient U q = 0 := by
  exact MolecularDynamics.Chapter01Review.minimumGradientZero_proved

/-- 修正版，对应原文 MD-1.6.1-MinimumGradientZero，改动：显式标为无约束内点极小的必要条件，保留已证桥接；不扩展到约束边界。 -/
theorem minimumgradientzero_corrected :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n),
    DifferentiableAt ℝ U q → IsLocalMin U q → gradient U q = 0 := by
  exact MolecularDynamics.Chapter01Review.minimumGradientZero_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.minimumgradientzero；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\nabla U=0,`$ | MD.Ch01.minimumgradientzero，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 可微、内点局部极小；约束/边界极小需沿切空间而不必全梯度零。 | [EXTRA] |

[EXTRA] 可微、内点局部极小；约束/边界极小需沿切空间而不必全梯度零。

### 6. 审计结论

约束边界极小一般不能推出全梯度为零；原上下文若含边界须区分可行方向。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；限定解释=网站PASS。
MD.Ch01.minimumgradientzero：在[EXTRA]明示的无约束内点解释下，数学签名 PASS。n∈ℕ，U:EuclideanSpace ℝ (Fin n)→ℝ，q 属于同一空间；DifferentiableAt ℝ U q 与全空间 IsLocalMin U q 足以推出 gradient U q=0。它给必要条件，没有将驻点偷换为充分极小条件；n 维梯度等于0等价于 n 个分量方程，不需另断言这些方程对每个 U 都非线性。MD.Ch01.minimumgradientzero\_corrected：PASS，为同一个正确的无约束内点必要条件；其“修正”是解释范围的更正而非新签名。原书“Regardless of boundary”若包括受约束边界极小则过强，现有 Lean 也未覆盖这种解释。[EXTRA]已诚实披露可微、内点及边界限制，但不能据此认定原书无条件原句成立。故源文及总 verdict 保持 NEEDS\_HUMAN。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2048；MD.Ch01.minimumgradientzero。

## 1. MD-1.6.1-ForceLinearization · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> At the equilibrium point, we can linearize the system of differential equations by computing the Hessian matrix, then we find

$$
\nabla U(\boldsymbol q)\approx U''(\boldsymbol q^*)(\boldsymbol q-\boldsymbol q^*).
$$


> Then, letting $`\delta\boldsymbol q=\boldsymbol q-\boldsymbol q^*`$, $`\delta\boldsymbol p`$ represent small deviations from the equilibrium point at $`(\boldsymbol q,\boldsymbol p)=(\boldsymbol q^*,0)`$, we have

$$
\frac{\mathrm d\delta\boldsymbol q}{\mathrm dt}=\boldsymbol M^{-1}\delta\boldsymbol p,\qquad\frac{\mathrm d\delta\boldsymbol p}{\mathrm dt}=-U''(\boldsymbol q^*)\delta\boldsymbol q.
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem force_linearization {n : ℕ} (M : Matrix (Fin n) (Fin n) ℝ)
    (U : PotentialEnergy n) (qstar : Position n) (hU : ContDiffAt ℝ 2 U qstar)
    (heq : gradient U qstar = 0) :
    HasFDerivAt (fun z : PhaseSpace n => (matrixAction M⁻¹ z.2, -gradient U z.1))
      (((Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹).comp (ContinuousLinearMap.snd ℝ (Position n) (Momentum n))).prod
        ((-fderiv ℝ (gradient U) qstar).comp (ContinuousLinearMap.fst ℝ (Position n) (Momentum n))))
      (qstar,0) ∧
    (fun q => gradient U q - fderiv ℝ (gradient U) qstar (q-qstar)) =o[𝓝 qstar]
      (fun q => q-qstar) := by
  let B := Matrix.toEuclideanCLM (n := Fin n) (𝕜 := ℝ) M⁻¹
  have hg := (gradient_contDiffAt_of_potential_contDiffAt_two hU).differentiableAt (by norm_num)
  constructor
  · change HasFDerivAt (fun z : PhaseSpace n => (B z.2, -gradient U z.1)) _ (qstar,0)
    have hn : HasFDerivAt (fun q => -gradient U q) (-fderiv ℝ (gradient U) qstar) qstar :=
      hg.hasFDerivAt.neg
    have h₂ := hn.comp (qstar,0)
      ((ContinuousLinearMap.fst ℝ (Position n) (Momentum n)).hasFDerivAt (x := (qstar,0)))
    have h₁ := B.hasFDerivAt.comp (qstar,0)
      ((ContinuousLinearMap.snd ℝ (Position n) (Momentum n)).hasFDerivAt (x := (qstar,0)))
    exact h₁.prodMk h₂
  · have h := hasFDerivAt_iff_isLittleO.mp hg.hasFDerivAt
    simpa only [heq, sub_zero] using h
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.force\_linearization；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\nabla U(\boldsymbol q)\approx U''(\boldsymbol q^*)(\boldsymbol q-\boldsymbol q^*).`$；$`\frac{\mathrm d\delta\boldsymbol q}{\mathrm dt}=\boldsymbol M^{-1}\delta\boldsymbol p,\qquad\frac{\mathrm d\delta\boldsymbol p}{\mathrm dt}=-U''(\boldsymbol q^*)\delta\boldsymbol q.`$ | MD.Ch01.force\_linearization，完整展开陈述见上一行及第4段 | 一致 |
| 一般质量Hamilton向量场的块导数 | (M⁻¹∘snd).prod ((-D∇U)∘fst)的HasFDerivAt | 一致 |
| 梯度线性化误差 | ∇U(q)-D∇U(q*)(q-q*) =o[𝓝 q*] (q-q*) | 一致 |
| 原文未显式量化的技术资格 | 真实C2势及平衡梯度零；一般常M，原文M正定由机械背景保证但导数等式不需此资格。 | [EXTRA] |

[EXTRA] 真实C2势及平衡梯度零；一般常M，原文M正定由机械背景保证但导数等式不需此资格。

### 6. 审计结论

一般质量矩阵、真实块Frechet导数及完整小o梯度线性化全部保留，未假设结论。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.force\_linearization：PASS。对任意有限维 n、常实方阵 M、实势 U、qstar，ContDiffAt ℝ 2 U qstar 保证梯度可微，heq 要求平衡梯度为0。相空间为位置×动量的两个相同维欧氏空间，matrixAction 是矩阵的真实线性作用。所列导数将任意(δq,δp)送到(M⁻¹δp,−D(gradient U)(qstar)δq)，完整保留两条线性化运动方程，后者的 D gradient 即 Hessian。第二结论为 gradient U(q)−D(gradient U)(qstar)(q−qstar)=o(‖q−qstar‖)，因此保留原文的平衡点梯度近似且没有把非线性系统和线性系统宣称为全局精确相同。M 不要求正定或可逆，是对取定线性系数 Matrix.inv M 的数学推广；原机械质量矩阵取正定可逆时正好回到正文。该推广与[EXTRA]已披露的一般常 M 一致，不会使这个导数/小o结论失真；不能据此反称奇异 M 是合法机械质量矩阵。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2063；MD.Ch01.force\_linearization。

## 1. MD-1.6.1-MinimumHessianLiteral · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> At the minimum of the potential energy, $`U''`$ is a positive definite symmetric matrix.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem minimumhessianliteral :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    IsLocalMin U q →
    (∀ u v, inner ℝ u (fderiv ℝ (gradient U) q v) = inner ℝ v (fderiv ℝ (gradient U) q u)) ∧
    ∀ v : Position n, v ≠ 0 → 0 < inner ℝ v (fderiv ℝ (gradient U) q v) := by
  sorry

/-- 修正版，对应原文 MD-1.6.1-MinimumHessianLiteral，改动：正定改为半正定；仍保留Hessian对称性及所有非零方向。 -/
theorem minimumhessianliteral_corrected :
  ∀ (n : ℕ) (U : PotentialEnergy n) (q : Position n), ContDiff ℝ 2 U →
    IsLocalMin U q →
    (∀ u v, inner ℝ u (fderiv ℝ (gradient U) q v) = inner ℝ v (fderiv ℝ (gradient U) q u)) ∧
    ∀ v : Position n, v ≠ 0 → 0 ≤ inner ℝ v (fderiv ℝ (gradient U) q v) := by
  sorry

theorem minimumhessianliteral_counterexample :
    IsLocalMin (fun x : ℝ => x^4) 0 ∧ deriv (deriv (fun x : ℝ => x^4)) 0 = 0 := by
  constructor
  · change ∀ᶠ x in 𝓝 (0 : ℝ), (0 : ℝ)^4 ≤ x^4
    exact Filter.Eventually.of_forall (fun x => by norm_num only [zero_pow]; positivity)
  · have hd : deriv (fun x : ℝ => x^4) = fun x => 4*x^3 := by
      funext x
      convert ((hasDerivAt_id x).pow 4).deriv using 1 <;> simp
    rw [hd]
    simpa using (((hasDerivAt_id (0 : ℝ)).pow 3).const_mul 4).deriv
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.minimumhessianliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |

[EXTRA] 

### 6. 审计结论

局部极小只能推出Hessian半正定，严格极小也不能保证非退化。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
MD.Ch01.minimumhessianliteral：字面忠实性 PASS，但原书数学疑误 NEEDS\_HUMAN。对任意 n、U:Position n→ℝ、q，以全局 ContDiff ℝ 2 U 和 IsLocalMin U q 为前提；合取结论确实完整包括 Hessian 的所有 u,v 对称性，以及对所有非零 v 的正定性，没有把正定偷换成半正定。该正定结论在原书资格下不成立，依任务不把忠实版或 sorry 本身判成实现 FAIL。MD.Ch01.minimumhessianliteral\_corrected：PASS。相同 C²、全空间局部极小前提下 Hessian 对称且二次型非负，是正确必要条件；仍逐一覆盖所有非零方向，零方向亦自动为0。MD.Ch01.minimumhessianliteral\_counterexample：PASS。U(x)=x⁴ 在0有局部极小且二阶导数为0，足以反驳正定；该函数实际甚至是严格全局极小，因而增加“严格极小”也救不了字面版。标量例经一维欧氏空间的标准识别对应 n=1。总判 NEEDS\_HUMAN；未因修正版含 sorry 否定其签名。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2090；MD.Ch01.minimumhessianliteral。

## 1. MD-1.6.1-ImaginarySpectrum · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> The eigenvalues of the matrix

$$
\boldsymbol A:=\begin{bmatrix}0&\boldsymbol M^{-1}\\-U''(\boldsymbol q^*)&0\end{bmatrix}
$$


> are therefore all purely imaginary ($`\pm i\Omega`$, $`\Omega^2\in\mathbb R^+`$).

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem imaginary_spectrum :
  ∀ (n : ℕ) (M K : Matrix (Fin n) (Fin n) ℝ), M.PosDef → K.PosDef →
    let A := fun z : PhaseSpace n => (M⁻¹.toEuclideanLin z.2, -K.toEuclideanLin z.1)
    ∀ (a b : ℝ) (x y : PhaseSpace n), (x ≠ 0 ∨ y ≠ 0) →
      A x = a • x - b • y → A y = b • x + a • y →
      a = 0 ∧ 0 < b^2 ∧ A x = -b • y ∧ A (-y) = -b • x := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.imaginary\_spectrum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol A:=\begin{bmatrix}0&\boldsymbol M^{-1}\cr -U''(\boldsymbol q^*)&0\end{bmatrix}`$ | MD.Ch01.imaginary\_spectrum，完整展开陈述见上一行及第4段 | 一致 |
| 全部特征值±iΩ与Ω²>0 | 任意非零实虚特征对推出a=0、0<b²及A x=-b•y、A(-y)=-b•x | 一致；全部三个结论保留 |
| 原文未显式量化的技术资格 | M和Hessian K正定；复谱实虚向量编码。 | [EXTRA] |

[EXTRA] M和Hessian K正定；复谱实虚向量编码。

### 6. 审计结论

补齐实部零、非零频率平方正及共轭实虚特征对给出的±ib配对；一般SPD M,K保留。

网站：网站PASS（历史绑定 09ff185182a8；当前主声明及依赖未改）。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2120；MD.Ch01.imaginary\_spectrum。

## 1. MD-1.6.1-ComplexNormalMode · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> Associated to each eigenvalue pair we have a pair of complex conjugate eigenvectors $`\boldsymbol\xi,\overline{\boldsymbol\xi}`$ and also a pair of solutions which can be written in the complex form

$$
\boldsymbol z(t)=ae^{i\Omega t}\boldsymbol\xi+be^{-i\Omega t}\overline{\boldsymbol\xi},
$$


> ($`a,b`$ complex coefficients),

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem complexnormalmode :
  ∀ (n : ℕ) (A : Matrix (Fin n) (Fin n) ℝ) (η : Fin n → ℂ) (Ω : ℝ),
    η ≠ 0 → (A.map (algebraMap ℝ ℂ)).mulVec η = (Complex.I * Ω) • η →
    (fun i => star (η i)) ≠ 0 ∧
    (A.map (algebraMap ℝ ℂ)).mulVec (fun i => star (η i)) =
      (-Complex.I * Ω) • (fun i => star (η i)) ∧
    ∀ a b : ℂ, ∀ t : ℝ,
      HasDerivAt (fun s : ℝ =>
        a • (Complex.exp (Complex.I*Ω*s) • η) +
          b • (Complex.exp (-Complex.I*Ω*s) • (fun i => star (η i))))
        ((A.map (algebraMap ℝ ℂ)).mulVec
          (a • (Complex.exp (Complex.I*Ω*t) • η) +
            b • (Complex.exp (-Complex.I*Ω*t) • (fun i => star (η i))))) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.complexnormalmode；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol z(t)=ae^{i\Omega t}\boldsymbol\xi+be^{-i\Omega t}\overline{\boldsymbol\xi},`$ | MD.Ch01.complexnormalmode，完整展开陈述见上一行及第4段 | 一致 |
| 网站指出缺项及原文完整子句 | MD.Ch01.complexnormalmode | 增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.complexnormalmode | 增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。 |

[EXTRA] [EXTRA] 19号：增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。

### 6. 审计结论

19号本地签名预审：增加η非零及共轭η非零、−iΩ特征方程，保留所有系数的原复解公式；不以零向量冒充特征向量。

网站：网站PASS（EAUDIT复审）。
MD.Ch01.complexnormalmode：PASS。n∈ℕ，A 是实 n×n 矩阵，η∈ℂⁿ 非零，Ω∈ℝ；前提 A\_Cη=(iΩ)η，A\_C 是 A 的逐项实到复嵌入。结论先确认 conjugate η 非零，再确认 A\_C conjugate η=(−iΩ)conjugate η，实性正是此推论所需；最后对任意 a,b∈ℂ 和任意 t∈ℝ，给出 z(t)=a exp(iΩt)η+b exp(−iΩt)conjugate η 的真实导数为 A\_C z(t)。该表述完整覆盖共轭特征对及其复线性组合解，未以零向量充当特征向量，也未把 a,b 限制为实。Ω=0 时共轭解可退化/重合，签名没有多声称其线性独立，故仍正确。A 泛化为任何实矩阵而非限定机械块矩阵，是由同一特征方程导出解公式的有效推广。[EXTRA] 中非零及共轭特征方程均真实出现在声明里。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2132；MD.Ch01.complexnormalmode。

## 1. MD-1.6.1-RealNormalMode · unnumbered_claim · 印刷p.37 / PDFp.60

### 2. 原文陈述

> or recast in real form as ($`\alpha,\beta`$ real coefficients):

$$
\boldsymbol z(t)=\alpha[\sin(\Omega t)\operatorname{Re}(\boldsymbol\xi)+\cos(\Omega t)\operatorname{Im}(\boldsymbol\xi)]+\beta[\cos(\Omega t)\operatorname{Re}(\boldsymbol\xi)-\sin(\Omega t)\operatorname{Im}(\boldsymbol\xi)].
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem realnormalmode :
  ∀ {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (A : E →L[ℝ] E) (Ω α β : ℝ) (u v : E)
    (hu : A u = -Ω • v) (hv : A v = Ω • u) (t : ℝ),
    HasDerivAt (realNormalMode Ω α β u v)
      (A (realNormalMode Ω α β u v t)) t := by
  exact @MolecularDynamics.hasDerivAt_realNormalMode
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.realnormalmode；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol z(t)=\alpha[\sin(\Omega t)\operatorname{Re}(\boldsymbol\xi)+\cos(\Omega t)\operatorname{Im}(\boldsymbol\xi)]+\beta[\cos(\Omega t)\operatorname{Re}(\boldsymbol\xi)-\sin(\Omega t)\operatorname{Im}(\boldsymbol\xi)].`$ | MD.Ch01.realnormalmode，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

展开复用定理签名逐项核对原文；全部结论保留，额外技术条件逐条登记。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；限定解释=网站PASS。
MD.Ch01.realnormalmode：就所陈述的实解公式而言 PASS。对任意实赋范向量空间 E、A:E→L[ℝ]E、Ω,α,β∈ℝ、u,v∈E，只需 Au=−Ωv 和 Av=Ωu，即对所有实 t 得 z′(t)=Az(t)。展开 MolecularDynamics.realNormalMode，z 恰为 α(sin(Ωt)u+cos(Ωt)v)+β(cos(Ωt)u−sin(Ωt)v)，与原式相同；取 u=Re ξ、v=Im ξ 时 hu,hv 正是实矩阵 +iΩ 特征方程的实虚部。不需要额外的非零/独立条件来使这一解公式成立，泛化到赋范空间也合理。需要区分的是：前一条 a,b 为任意复数的 z 不一定为实，不能全部直接“改写”为此 α,β 为实的式子。当前声明没有给出系数约束或取实部的桥接，因此不能把它的 PASS 扩展为已证明原书无条件的复实全族等价。原文若意指真实物理解则正确，但省略了适用范围；依“原书疑误/歧义保留”要求，总判 NEEDS\_HUMAN，非把正确的 ODE 声明判成 FAIL。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2151；MD.Ch01.realnormalmode。

## 1. MD-1.7-PlanarTrimerModel · Example 1.8 (Planar Lennard-Jones Trimer) · 印刷p.38 / PDFp.61

### 2. 原文陈述

> One of the simplest illustrations of the chaotic nature of molecular systems is given by the Lennard-Jones model consisting of just three atoms with motion restricted to the plane. The energy is

$$
E=K+U=\frac{\|\dot{\boldsymbol q}_1\|^2}{2}+\frac{\|\dot{\boldsymbol q}_2\|^2}{2}+\frac{\|\dot{\boldsymbol q}_3\|^2}{2}+\hat\varphi_{\mathrm{LJ}}(\|\boldsymbol q_1-\boldsymbol q_2\|)+\hat\varphi_{\mathrm{LJ}}(\|\boldsymbol q_2-\boldsymbol q_3\|)+\hat\varphi_{\mathrm{LJ}}(\|\boldsymbol q_1-\boldsymbol q_3\|),
$$


> with the interatomic interaction given by $`\hat\varphi_{\mathrm{LJ}}(r)=4[r^{-12}-r^{-6}]`$.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def planarTrimerEnergy (q v : Fin 3 → Position 2) : ℝ :=
  (∑ i, ‖v i‖^2/2) + lennardJonesPotential 1 1 ‖q 0-q 1‖ +
    lennardJonesPotential 1 1 ‖q 1-q 2‖ + lennardJonesPotential 1 1 ‖q 0-q 2‖
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.planarTrimerEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`E=K+U=\frac{\Vert \dot{\boldsymbol q}_1\Vert ^2}{2}+\frac{\Vert \dot{\boldsymbol q}_2\Vert ^2}{2}+\frac{\Vert \dot{\boldsymbol q}_3\Vert ^2}{2}+\hat\varphi_{\mathrm{LJ}}(\Vert \boldsymbol q_1-\boldsymbol q_2\Vert )+\hat\varphi_{\mathrm{LJ}}(\Vert \boldsymbol q_2-\boldsymbol q_3\Vert )+\hat\varphi_{\mathrm{LJ}}(\Vert \boldsymbol q_1-\boldsymbol q_3\Vert ),`$ | MD.Ch01.planarTrimerEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
平面单位质量三粒子；Fin 3逐项动能及01、12、02三对势均一致。Position 2确为二维欧氏空间；ε=σ=1给出4(r⁻¹²−r⁻⁶)。碰撞点的Lean总函数值仅为延拓，不能解释为物理势。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2167；MD.Ch01.planarTrimerEnergy。

## 1. MD-1.7-CentralPairPotential · definition · 印刷p.38 / PDFp.61

### 2. 原文陈述

> In general, when the total potential is a sum of distance potentials

$$
U=\frac12\sum_{i\ne j}U_{ij},
$$


> where $`U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=\varphi_{ij}(\|\boldsymbol q_i-\boldsymbol q_j\|)`$, we say that the system has central forces.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def centralPairEnergy {N : ℕ} (φ : Fin N → Fin N → ℝ → ℝ) (q : Fin N → V3) :=
  (∑ i, ∑ j ∈ Finset.univ.erase i, φ i j (pairDistance (q i) (q j)))/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.centralPairEnergy；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`U=\frac12\sum_{i\ne j}U_{ij},`$ | MD.Ch01.centralPairEnergy，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
Fin N、三维位置和任意径向φ；erase i恰排除自相互作用，有序双和除以2与原式一致。该定义本身无需可微性或φ对称性；若要把φ解释为同一无序对的势，需采用context\_notation的对称约定。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2175；MD.Ch01.centralPairEnergy。

## 1. MD-1.7-CentralPairGradient · unnumbered_claim · 印刷p.38 / PDFp.61

### 2. 原文陈述

> In this case,

$$
\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem centralpairgradient :
  ∀ (φ : ℝ → ℝ) (q r : V3), q ≠ r → DifferentiableAt ℝ φ ‖q-r‖ →
    gradient (fun x => φ ‖x-r‖) q = -gradient (fun y => φ ‖q-y‖) r := by
  intro φ q r hqr hφ
  have hn : ‖q-r‖ ≠ 0 := norm_ne_zero_iff.mpr (sub_ne_zero.mpr hqr)
  have h₁ := (((hasFDerivAt_id q).sub_const r).norm_sq).sqrt (pow_ne_zero 2 hn)
  have h₂ := (((hasFDerivAt_const q r).sub (hasFDerivAt_id r)).norm_sq).sqrt (pow_ne_zero 2 hn)
  simp only [Real.sqrt_sq_eq_abs, abs_norm] at h₁ h₂
  have g₁ := hφ.hasDerivAt.comp_hasFDerivAt q h₁
  have g₂ := hφ.hasDerivAt.comp_hasFDerivAt r h₂
  apply ext_inner_right ℝ
  intro v
  simp only [Function.comp_def, id_eq, Pi.sub_apply] at g₁ g₂
  rw [inner_gradient_left, inner_neg_left, inner_gradient_left, g₁.fderiv, g₂.fderiv]
  simp [ContinuousLinearMap.comp_apply, innerSL_apply_apply, inner_neg_right]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.centralpairgradient；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),`$ | MD.Ch01.centralpairgradient，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 势在非碰撞距离可微；partial为欧氏梯度。 | [EXTRA] |

[EXTRA] 势在非碰撞距离可微；partial为欧氏梯度。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
全称φ、q、r；q≠r及φ在距离处可微是合法微分资格。两侧均为同一二体势分别对两个位置的欧氏梯度，负号、取值点和结论完整。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2182；MD.Ch01.centralpairgradient。

## 1. MD-1.7-CentralMomentum · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> and so, for central forces,

$$
\sum_{i=1}^N m_i\ddot{\boldsymbol q}_i=0,
$$


> which expresses the constancy of the momentum.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem central_momentum :
  ∀ (N : ℕ) (m : Fin N → ℝ) (v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I → IsPreconnected I →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, (∑ i, ∑ j, F t i j) = 0) ∧
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) ∧
    ∀ a ∈ I, ∀ b ∈ I, (∑ i, m i • v a i) = ∑ i, m i • v b i := by
  exact @momentum_conservation
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.central\_momentum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\sum_{i=1}^N m_i\ddot{\boldsymbol q}_i=0,`$ | MD.Ch01.central\_momentum，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。 | [EXTRA] |

[EXTRA] 真实Newton动量导数、逐对作用反对称、开放连通时间域；pᵢ=mᵢvᵢ。净力零为结论，未用作前提。

### 6. 审计结论

审查后去掉旧桥接中净力零前提，由真实逐对作用反对称推出净力零和全向量/每坐标动量守恒，保留全部结论。

网站：网站PASS（EAUDIT复审）。
任意N、质量、速度、逐对力和开放预连通时间域；逐对力反对称与每个动量的真实导数推出净力为零、总动量真实零导数及任意两时刻相等。结论没有被用作假设。以p=mv编码Newton动量，未另设q不影响这一动量层面的陈述。

### 7. 状态与证明位置

checked+documented priors；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2203；MD.Ch01.central\_momentum。

## 1. MD-1.7-CentralAngularMomentum · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> Moreover, viewing the $`\boldsymbol q_i`$ as vectors in $`\mathbb R^3`$ (with 0 as their third component),

$$
\boldsymbol q_i\times\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\boldsymbol q_j\times\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),
$$


> which implies

$$
\frac{\mathrm d}{\mathrm dt}\sum_{i=1}^N\boldsymbol q_i\times(m_i\dot{\boldsymbol q}_i)=0,
$$


> and tells us that the total angular momentum is also conserved.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem centralangularmomentum_derivative :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i-q t j) (F t i j) = 0) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i)) ∧
    ∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t := by
  intro N m q v F I _ hq hp hanti hcenter
  have hsub (u v w : V3) : cross3 (u-v) w = cross3 u w-cross3 v w := by
    ext k; fin_cases k <;> simp [cross3] <;> ring
  have hneg (u w : V3) : cross3 u (-w) = -cross3 u w := by
    ext k; fin_cases k <;> simp [cross3] <;> ring
  have ht (t : ℝ) (h : t ∈ I) (i j : Fin N) :
      cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i) := by
    have hc := hcenter t h i j
    rw [hsub] at hc
    rw [hanti t h j i,hneg,neg_neg]
    exact sub_eq_zero.mp hc
  have hcross (u w : ℝ → V3) (du dw : V3) (t : ℝ)
      (hu : HasDerivAt u du t) (hw : HasDerivAt w dw t) :
      HasDerivAt (fun s => cross3 (u s) (w s)) (cross3 du (w t)+cross3 (u t) dw) t := by
    have huc (k : Fin 3) : HasDerivAt (fun s => u s k) (du k) t :=
      (PiLp.proj (p := 2) (β := fun _ : Fin 3 => ℝ) k).hasFDerivAt.comp_hasDerivAt t hu
    have hwc (k : Fin 3) : HasDerivAt (fun s => w s k) (dw k) t :=
      (PiLp.proj (p := 2) (β := fun _ : Fin 3 => ℝ) k).hasFDerivAt.comp_hasDerivAt t hw
    have hc (k : Fin 3) : HasDerivAt (fun s => cross3 (u s) (w s) k)
        ((cross3 du (w t)+cross3 (u t) dw) k) t := by
      fin_cases k
      · convert! ((huc 1).mul (hwc 2)).sub ((huc 2).mul (hwc 1)) using 1 <;> simp [cross3] <;> ring
      · convert! ((huc 2).mul (hwc 0)).sub ((huc 0).mul (hwc 2)) using 1 <;> simp [cross3] <;> ring
      · convert! ((huc 0).mul (hwc 1)).sub ((huc 1).mul (hwc 0)) using 1 <;> simp [cross3] <;> ring
    let b : Fin 3 → V3 := fun k => WithLp.toLp 2 (Pi.single k 1)
    have hre (z : V3) : (∑ k, z k • b k) = z := by
      ext k; fin_cases k <;> simp [b,Fin.sum_univ_three]
    have hh := HasDerivAt.fun_sum (u := Finset.univ) (fun k _ => (hc k).smul_const (b k))
    simpa only [hre] using hh
  have hself (a : ℝ) (u : V3) : cross3 u (a • u) = 0 := by
    ext k; fin_cases k <;> simp [cross3] <;> ring
  have hsum (u : V3) (f : Fin N → V3) : cross3 u (∑ j,f j) = ∑ j,cross3 u (f j) := by
    ext k; fin_cases k <;> simp [cross3,Finset.mul_sum,Finset.sum_sub_distrib]
  refine ⟨ht,?_⟩
  intro t h
  have hz : (∑ i, ∑ j,cross3 (q t i) (F t i j)) = 0 := by
    apply paircancellation N (fun i j => cross3 (q t i) (F t i j))
    · intro i
      ext k
      have he := congrArg (fun u : V3 => u k) (ht t h i i)
      simp only [PiLp.neg_apply] at he
      change (cross3 (q t i) (F t i i)) k = 0
      linarith
    · exact ht t h
  have hd (i : Fin N) : HasDerivAt (fun s => cross3 (q s i) (m i • v s i))
      (∑ j,cross3 (q t i) (F t i j)) t := by
    simpa only [hself,zero_add,hsum] using hcross (fun s => q s i) (fun s => m i • v s i)
      (v t i) (∑ j,F t i j) t (hq t h i) (hp t h i)
  have hh := HasDerivAt.fun_sum (u := Finset.univ) (fun i _ => hd i)
  rwa [hz] at hh

theorem centralangularmomentum :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (F : ℝ → Fin N → Fin N → V3) (I : Set ℝ), IsOpen I → IsPreconnected I →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => m i • v s i) (∑ j, F t i j) t) →
    (∀ t ∈ I, ∀ i j, F t i j = -F t j i) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i-q t j) (F t i j) = 0) →
    (∀ t ∈ I, ∀ i j, cross3 (q t i) (F t i j) = -cross3 (q t j) (F t j i)) ∧
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, cross3 (q s i) (m i • v s i)) 0 t) ∧
    ∀ a ∈ I, ∀ b ∈ I, (∑ i, cross3 (q a i) (m i • v a i)) =
      ∑ i, cross3 (q b i) (m i • v b i) := by
  intro N m q v F I hI hc hq hp ha hf
  obtain ⟨ht,hd⟩ := centralangularmomentum_derivative N m q v F I hI hq hp ha hf
  refine ⟨ht,hd,?_⟩
  intro a ha b hb
  exact hI.is_const_of_deriv_eq_zero hc
    (fun t ht => (hd t ht).differentiableAt.differentiableWithinAt)
    (fun t ht => (hd t ht).deriv) ha hb
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.centralangularmomentum；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol q_i\times\frac\partial{\partial\boldsymbol q_i}U_{ij}(\boldsymbol q_i,\boldsymbol q_j)=-\boldsymbol q_j\times\frac\partial{\partial\boldsymbol q_j}U_{ij}(\boldsymbol q_i,\boldsymbol q_j),`$；$`\frac{\mathrm d}{\mathrm dt}\sum_{i=1}^N\boldsymbol q_i\times(m_i\dot{\boldsymbol q}_i)=0,`$ | MD.Ch01.centralangularmomentum，完整展开陈述见上一行及第4段 | 一致 |
| 逐对力矩相消 | ∀t i j,cross3(qᵢ,Fᵢⱼ)=-cross3(qⱼ,Fⱼᵢ) | 一致 |
| 角动量守恒 | HasDerivAt (∑i,cross3(qᵢ,mᵢ•vᵢ)) 0 | 一致 |
| 原文未显式量化的技术资格 | 真实位置和动量导数；反对称内力和沿位移方向中心力。 | [EXTRA] |
| 网站指出缺项及原文完整子句 | MD.Ch01.centralangularmomentum\_derivative; MD.Ch01.centralangularmomentum | 保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。 |
| 网站指出缺项及原文完整子句 | MD.Ch01.centralangularmomentum\_derivative; MD.Ch01.centralangularmomentum | 保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。 |

[EXTRA] 真实位置和动量导数；反对称内力和沿位移方向中心力。；[EXTRA] 19号：保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。

### 6. 审计结论

19号本地签名预审：保留逐对力矩及总角动量真实零导数，补时间域预连通与任意两时刻守恒。旧长证明另名复用，新增常值推导只做小修。

网站：网站PASS（EAUDIT复审）。
已核对derivative和主定理两声明：位置导数为v，动量导数为逐对力和，力反对称且位移叉力为零；cross3三个分量是标准叉积。逐对力矩抵消、角动量真实零导数及任意a,b∈I守恒俱全。[EXTRA]19号要求已落实为主定理的IsPreconnected I与两时刻相等；derivative辅助版不要求连通是合理的。三维结果包含原文平面嵌入。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2277；MD.Ch01.centralangularmomentum。

## 1. MD-1.7-CenterOfMassMotion · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> This means that the system will translate and rotate at a constant rate in time.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem centerofmassmotion :
  ∀ (N : ℕ) (m : Fin N → ℝ) (q v : ℝ → Fin N → V3)
    (I : Set ℝ) (a : ℝ), IsOpen I → IsPreconnected I → a ∈ I →
    (∀ i, 0 < m i) → 0 < ∑ i, m i →
    (∀ t ∈ I, ∀ i, HasDerivAt (fun s => q s i) (v t i) t) →
    (∀ t ∈ I, HasDerivAt (fun s => ∑ i, m i • v s i) 0 t) →
    ∀ t ∈ I,
      (∑ i, m i)⁻¹ • (∑ i, m i • q t i) =
        (∑ i, m i)⁻¹ • (∑ i, m i • q a i) +
          (t-a) • ((∑ i, m i)⁻¹ • (∑ i, m i • v a i)) := by
  intro N m q v I a ho hi ha hm hM hq hp
  let P := ∑ i, m i • v a i
  have hPc (t : ℝ) (ht : t ∈ I) : (∑ i, m i • v t i) = P :=
    ho.is_const_of_deriv_eq_zero hi
      (fun s hs => (hp s hs).differentiableAt.differentiableWithinAt)
      (fun s hs => (hp s hs).deriv) ht ha
  have hQ (t : ℝ) (ht : t ∈ I) : HasDerivAt (fun s => ∑ i, m i • q s i) P t := by
    have hh := HasDerivAt.fun_sum (u := Finset.univ) (fun i _ => (hq t ht i).const_smul (m i))
    rwa [hPc t ht] at hh
  have hR (t : ℝ) (ht : t ∈ I) : HasDerivAt (fun s => (∑ i, m i • q s i)-s • P) 0 t := by
    simpa only [one_smul, sub_self, id_eq] using (hQ t ht).fun_sub ((hasDerivAt_id t).smul_const P)
  intro t ht
  have hc := ho.is_const_of_deriv_eq_zero hi
    (fun s hs => (hR s hs).differentiableAt.differentiableWithinAt)
    (fun s hs => (hR s hs).deriv) ht ha
  have he : (∑ i, m i • q t i) = (∑ i, m i • q a i)+(t-a) • P := by
    calc
      _ = ((∑ i, m i • q a i)-a • P)+t • P := (sub_eq_iff_eq_add).mp hc
      _ = _ := by simp [sub_smul, sub_eq_add_neg, add_smul, neg_smul, add_assoc, add_comm, add_left_comm]
  have hh := congrArg (fun u => (∑ i,m i)⁻¹ • u) he
  simpa [P, smul_add, smul_smul, mul_comm] using hh
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.centerofmassmotion；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| 原文未显式量化的技术资格 | 质量正、总质量正、真实位置导数、连通时间域；平移部分据已得总动量守恒。 | [EXTRA] |

[EXTRA] 质量正、总质量正、真实位置导数、连通时间域；平移部分据已得总动量守恒。

### 6. 审计结论

逐项核对展开后的陈述、真实定义、量词及[EXTRA]；语义本地通过，完整Lean检查另行登记。

网站：网站PASS（EAUDIT复审）。
范围按context\_notation只审translation。质量正且总质量正、a∈开放预连通I、q′=v、总动量真实零导数，推出每个t∈I质心为初始质心加(t−a)乘初始质心速度，分母和各求和均正确。旋转断言另交第7条；这里不能将整句的旋转部分视为已证明。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2300；MD.Ch01.centerofmassmotion。

## 1. MD-1.7-ConstantRotationLiteral · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> This means that the system will translate and rotate at a constant rate in time.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem constantrotationliteral :
  ∀ (r θ : ℝ → ℝ) (ℓ : ℝ),
    (∀ t, 0 < r t ∧ (r t)^2*deriv θ t = ℓ) →
    ∃ freq : ℝ, ∀ t, deriv θ t = freq := by
  sorry

/-- 修正版，对应原文 MD-1.7-ConstantRotationLiteral，改动：a增加恒定正半径才推恒角速；默认b保留角动量守恒并明确θ′=ℓ/r²。 -/
theorem constantrotationliteral_corrected_a (R ℓ : ℝ) (θ : ℝ → ℝ)
    (hR : 0 < R) (h : ∀ t, R^2 * deriv θ t = ℓ) :
    ∃ freq : ℝ, ∀ t, deriv θ t = freq := by
  refine ⟨ℓ/R^2,fun t => ?_⟩
  apply (eq_div_iff (pow_ne_zero 2 hR.ne')).mpr
  simpa [mul_comm] using h t

/-- 修正版，对应原文 MD-1.7-ConstantRotationLiteral，改动：角速度随半径变化。 -/
theorem constantrotationliteral_corrected_b (r θ : ℝ → ℝ) (ℓ : ℝ)
    (h : ∀ t, 0 < r t ∧ (r t)^2 * deriv θ t = ℓ) :
    ∀ t, deriv θ t = ℓ/(r t)^2 := by
  intro t
  apply (eq_div_iff (pow_ne_zero 2 (h t).1.ne')).mpr
  simpa [mul_comm] using (h t).2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.constantrotationliteral；完整当前陈述及同组辅助定义见本条第4段 | NEEDS\_HUMAN |

[EXTRA] 

### 6. 审计结论

守恒的是角动量，转动惯量或半径可变时角速度可变。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
literal完整编码“r²θ′=ℓ且r>0推出恒角速”，忠实于原书旋转断言，但数学上不成立。corrected\_a增加固定正半径后结论正确；corrected\_b只作除以正r²的代数推导，正确且更贴近应保留的守恒律。两修正版均未假设所求恒角速。

### 7. 状态与证明位置

incomplete；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2336；MD.Ch01.constantrotationliteral。

## 1. MD-1.7-IsoscelesCoordinates · definition · 印刷p.39 / PDFp.62

### 2. 原文陈述

> Let us introduce new coordinates in the Lennard-Jones trimer as illustrated in Fig. 1.21, so that the center of mass is fixed at the origin: that is,

$$
\boldsymbol q_1=\begin{bmatrix}x\\-y/3\\0\end{bmatrix},\qquad\boldsymbol q_2=\begin{bmatrix}-x\\-y/3\\0\end{bmatrix},\qquad\boldsymbol q_3=\begin{bmatrix}0\\2y/3\\0\end{bmatrix},
$$



### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
def isoscelesCoordinates (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]

/-- 修正版，对应原文 MD-1.7-IsoscelesCoordinates，改动：把三坐标公式作为主动选取的对称子模型，证明其质心为零；不把零总动量/角动量推出等腰。 -/
def isoscelesCoordinates_corrected (x y : ℝ) : Fin 3 → V3 :=
  ![WithLp.toLp 2 ![x,-y/3,0],WithLp.toLp 2 ![-x,-y/3,0],WithLp.toLp 2 ![0,2*y/3,0]]

theorem isoscelesCoordinates_corrected_center (x y : ℝ) :
    (∑ i : Fin 3, isoscelesCoordinates_corrected x y i) = 0 := by
  ext k
  fin_cases k <;> simp [isoscelesCoordinates_corrected,Fin.sum_univ_three] <;> ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.isoscelesCoordinates；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`\boldsymbol q_1=\begin{bmatrix}x\cr -y/3\cr 0\end{bmatrix},\qquad\boldsymbol q_2=\begin{bmatrix}-x\cr -y/3\cr 0\end{bmatrix},\qquad\boldsymbol q_3=\begin{bmatrix}0\cr 2y/3\cr 0\end{bmatrix},`$ | MD.Ch01.isoscelesCoordinates，完整展开陈述见上一行及第4段 | 一致 |

[EXTRA] 

### 6. 审计结论

零平动、零角动量不强迫任意三角形等腰；必须额外选择对称初态及证明对称性保持。 原文与修正版独立保留；默认选项是工作版本，尚未获导师裁定。

网站：原书疑误=NEEDS\_HUMAN；原文忠实性单列；修正版=网站PASS；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）；原文已形式化子句=网站PASS（限定范围）。
三个向量分量、Fin 3次序及三维平面嵌入完全吻合。corrected定义数值上与原定义相同；corrected\_center的三坐标和为零，单位质量下即质心零。修正的是适用范围而非坐标公式。原段由动量约束导出等腰的暗示不成立，必须由人工保留勘误说明。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2362；MD.Ch01.isoscelesCoordinates。

## 1. MD-1.7-IsoscelesEnergyReduction · unnumbered_claim · 印刷p.39 / PDFp.62

### 2. 原文陈述

> reducing the energy to

$$
E=\dot x^2+\frac{\dot y^2}{3}+2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x),
$$


> which describes the vibrational motion.

### 3. 原文证明

原书无独立完整证明。
原书无独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

```lean
theorem isosceles_energy_reduction (x y v w : ℝ) (hx : 0 < x) :
    (∑ i : Fin 3, ‖isoscelesCoordinates v w i‖^2/2) +
      uniformLJEnergy 1 1 (isoscelesCoordinates x y) = isoscelesEnergy x y v w := by
  have h01 : isoscelesCoordinates x y 0-isoscelesCoordinates x y 1 =
      WithLp.toLp 2 ![2*x,0,0] := by
    ext i; fin_cases i <;> simp [isoscelesCoordinates] <;> ring
  have h02 : isoscelesCoordinates x y 0-isoscelesCoordinates x y 2 =
      WithLp.toLp 2 ![x,-y,0] := by
    ext i; fin_cases i <;> simp [isoscelesCoordinates] <;> ring
  have h12 : isoscelesCoordinates x y 1-isoscelesCoordinates x y 2 =
      WithLp.toLp 2 ![-x,-y,0] := by
    ext i; fin_cases i <;> simp [isoscelesCoordinates] <;> ring
  have hsq (z : V3) : ‖z‖^2 = (z 0)^2+(z 1)^2+(z 2)^2 := by
    simpa only [Fin.sum_univ_three,Real.norm_eq_abs,sq_abs] using
      PiLp.norm_sq_eq_of_L2 (fun _ : Fin 3 => ℝ) z
  have hn (a b : ℝ) : ‖(WithLp.toLp 2 ![a,b,0] : V3)‖ = Real.sqrt (a^2+b^2) := by
    rw [norm_eq_sqrt_real_inner,real_inner_self_eq_norm_sq,hsq]
    simp
  have hK : (∑ i : Fin 3, ‖isoscelesCoordinates v w i‖^2/2) = v^2+w^2/3 := by
    simp only [Fin.sum_univ_three,hsq]
    simp [isoscelesCoordinates]
    ring
  have h0 : Finset.Ioi (0:Fin 3) = {1,2} := by decide
  have h1 : Finset.Ioi (1:Fin 3) = {2} := by decide
  have h2 : Finset.Ioi (2:Fin 3) = ∅ := by decide
  rw [hK]
  unfold uniformLJEnergy
  simp only [Fin.sum_univ_three,h0,h1,h2,Finset.sum_singleton,Finset.sum_empty]
  rw [Finset.sum_pair (show (1:Fin 3) ≠ 2 by decide)]
  simp [pairDistance,h01,h02,h12,hn,Real.sqrt_sq_eq_abs,abs_of_pos hx,abs_mul,
    isoscelesEnergy,isoscelesPotential]
  ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 原文对象、量词、前提与完整定义/结论（见第2段逐字引用） | MD.Ch01.isosceles\_energy\_reduction；完整当前陈述及同组辅助定义见本条第4段 | 一致 |
| $`E=\dot x^2+\frac{\dot y^2}{3}+2\hat\varphi_{\mathrm{LJ}}\left(\sqrt{x^2+y^2}\right)+\hat\varphi_{\mathrm{LJ}}(2x),`$ | MD.Ch01.isosceles\_energy\_reduction，完整展开陈述见上一行及第4段 | 一致 |
| 原文未显式量化的技术资格 | 单位质量及x>0保证q1-q2距离为2x，未以所求能量等式为假设。 | [EXTRA] |

[EXTRA] 单位质量及x>0保证q1-q2距离为2x，未以所求能量等式为假设。

### 6. 审计结论

逐项核对公式、对象域、量词和结论；定义只登记模型，不声称解存在或物理近似有效。

网站：网站PASS（EAUDIT复审）。
x>0使01距离为2x，另两距离为√(x²+y²)；速度坐标取(v,w)后动能为v²+w²/3。uniformLJEnergy用Ioi每对只计一次，等式不是前提。定义的总函数延拓在本x>0域不触及碰撞。

### 7. 状态与证明位置

self-contained；已逐声明核验公理；含占位的声明仍未证明。
位置：Blueprint/Ch01.lean:2378；MD.Ch01.isosceles\_energy\_reduction。

