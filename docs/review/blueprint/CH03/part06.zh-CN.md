[上一部分](part05.zh-CN.md) / [目录](../../CH03_BLUEPRINT.zh-CN.md) / [下一部分](part07.zh-CN.md)

## 1. MD-3.4-OptimalTruncation · unnumbered_claim · 印刷p.116 / PDFp.138

### 2. 原文陈述

> If $`h`$ is small, then for $`k`$ sufficiently small the quantity in brackets is less than one and the difference from the truncated approximation decreases in magnitude with increasing $`k`$. As soon as $`k`$ satisfies

$$
k+1\gt \frac1{Dh}
$$


> the power grows monotonically without bound. We can minimize the difference between $`\mathcal G_h`$ and $`\mathcal F_h^{(k)}`$ by choosing

$$
k=\frac1{Dh\mathrm e}-1,
$$


> in which case,

$$
\|\mathcal G_h(\zeta)-\mathcal F_h^{(k)}(\zeta)\|\lt \widetilde C h\mathrm e^{-1/(\gamma h)},\qquad\gamma=\frac1{D\mathrm e}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem optimalTruncation :
  ∀ A > 0, ∃ δ > 0, ∃ C > 0, ∀ h ∈ Ioo 0 δ,
    let k := Nat.floor (1/(A*Real.exp 1*h))
    0 < k ∧ (A*(k:ℝ)*h)^k ≤ C*Real.exp (-(1/(A*Real.exp 1))/h) := by
  sorry



/-- 修正版，对应原文 MD-3.4-OptimalTruncation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem optimalTruncation_corrected :
  ∀ A > 0, ∃ δ > 0, ∃ C > 0, ∀ h ∈ Ioo 0 δ,
    let k := Nat.floor (1/(A*Real.exp 1*h))
    0 < k ∧ (A*(k:ℝ)*h)^k ≤ C*Real.exp (-(1/(A*Real.exp 1))/h) := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.optimalTruncation`；`MD.Ch03.optimalTruncation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | D>0；足够小正h；取整后允许独立正C吸收误差。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] D>0；足够小正h；取整后允许独立正C吸收误差。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；Lean只断言m=floor(1/(Ae h))>0及(A m h)^m≤C exp(−1/(Ae h))，m对应原文k+1；没有任何数值映射/实际截断流对象，未表达原文增长、最小化实际差或展示的原书指数。D>0及正小h合理，独立C可吸收取整误差；但context\_notation承认缩窄不能代替完整statement\_scope。此定理含sorry，语义缺项独立于证明完成度。[ERRATUM?]成立：连续变量x的log((Dh x)^x)=x log(Dh x)，最小点x=1/(Deh)，最小值exp(−1/(Deh))。

### 7. 状态与证明位置

incomplete；`MD.Ch03.optimalTruncation`：未证（原书疑误不证）；`MD.Ch03.optimalTruncation_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1417)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-ExponentialFlat · unnumbered_claim · 印刷p.116 / PDFp.138

### 2. 原文陈述

> This bound tends to zero extremely rapidly (more rapidly than any power of $`h`$) as $`h\to0`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem exponentialFlat :
  ∀ γ > 0, ∀ k : ℕ, Tendsto (fun h : ℝ => Real.exp (-γ/h)/h^k) (𝓝[>] 0) (𝓝 0) := by
  intro γ hγ k
  have ht : Tendsto (fun h : ℝ => γ / h) (𝓝[>] 0) atTop := by
    simpa only [div_eq_mul_inv] using tendsto_inv_nhdsGT_zero.const_mul_atTop hγ
  have hp := ((Real.tendsto_pow_mul_exp_neg_atTop_nhds_zero k).comp ht).div_const (γ^k)
  convert hp using 1
  · ext h
    by_cases hh : h = 0
    · subst h; cases k <;> simp
    · have hg : γ ≠ 0 := ne_of_gt hγ
      simp only [Function.comp_apply, div_pow, neg_div]
      field_simp
  · simp
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.exponentialFlat` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | γ>0、h→0⁺；不声称只有C∞就有指数缺陷。 | [EXTRA] |

[EXTRA] γ>0、h→0⁺；不声称只有C∞就有指数缺陷。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；γ>0和h→0⁺符合正步长上下文。∀γ>0 ∀k∈ℕ exp(−γ/h)/h^k→0保证C h exp(−γ/h)对任意固定幂平坦；对任意实幂也可由较大自然数幂推出。原书即使用倒数γ，仍属于某个正指数常数。context\_notation是数学解释，不是逐字原文。Ch03.lean此条有证明；本次未编译，PASS仅评签名。

### 7. 状态与证明位置

self-contained；`MD.Ch03.exponentialFlat`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1438)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-ScalarVerletShadow4 · definition · 印刷p.117 / PDFp.139

### 2. 原文陈述

> The modified energy for the Verlet method for a single degree of freedom system with energy $`H=p^2/2+U(q)`$ is

$$
\widetilde H_h=H+\frac{h^2}{24}(2p^{T}U''p-(U')^2) +h^4\left(\frac1{720}p^4U''''-\frac1{120}p^2U'U'''-\frac1{240}(U')^2U''-\frac1{60}p^2((U'')^2+U'U''')\right)+O(h^6).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def scalarVerletShadow4 (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ :=
  let p := z.2; let q := z.1
  p^2/2+U q+h^2/24*(2*p^2*deriv (deriv U) q-(deriv U q)^2)+h^4*(
    p^4*iteratedDeriv 4 U q/720-p^2*deriv U q*iteratedDeriv 3 U q/120-
    (deriv U q)^2*iteratedDeriv 2 U q/240-p^2*((iteratedDeriv 2 U q)^2+deriv U q*iteratedDeriv 3 U q)/60)

theorem scalarVerletShadow4_matching_Printed (U : ℝ → ℝ) (_hU : ContDiff ℝ ∞ U)
    (B : Set (ℝ × ℝ)) (_hB : IsCompact B) :
    ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → (ℝ × ℝ) → ℝ → (ℝ × ℝ),
      ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, Γ h z 0=z ∧
        solution (fun x : ℝ × ℝ ↦
          (deriv (fun p ↦ scalarVerletShadow4 U h (x.1,p)) x.2,
           -deriv (fun q ↦ scalarVerletShadow4 U h (q,x.2)) x.1)) (Γ h z) 0 h ∧
        ‖(let P := z.2-(h/2)*deriv U z.1
           let Q := z.1+h*P
           (Q,P-(h/2)*deriv U Q))-Γ h z h‖ ≤ C*h^7 := by
  sorry

/-- 修正版；对应MD-3.4-ScalarVerletShadow4，原印式独立保留。 -/
```

独立修正版：

```lean
def scalarVerletShadow4_corrected (U : ℝ → ℝ) (h : ℝ) (z : ℝ × ℝ) : ℝ :=
  let p := z.2; let q := z.1
  p^2/2+U q+h^2/24*(2*p^2*deriv (deriv U) q-(deriv U q)^2)+h^4*(
    -p^4*iteratedDeriv 4 U q/720+p^2*deriv U q*iteratedDeriv 3 U q/120+
    p^2*(iteratedDeriv 2 U q)^2/60-(deriv U q)^2*iteratedDeriv 2 U q/240)

theorem scalarVerletShadow4_matching_corrected (U : ℝ → ℝ) (_hU : ContDiff ℝ ∞ U)
    (B : Set (ℝ × ℝ)) (_hB : IsCompact B) :
    ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → (ℝ × ℝ) → ℝ → (ℝ × ℝ),
      ∀ h ∈ Ioo 0 δ, ∀ z ∈ B, Γ h z 0=z ∧
        solution (fun x : ℝ × ℝ ↦
          (deriv (fun p ↦ scalarVerletShadow4_corrected U h (x.1,p)) x.2,
           -deriv (fun q ↦ scalarVerletShadow4_corrected U h (q,x.2)) x.1)) (Γ h z) 0 h ∧
        ‖(let P := z.2-(h/2)*deriv U z.1
           let Q := z.1+h*P
           (Q,P-(h/2)*deriv U Q))-Γ h z h‖ ≤ C*h^7 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.scalarVerletShadow4`；`MD.Ch03.scalarVerletShadow4_matching_Printed`；`MD.Ch03.scalarVerletShadow4_corrected`；`MD.Ch03.scalarVerletShadow4_matching_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 有限h⁴多项式保留；补足光滑势/紧集上与真实velocity Verlet及该Hamiltonian实际局部流的O(h⁷)端点匹配，对应Hamiltonian O(h⁶)遗漏；新陈述未证明。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 【原书疑误】保留印刷有限式及原匹配断言（另名Printed，不证明）；独立精确有理数jet核对kick-drift-kick后，修正版h⁴四项系数为−1/720,+1/120,+1/60,−1/240，分别乘p⁴U⁗、p²U′U‴、p²(U″)²、(U′)²U″。SymPy验到h⁶；统一实际流O(h⁷)估计仍未证明，交导师核查。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 保留原印系数及原印匹配声明，独立列修正系数和匹配声明；精确代数核对见SHADOW4\_ALGEBRA.json，实际流误差定理未证明。 | [EXTRA] |

[EXTRA] [EXTRA] 有限h⁴多项式保留；补足光滑势/紧集上与真实velocity Verlet及该Hamiltonian实际局部流的O(h⁷)端点匹配，对应Hamiltonian O(h⁶)遗漏；新陈述未证明。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[EXTRA] 【原书疑误】保留印刷有限式及原匹配断言（另名Printed，不证明）；独立精确有理数jet核对kick-drift-kick后，修正版h⁴四项系数为−1/720,+1/120,+1/60,−1/240，分别乘p⁴U⁗、p²U′U‴、p²(U″)²、(U′)²U″。SymPy验到h⁶；统一实际流O(h⁷)估计仍未证明，交导师核查。；[ERRATUM?] 保留原印系数及原印匹配声明，独立列修正系数和匹配声明；精确代数核对见SHADOW4\_ALGEBRA.json，实际流误差定理未证明。

### 6. 审计结论

本轮修复：【原书疑误】保留印刷有限式及原匹配断言（另名Printed，不证明）；独立精确有理数jet核对kick-drift-kick后，修正版h⁴四项系数为−1/720,+1/120,+1/60,−1/240，分别乘p⁴U⁗、p²U′U‴、p²(U″)²、(U′)²U″。SymPy验到h⁶；统一实际流O(h⁷)估计仍未证明，交导师核查。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；两个声明均已审校。scalarVerletShadow4取z=(q,p)，所定义有限h⁴多项式在标量化后忠实于原印，不能因定义中没有O项而当作余项已证。新增scalarVerletShadow4\_matching确实量化任意C∞势、紧B和统一正C、δ，给出从z出发的真实Hamiltonian局部流及velocity Verlet的O(h⁷)端点匹配。C∞的∞编码在本条实际正确；但这个新增结论本身为假：U(q)=q²/2时，印刷多项式产生的q端点与Verlet已有非零h⁵差项，故不能有O(h⁷)界。FAIL针对新增matching的数学结论；忠实的印刷有限式本身应保留，并把原书系数问题转人工，不能通过补sorry解决。

### 7. 状态与证明位置

incomplete；`MD.Ch03.scalarVerletShadow4`：定义；`MD.Ch03.scalarVerletShadow4_matching_Printed`：未证（原书疑误不证）；`MD.Ch03.scalarVerletShadow4_corrected`：定义；`MD.Ch03.scalarVerletShadow4_matching_corrected`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1458)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-CommutingEnergy · unnumbered_claim · 印刷p.117 / PDFp.139

### 2. 原文陈述

> Suppose that, somehow, $`H`$ were exactly conserved along the numerical solution, so

$$
\dot H=0\Rightarrow\{H,\widetilde H_h\}=0.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem commutingEnergy :
  ∀ (n : ℕ) (H K : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    ContDiffOn ℝ 1 H D → IsOpen D → actualFlow (textbookHamiltonianVectorField K) D Φ η →
    (∀ z ∈ D, ∀ t ∈ Ioo (-η) η, H (Φ t z)=H z) → ∀ z ∈ D, textbookPoissonBracket H K z=0 := by
  sorry



/-- 修正版，对应原文 MD-3.4-CommutingEnergy。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem commutingEnergy_corrected :
  ∀ (n : ℕ) (H K : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    ContDiffOn ℝ 1 H D → IsOpen D → actualFlow (textbookHamiltonianVectorField K) D Φ η →
    (∀ z ∈ D, ∀ t ∈ Ioo (-η) η, H (Φ t z)=H z) → ∀ z ∈ D, textbookPoissonBracket H K z=0 := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.commutingEnergy`；`MD.Ch03.commutingEnergy_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H在开放D为C¹、实际K-Hamiltonian流存在正η且全轨道H守恒。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] H在开放D为C¹、实际K-Hamiltonian流存在正η且全轨道H守恒。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；actualFlow要求η>0、每个D中初值Φ(0,z)=z、每个|t|<η轨道留D且导数等于K的真实Hamiltonian场。textbookPoissonBracket H K=DH(X\_K)，X\_K=J∇K；H在开放D为C¹足以从连续轨道守恒得到结论。但Lean前提是全部连续时刻守恒，替换了原文数值解离散守恒，属于关键强化而非技术性[EXTRA]。context\_notation已指出此差异，却未修复原陈述覆盖。定理含sorry不影响这一签名判断。

### 7. 状态与证明位置

incomplete；`MD.Ch03.commutingEnergy`：未证（原书疑误不证）；`MD.Ch03.commutingEnergy_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1499)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-CommutingEnergySymmetry · unnumbered_claim · 印刷p.118 / PDFp.140

### 2. 原文陈述

> Since $`\{g_1,g_2\}=-\{g_2,g_1\}`$, we have

$$
\{\widetilde H_h,H\}=0.
$$


> This would imply that $`\widetilde H_h`$ is actually, itself, a first integral of the molecular system.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem commutingEnergySymmetry :
  ∀ (n : ℕ) (H K : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    ContDiffOn ℝ 1 K D → IsOpen D → actualFlow (textbookHamiltonianVectorField H) D Φ η →
    (∀ z ∈ D, MolecularDynamics.textbookPoissonBracket H K z=0) →
      (∀ z ∈ D, MolecularDynamics.textbookPoissonBracket K H z=0) ∧ ∀ z ∈ D, ∀ t ∈ Ioo (-η) η, K (Φ t z)=K z := by
  intro n H K D Φ η hK hD hflow hzero
  have hskew : ∀ z ∈ D, MolecularDynamics.textbookPoissonBracket K H z = 0 := by
    intro z hz
    rw [MolecularDynamics.textbookPoissonBracket_skew, hzero z hz, neg_zero]
  refine ⟨hskew, ?_⟩
  intro z hz t ht
  have hη := hflow.1
  have htraj := hflow.2 z hz
  have hd : ∀ s ∈ Ioo (-η) η, HasDerivAt (fun u => K (Φ u z)) 0 s := by
    intro s hs
    have hks : DifferentiableAt ℝ K (Φ s z) :=
      (hK.differentiableOn (by norm_num)).differentiableAt (hD.mem_nhds (htraj.2 s hs).1)
    simpa only [textbookLieDerivative_hamiltonian_eq_poisson,
      hskew _ (htraj.2 s hs).1] using
      hasDerivAt_textbookLieDerivative (textbookHamiltonianVectorField H) K
        (fun u => Φ u z) s hks (htraj.2 s hs).2
  have heq := isOpen_Ioo.is_const_of_deriv_eq_zero (convex_Ioo (-η) η).isPreconnected
    (fun s hs => (hd s hs).differentiableAt.differentiableWithinAt)
    (fun s hs => (hd s hs).deriv) ht (show (0:ℝ) ∈ Ioo (-η) η by constructor <;> linarith)
  simpa only [htraj.1] using heq
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.commutingEnergySymmetry` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 开放D、K为C¹、实际H流存在正η。 | [EXTRA] |

[EXTRA] 开放D、K为C¹、实际H流存在正η。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；K=H̃_h，前提在D逐点{H,K}=0；实际括号为DH(J∇K)，反对称得到{K,H}=0。actualFlow给η>0、初值及区间内X\_H轨道；K在开放D为C¹使沿轨道导数DK(X\_H)为0，从而所有z∈D、|t|<η有K(Φ(t,z))=K(z)。两项结论完整覆盖原文。开放域/C¹/真实流是合理技术资格，无需假设修正级数收敛。此条有证明，本次未编译；PASS只评签名。

### 7. 状态与证明位置

self-contained；`MD.Ch03.commutingEnergySymmetry`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1522)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-EnergySymplecticNoGo · unnumbered_claim · 印刷p.118 / PDFp.140

### 2. 原文陈述

> This certainly seems unlikely to hold except in very special cases indeed, unless the numerical method happens to coincide with the exact solution (up to a time rescaling). Thus the properties of symplecticness and energy conservation for numerical methods are essentially mutually exclusive from a practical point of view. A more precise formulation of this result was first given by Ge and Marsden [400].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem energySymplecticNoGo :
  ∀ (n : ℕ) (H : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → ContDiffOn ℝ ⊤ H D → noExtraIntegrals H D →
    actualFlow (textbookHamiltonianVectorField H) D Φ η →
    ContDiff ℝ ⊤ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2) →
    (∀ z ∈ D, G 0 z=z) → (∀ h ∈ Ioo (-η) η, IsTextbookSymplecticMap (G h)) →
    (∀ h ∈ Ioo (-η) η, ∀ z ∈ D, H (G h z)=H z) →
    ∃ δ > 0, ∃ τ : ℝ → ℝ → ℝ, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ D, G h z=Φ (τ h (H z)) z := by
  sorry



/-- 修正版，对应原文 MD-3.4-EnergySymplecticNoGo。改动：只给能量保持的局部微分链式约束；一般全域时间重参数结论仍须连通能量层、局部流域与一致时间窗资格，保留为未覆盖问题，未拿此局部式充当原全局结论。 -/
```

独立修正版：

```lean
theorem energySymplecticNoGo_corrected (n : ℕ)
    (H : SymplecticCoordinates n → ℝ) (G : SymplecticCoordinates n → SymplecticCoordinates n)
    (z : SymplecticCoordinates n) (hH : DifferentiableAt ℝ H (G z))
    (hG : DifferentiableAt ℝ G z) (hE : H ∘ G = H) :
    fderiv ℝ H z = (fderiv ℝ H (G z)).comp (fderiv ℝ G z) := by
  simpa only [hE] using (fderiv_comp z hH hG)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.energySymplecticNoGo`；`MD.Ch03.energySymplecticNoGo_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]noExtraIntegrals明确所有光滑第一积分是H的函数；开放D、全光滑实际流与近恒等辛方法；该强资格原文未列。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 只给能量保持的局部微分链式约束；一般全域时间重参数结论仍须连通能量层、局部流域与一致时间窗资格，保留为未覆盖问题，未拿此局部式充当原全局结论。 | [EXTRA] |

[EXTRA] [EXTRA]noExtraIntegrals明确所有光滑第一积分是H的函数；开放D、全光滑实际流与近恒等辛方法；该强资格原文未列。；[ERRATUM?] 只给能量保持的局部微分链式约束；一般全域时间重参数结论仍须连通能量层、局部流域与一致时间窗资格，保留为未覆盖问题，未拿此局部式充当原全局结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；noExtraIntegrals实际展开为：所有D上光滑且{K,H}=0的全局函数K都等于某个g(H)，不要求g光滑。[EXTRA]是明显强资格，原书未给，不能独自推出当前全局统一δ结论；还缺轨道时间范围与非紧D上的统一控制。actualFlow仅在|t|<η约束Φ，结论τ h (H z)却不受此范围约束，也没有G(h,D)⊆D条件。全局辛定义为C¹及每点AᵀJA=J，不含全局双射。原书practical措辞不足以证明此精确版本；已有明确反例，故不以NEEDS\_HUMAN替代FAIL。定理含sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch03.energySymplecticNoGo`：未证（原书疑误不证）；`MD.Ch03.energySymplecticNoGo_corrected`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1553)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-EqualComponentIntegral · unnumbered_claim · 印刷p.122 / PDFp.144

### 2. 原文陈述

> Consider the following 2D example of a differential equation system

$$
\dot u=f(u,v),\qquad\dot v=f(u,v).
$$


> Notice that this system has a first integral

$$
I(u,v)=u-v,
$$


> and consider the application of Euler's method:

$$
u_{n+1}=u_n+hf(u_n,v_n),\qquad v_{n+1}=v_n+hf(u_n,v_n).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem equalComponentFirstIntegral :
    ∃ I : ℝ × ℝ → ℝ, (∀ z, I z = z.1-z.2) ∧
      ∀ (f : ℝ × ℝ → ℝ) (u v : ℝ → ℝ),
        (∀ t, HasDerivAt u (f (u t,v t)) t) →
        (∀ t, HasDerivAt v (f (u t,v t)) t) →
        ∀ t, I (u t,v t) = I (u 0,v 0) := by
  refine ⟨(fun z => z.1-z.2), (fun _ => rfl), ?_⟩
  intro f u v hu hv t
  have hd : ∀ s, HasDerivAt (fun t => u t-v t) 0 s := by
    intro s
    simpa using (hu s).fun_sub (hv s)
  exact is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.equalComponentFirstIntegral` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实轨道导数资格显式，采用全实时间轨道版本，不宣称任意f都全时间有解。 | [EXTRA] |

[EXTRA] 真实轨道导数资格显式，采用全实时间轨道版本，不宣称任意f都全时间有解。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开 Ch03.lean:900 的存在量词：同一个 I 对所有 f 都满足 I(u,v)=u−v，随后对所有全实时间可微解 u,v 断言 I(u(t),v(t))=I(u(0),v(0))；HasDerivAt 的两个导数值完全相同，故差的导数为零。对象和量词正确。[EXTRA] 导数资格是解轨道资格；全实时间版本是已明确标注的范围选择，不包含任意 f 的全局解存在性，也不提供一般局部区间版本。Euler 更新是本条原文中的引出下一条的定义性上下文，由 EqualEulerIntegral 单独承载。此处有显式证明而非 sorry；本判定是签名语义判定，未运行 Lean 编译。

### 7. 状态与证明位置

self-contained；`MD.Ch03.equalComponentFirstIntegral`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1576)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-EqualEulerIntegral · unnumbered_claim · 印刷p.123 / PDFp.145

### 2. 原文陈述

> We see that

$$
I(u_{n+1},v_{n+1})=u_{n+1}-v_{n+1}=u_n-v_n=I(u_n,v_n),
$$


> which means that Euler's method conserves this first integral.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem equalEulerIntegral :
  ∀ (f : ℝ × ℝ → ℝ) h z, equalComponentIntegral (z.1+h*f z,z.2+h*f z)=equalComponentIntegral z := by
  exact MolecularDynamics.Chapter03Review.equalEulerIntegral_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.equalEulerIntegral` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt 中 MolecularDynamics/Chapter03/ReviewDefinitions.lean 的 equalComponentIntegral(z)=z.1−z.2。签名对任意实数 h、任意点 z、任意标量场 f 断言共同加上 hf(z) 后差不变，正是 PDF145 的一步等式；无需正步长或正则性。实数精确算术符合原文对舍入误差的说明。Ch03.lean 使用 equalEulerIntegral\_proved，依赖中该证明为展开差并 ring，无 sorry；未编译。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.equalEulerIntegral`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1591)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-LinearEulerIntegral · unnumbered_claim · 印刷p.123 / PDFp.145

### 2. 原文陈述

> Generalizing this slightly, we could imagine a system of ODEs of the form

$$
\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z),
$$


> such that, for some vector $`\boldsymbol b`$,

$$
\boldsymbol b\cdot \boldsymbol f(\boldsymbol z)\equiv0,
$$


> then $`I(\boldsymbol z)=\boldsymbol b\cdot\boldsymbol z`$ is a first integral. It is straightforward to see that Euler's method conserves such a linear first integral exactly, as is true of many other popular numerical methods.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem linearEulerIntegral :
  ∀ (n : ℕ) (b : Q n →L[ℝ] ℝ) (f : Q n → Q n), (∀ z, b (f z)=0) →
    ∀ (h : ℝ) z, b (z+h • f z)=b z := by
  exact MolecularDynamics.Chapter03Review.linearEulerIntegral_proved

theorem linearEulerIntegral_continuous (n : ℕ) (b : Q n →L[ℝ] ℝ)
    (f : Q n → Q n) (_hb : ∀ z, b (f z)=0)
    (γ : ℝ → Q n) (a d : ℝ) (_had : a ≤ d)
    (_hγ : ∀ t ∈ Icc a d, HasDerivWithinAt γ (f (γ t)) (Icc a d) t) :
    ∀ t ∈ Icc a d, b (γ t)=b (γ a) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.linearEulerIntegral`；`MD.Ch03.linearEulerIntegral_continuous` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留已证Euler精确保存；补连续ODE解上真实线性第一积分恒定，覆盖本条原句连续与离散两结论。 | [EXTRA] |

[EXTRA] [EXTRA] 保留已证Euler精确保存；补连续ODE解上真实线性第一积分恒定，覆盖本条原句连续与离散两结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；linearEulerIntegral与linearEulerIntegral\_continuous均已核对。Q n为有限维实坐标，连续线性泛函b等价于原文向量点积；∀z,b(f z)=0正是恒等条件。第一声明对任意实步长h与初值z给出b(z+h•f z)=b z。第二声明在a≤d的闭区间上要求γ满足真实ODE的区间内导数，再对所有t∈[a,d]断言b(γ t)=b(γ a)。区间端点的HasDerivWithinAt还给出所需相对连续性；a=d也正确。[EXTRA]补连续第一积分结论已实际出现，没有把恒定性当作前提。原句对其它popular methods未给明确方法类，未据此虚构一个全称方法定理。

### 7. 状态与证明位置

incomplete；`MD.Ch03.linearEulerIntegral`：已证；`MD.Ch03.linearEulerIntegral_continuous`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1597)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-LinearRKIntegral · unnumbered_claim · 印刷p.123 / PDFp.145

### 2. 原文陈述

> It is straightforward to see that Euler's method conserves such a linear first integral exactly, as is true of many other popular numerical methods.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem linearRKIntegral :
  ∀ (n s : ℕ) (ℓ : Q n →L[ℝ] ℝ) (f : Q n → Q n), (∀ z, ℓ (f z)=0) →
    ∀ (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ) h z w F,
      rungeKuttaRelation f A b h z w F → ℓ w=ℓ z := by
  exact MolecularDynamics.Chapter03Review.linearRKIntegral_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.linearRKIntegral` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 明确选择任意有限阶段Runge–Kutta关系；所有阶段满足原场线性第一积分资格。 | [EXTRA] |

[EXTRA] 明确选择任意有限阶段Runge–Kutta关系；所有阶段满足原场线性第一积分资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开 Q n=Fin n→ℝ，并实际展开 rungeKuttaRelation：对每个 i，F\_i=f(z+h∑_j A\_ij F\_j)，且 w=z+h∑_i b\_i F\_i。因此每个 ℓ(F\_i)=0，线性性给 ℓ(w)=ℓ(z)。A、权重、h、阶段数及满足关系的阶段全称量化，包含显式与隐式有限阶段 RK，不偷加阶段解的存在或唯一性。[EXTRA] 选取 RK 作为原文“many other”的实例合理，阶段条件是方法定义，不是把待证结论当假设；无需阶条件或 ∑b\_i=1。依赖 linearRKIntegral\_proved 展开阶段关系后使用线性性，无 sorry；未编译。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.linearRKIntegral`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1611)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-VerletOscillatorEnergy · unnumbered_claim · 印刷p.123 / PDFp.145

### 2. 原文陈述

> In the case of Euler's method applied to the harmonic oscillator, the error in energy grows with time and without bound. In the case of Störmer-Verlet, the energy fluctuates but remains bounded for all time and at its worst is of size proportional to $`h^2`$, a numerical observation that is supported by the existence of the modified Hamiltonian.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletOscillatorEnergy :
  ∀ Ω ρ : ℝ, 0 < Ω → 0 < ρ → ρ < 2 → ∀ z : Z 1,
    ∃ C ≥ 0, ∀ h : ℝ, |h*Ω| ≤ ρ → ∀ ν : ℕ, |mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2)
      (oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν)-
      mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z| ≤ C*h^2 := by
  intro Ω ρ hΩ hρ hρ2 z
  let A : ℝ := 1-ρ^2/4
  have hA : 0 < A := by dsimp [A]; nlinarith
  let E0 : ℝ := (z.2 0)^2+Ω^2*(z.1 0)^2
  refine ⟨Ω^2*E0/(4*A), by dsimp [E0]; positivity, ?_⟩
  intro h hh ν
  have hh2 : h^2*Ω^2 ≤ ρ^2 := by
    have hp := abs_le.mp hh
    nlinarith
  have hcoeff : A ≤ 1-h^2*Ω^2/4 := by dsimp [A]; linarith
  let K : Z 1 → ℝ := fun w => (w.2 0)^2+Ω^2*(1-h^2*Ω^2/4)*(w.1 0)^2
  have hstep : ∀ w, K (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0) h w) = K w := by
    intro w
    simp only [K, verlet, invMass, Pi.add_apply, Pi.smul_apply, smul_eq_mul, inv_one, one_mul]
    ring
  have hi : K (oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν) = K z := by
    induction ν with
    | zero => rfl
    | succ ν ih => rw [oneStepIterate_succ, hstep, ih]
  have hupper : K z ≤ E0 := by
    dsimp [K, E0]
    nlinarith [mul_nonneg (sq_nonneg h) (mul_nonneg (sq_nonneg Ω)
      (mul_nonneg (sq_nonneg Ω) (sq_nonneg (z.1 0))))]
  have hlower : ∀ w, Ω^2*A*(w.1 0)^2 ≤ K w := by
    intro w
    dsimp [K]
    nlinarith [sq_nonneg (w.2 0), mul_nonneg (sq_nonneg Ω)
      (mul_nonneg (sub_nonneg.mpr hcoeff) (sq_nonneg (w.1 0)))]
  let w := oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν
  have hden : 0 < Ω^2*A := mul_pos (sq_pos_of_pos hΩ) hA
  have hw : (w.1 0)^2 ≤ E0/(Ω^2*A) := by
    apply (le_div_iff₀ hden).mpr
    have hlow := hlower w
    change K w=K z at hi
    nlinarith
  have hz : (z.1 0)^2 ≤ E0/(Ω^2*A) := by
    apply (le_div_iff₀ hden).mpr
    have hlow := hlower z
    nlinarith
  have habs : |(w.1 0)^2-(z.1 0)^2| ≤ 2*E0/(Ω^2*A) := by
    rw [mul_div_assoc]
    apply abs_le.mpr
    constructor <;> nlinarith [sq_nonneg (w.1 0), sq_nonneg (z.1 0)]
  have heq : mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) w-
      mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z =
      (h^2*Ω^4/8)*((w.1 0)^2-(z.1 0)^2) := by
    norm_num [mechanicalEnergy, quadraticKinetic, Fin.sum_univ_one]
    change K w=K z at hi
    dsimp [K] at hi
    nlinarith
  change |mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) w-
    mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z| ≤ _
  rw [heq, abs_mul, abs_of_nonneg (show 0 ≤ h^2*Ω^4/8 by positivity)]
  calc
    _ ≤ (h^2*Ω^4/8)*(2*E0/(Ω^2*A)) := mul_le_mul_of_nonneg_left habs (by positivity)
    _ = Ω^2*E0/(4*A)*h^2 := by
      have hg : Ω ≠ 0 := ne_of_gt hΩ
      have ha : A ≠ 0 := ne_of_gt hA
      field_simp
      ring



/-- 修正版，对应原文 MD-3.5-VerletOscillatorEnergy。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem verletOscillatorEnergy_corrected :
  ∀ Ω ρ : ℝ, 0 < Ω → 0 < ρ → ρ < 2 → ∀ z : Z 1,
    ∃ C ≥ 0, ∀ h : ℝ, |h*Ω| ≤ ρ → ∀ ν : ℕ, |mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2)
      (oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν)-
      mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z| ≤ C*h^2 := by
  intro Ω ρ hΩ hρ hρ2 z
  let A : ℝ := 1-ρ^2/4
  have hA : 0 < A := by dsimp [A]; nlinarith
  let E0 : ℝ := (z.2 0)^2+Ω^2*(z.1 0)^2
  refine ⟨Ω^2*E0/(4*A), by dsimp [E0]; positivity, ?_⟩
  intro h hh ν
  have hh2 : h^2*Ω^2 ≤ ρ^2 := by
    have hp := abs_le.mp hh
    nlinarith
  have hcoeff : A ≤ 1-h^2*Ω^2/4 := by dsimp [A]; linarith
  let K : Z 1 → ℝ := fun w => (w.2 0)^2+Ω^2*(1-h^2*Ω^2/4)*(w.1 0)^2
  have hstep : ∀ w, K (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0) h w) = K w := by
    intro w
    simp only [K, verlet, invMass, Pi.add_apply, Pi.smul_apply, smul_eq_mul, inv_one, one_mul]
    ring
  have hi : K (oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν) = K z := by
    induction ν with
    | zero => rfl
    | succ ν ih => rw [oneStepIterate_succ, hstep, ih]
  have hupper : K z ≤ E0 := by
    dsimp [K, E0]
    nlinarith [mul_nonneg (sq_nonneg h) (mul_nonneg (sq_nonneg Ω)
      (mul_nonneg (sq_nonneg Ω) (sq_nonneg (z.1 0))))]
  have hlower : ∀ w, Ω^2*A*(w.1 0)^2 ≤ K w := by
    intro w
    dsimp [K]
    nlinarith [sq_nonneg (w.2 0), mul_nonneg (sq_nonneg Ω)
      (mul_nonneg (sub_nonneg.mpr hcoeff) (sq_nonneg (w.1 0)))]
  let w := oneStepIterate (verlet (fun _ => 1) (fun q _ => -Ω^2*q 0)) h z ν
  have hden : 0 < Ω^2*A := mul_pos (sq_pos_of_pos hΩ) hA
  have hw : (w.1 0)^2 ≤ E0/(Ω^2*A) := by
    apply (le_div_iff₀ hden).mpr
    have hlow := hlower w
    change K w=K z at hi
    nlinarith
  have hz : (z.1 0)^2 ≤ E0/(Ω^2*A) := by
    apply (le_div_iff₀ hden).mpr
    have hlow := hlower z
    nlinarith
  have habs : |(w.1 0)^2-(z.1 0)^2| ≤ 2*E0/(Ω^2*A) := by
    rw [mul_div_assoc]
    apply abs_le.mpr
    constructor <;> nlinarith [sq_nonneg (w.1 0), sq_nonneg (z.1 0)]
  have heq : mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) w-
      mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z =
      (h^2*Ω^4/8)*((w.1 0)^2-(z.1 0)^2) := by
    norm_num [mechanicalEnergy, quadraticKinetic, Fin.sum_univ_one]
    change K w=K z at hi
    dsimp [K] at hi
    nlinarith
  change |mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) w-
    mechanicalEnergy (fun _ => 1) (fun q => Ω^2*q 0^2/2) z| ≤ _
  rw [heq, abs_mul, abs_of_nonneg (show 0 ≤ h^2*Ω^4/8 by positivity)]
  calc
    _ ≤ (h^2*Ω^4/8)*(2*E0/(Ω^2*A)) := mul_le_mul_of_nonneg_left habs (by positivity)
    _ = Ω^2*E0/(4*A)*h^2 := by
      have hg : Ω ≠ 0 := ne_of_gt hΩ
      have ha : A ≠ 0 := ne_of_gt hA
      field_simp
      ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.verletOscillatorEnergy`；`MD.Ch03.verletOscillatorEnergy_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Ω>0，固定ρ∈(0,2)，\|hΩ\|≤ρ；排除不稳定及阈值步长。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] Ω>0，固定ρ∈(0,2)，|hΩ|≤ρ；排除不稳定及阈值步长。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；当前verletOscillatorEnergy是正确的受限版本：一自由度、单位质量、Ω>0，先固定0<ρ<2和z，再选C≥0，随后对所有|hΩ|≤ρ及所有ν∈ℕ统一控制真实机械能差≤Ch²。常数不依赖h或ν，符合稳定范围内全时间O(h²)能量误差；h=0和零初值也不成问题。展开verlet、mechanicalEnergy和oneStepIterate后对象一致。但原句无条件的全时间断言在稳定阈值及不稳定步长下失败；[EXTRA]确实限制了适用范围，不能当作无条件原句已核验。另原句Euler无界分句在当前给出的全部声明中没有对应结论。context\_notation虽说另属EulerGrowth，本任务未提供它，且statement\_scope仍称覆盖所引原句；该分流及原书省略资格需人工确认。NEEDS\_HUMAN不否定当前受限Verlet上界的数学正确性。

### 7. 状态与证明位置

self-contained；`MD.Ch03.verletOscillatorEnergy`：已证；`MD.Ch03.verletOscillatorEnergy_corrected`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1620)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-MomentumProjection · definition · 印刷p.123 / PDFp.145

### 2. 原文陈述

> We start by taking a timestep with any arbitrary (nonconserving) numerical method, say to an intermediate phase point $`\overline{\boldsymbol Q},\overline{\boldsymbol P}`$, then we “fix it up” by scaling the momentum by an adjustment factor, defining

$$
\boldsymbol Q=\overline{\boldsymbol Q},\qquad\boldsymbol P=\gamma\overline{\boldsymbol P},
$$


> selecting $`\gamma`$ so that the energy in the result is a prescribed value $`E`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def momentumProjection {n : ℕ} (γ : ℝ) (z : Z n) : Z n := (z.1,γ • z.2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.momentumProjection` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；momentumProjection对任意n、实γ和中间相点z:Z n定义(z.1,γ•z.2)。Z n=Q n×Q n，第一分量位置不变，第二分量动量统一缩放，正是显示式。这是带给定γ的映射定义，未声称所有γ都守能，也未声称所有中间点都存在可用γ；本条context已把选择条件明确交给ProjectionConstraint/ProjectionFactor，故不是漏掉一个已宣称的存在性定理。

### 7. 状态与证明位置

self-contained；`MD.Ch03.momentumProjection`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1756)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-ProjectionConstraint · (3.12) · 印刷p.123 / PDFp.145

### 2. 原文陈述

> This method is easy to implement: the equation that must be solved is

$$
\frac{\gamma^2\overline{\boldsymbol P}^{T}\boldsymbol M^{-1}\overline{\boldsymbol P}}{2}+U(\overline{\boldsymbol Q})=E.\tag{3.12}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def projectionConstraint (E K U γ : ℝ) : Prop := γ^2*K+U=E
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.projectionConstraint` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；projectionConstraint(E,K,U,γ):Prop定义γ²K+U=E；按context中K=P̄ᵀM⁻¹P̄/2、U=U(Q̄)作标量缩写，与式(3.12)逐项相同。各参数为实数；等式约束本身不需要K>0，故无需在这个Prop定义中增加平方根可解性前提。这里没有声称γ存在、唯一或取非负分支。

### 7. 状态与证明位置

self-contained；`MD.Ch03.projectionConstraint`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1759)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-ProjectionFactor · (3.13) · 印刷p.124 / PDFp.146

### 2. 原文陈述

> and, since $`\overline{\boldsymbol Q}`$ is known, this gives

$$
\gamma=\left(\frac{E-\overline U}{\overline K}\right)^{1/2},\tag{3.13}
$$


> where $`\overline U=U(\overline{\boldsymbol Q})`$ and $`\overline K=\overline{\boldsymbol P}^{T}\boldsymbol M^{-1}\overline{\boldsymbol P}/2`$ are the potential and kinetic energies after a step of the original non-conserving scheme.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def projectionFactor (E K U : ℝ) : ℝ := Real.sqrt ((E-U)/K)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.projectionFactor` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；projectionFactor(E,K,U)=Real.sqrt((E−U)/K)正确编码显示的非负分支。context已写明实际投影使用K>0且E−U≥0。该Lean函数在所有实参数上采用除法及Real.sqrt的总化定义，这里只作为公式定义审校；它没有断言任意实参数都满足projectionConstraint，也不能用总化的K=0值绕过原文的不可定义情形。实际约束解性质被明确分流到ProjectionEnergy，本轮未把那个未提供的定理算作已验证。

### 7. 状态与证明位置

self-contained；`MD.Ch03.projectionFactor`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1762)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-ProjectionEnergy · unnumbered_claim · 印刷p.124 / PDFp.146

### 2. 原文陈述

> We also must assume that $`E-\overline U\ge0`$, which, for a large system, seems the likely situation, since we may suppose $`\overline K+\overline U=\overline E\approx E`$, thus $`E-\overline U\approx\overline K\ge0`$. Thus we assume a system with many degrees of freedom so that all the conditions for the method to be well defined are satisfied.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem projectionEnergy :
  ∀ E K U : ℝ, 0 < K → U ≤ E → projectionConstraint E K U (projectionFactor E K U) := by
  exact MolecularDynamics.Chapter03Review.projectionEnergy_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.projectionEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | K>0且U≤E显式给出，禁止由自由度数目推算。 | [EXTRA] |

[EXTRA] K>0且U≤E显式给出，禁止由自由度数目推算。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开 Ch03.lean:1005–1008 及 Ch03\_deps.txt:3613–3614：projectionConstraint E K U γ 为 γ²K+U=E，projectionFactor 为 sqrt((E−U)/K)。全称 E,K,U 后依次要求 K>0、U≤E，再断言该正平方根满足能量约束，量词和公式正确。K、U对应一步未校正的带横线动能、势能，不是时间平均。K>0排除原文紧邻的零动能障碍，U≤E正是本段条件；都是合理且必要的投影适用资格，未从自由度数量推导。原文的 likely、may suppose 和约等式仅是经验动机，不能作为严格蕴涵；原文保留，不将其静默改写为定理。签名 PASS 限于 context\_notation 明示的投影能量数学核心，并不证明大系统必然满足资格。该声明调用 ReviewProofs 的 projectionEnergy\_proved；依赖4701–4709所示证明用非负性、sqrt平方和代数，无本条 sorry。未编译工程。无 [ERRATUM?] 标注。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.projectionEnergy`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1766)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-KineticZero · unnumbered_claim · 印刷p.124 / PDFp.146

### 2. 原文陈述

> If, in the harmonic oscillator, $`\overline p_{n+1}`$ happens to vanish, then $`\gamma`$ is not defined. We could work around this obstacle by assuming a large number of degrees of freedom, in which case $`\overline K`$ is only zero if all the momenta simultaneously vanish and this situation is, in a realistic model of a molecule, extremely unlikely.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem kineticZero :
  ∀ (n : ℕ) (m : Fin n → ℝ) (p : Position n), positiveMass m → (kinetic m p=0 ↔ p=0) := by
  exact MolecularDynamics.Chapter03Review.kineticZero_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.kineticZero` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量。 | [EXTRA] |

[EXTRA] 正质量。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开依赖 Notation.lean:844：Position n=EuclideanSpace ℝ (Fin n)，零向量即每个动量分量为零；ReviewDefinitions 中 positiveMass m=∀i,0<m i（2948），kinetic m p=(∑i,p i²/m i)/2（3633）。全称有限维数、质量、动量，在所有质量严格正的前提下给出 K=0 当且仅当全部分量为零，忠实且比原文 only zero if 的方向补充了立即成立的逆向。正质量是物理模型的合理资格；若质量为零，Lean 全除法会使非零动量项也为零，故不能删去该条件。维数不需很大，n=0 的空和与唯一零向量也一致。context\_notation 已明确本条只形式化此零动能判据：extremely unlikely 没有概率空间、分布或概率界，不作定量断言；γ在物理公式中分母为零不可用也没有被 Lean 全除法冒充为合法。若要求覆盖所引段落每句，须另设部分定义域资格，但在附件明示数学范围内签名 PASS。调用 kineticZero\_proved；依赖4785–4800为非负有限和逐项归零证明，无本条 sorry，未编译。无 [ERRATUM?]。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.kineticZero`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1772)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-EnergyProjectionRelation · definition · 印刷p.124 / PDFp.146

### 2. 原文陈述

> There are many alternative projection methods which we could use for this purpose, which might alter both the positions and momenta. Modifying the positions means that we will somehow need to solve the equation

$$
H(Q,P)=E,
$$


> where $`Q`$ depends on a parameter or parameters (typically a Lagrange multiplier that is used to maintain the constraint).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def energyProjectionRelation {n : ℕ} (H : Z n → ℝ) (E : ℝ) (z : Z n) : Prop := H z=E
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.energyProjectionRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开 Chapter02Review 的 Q n=Fin n→ℝ、Z n=Q n×Q n（依赖2816–2817），两个分量分别作为位置Q、动量P。Ch03.lean:1023 的 energyProjectionRelation H E z 直接为 H z=E，故对任意 H、E 和候选相点表达原页 H(Q,P)=E，未改变对象、引入额外假设或宣称可解/唯一。原文参数或拉格朗日乘子是生成候选Q的方法说明，不是本能量水平关系必须量化的额外数学条件；本定义可对 z=(Q(λ),P(λ)) 逐个代入，但本身没有形式化求解算法。context\_notation 的存在性、唯一性、几何性质不由定义保证说明准确。定义无 sorry；无需证明。无 [EXTRA] 或 [ERRATUM?]。

### 7. 状态与证明位置

self-contained；`MD.Ch03.energyProjectionRelation`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1777)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

