[上一部分](part02.zh-CN.md) / [目录](../../CH03_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

## 1. MD-3.4-AnalyticDefect · unnumbered_claim · 印刷p.116 / PDFp.138

### 2. 原文陈述

> It is possible to prove (see discussions in [164, 227] for more detail), that for many standard classes of numerical methods, there are real, positive constants $`C,D`$ such that

$$
\|\mathcal G_h(\zeta)-\mathcal F_h^{(k)}(\zeta)\|\le Ch[D(k+1)h]^{k+1},
$$


> giving a precise bound on the magnitude of the difference between the time $`h`$ evolution under the truncated perturbed Hamiltonian and the numerical method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem analyticBEA :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r → AnalyticOnNhd ℝ H D →
    AnalyticOnNhd ℝ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-1:ℝ) 1 ×ˢ D) →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, AnalyticOnNhd ℝ (Hj j) D) ∧
    ∃ C > 0, ∃ A > 0, ∃ δ > 0,
      (∀ k ≥ r, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
        ∀ h ∈ Ioo 0 δ, A*((k+1:ℕ):ℝ)*h ≤ 1 → ∀ z ∈ B,
          truncatedFlow H Hj r k h z (Γ h z) ∧ (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧
          ‖G h z-Γ h z h‖ ≤ C*h*(A*((k+1:ℕ):ℝ)*h)^(k+1)) ∧
      ∃ γ > 0, ∃ κ : ℝ → ℕ, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
        ∀ h ∈ Ioo 0 δ, r ≤ κ h ∧
          ∀ z ∈ B, truncatedFlow H Hj r (κ h) h z (Γ h z) ∧
            ‖G h z-Γ h z h‖ ≤ C*h*Real.exp (-γ/h) := by
  sorry



/-- 修正版，对应原文 MD-3.4-AnalyticDefect。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem analyticBEA_corrected :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r → AnalyticOnNhd ℝ H D →
    AnalyticOnNhd ℝ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-1:ℝ) 1 ×ˢ D) →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, AnalyticOnNhd ℝ (Hj j) D) ∧
    ∃ C > 0, ∃ A > 0, ∃ δ > 0,
      (∀ k ≥ r, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
        ∀ h ∈ Ioo 0 δ, A*((k+1:ℕ):ℝ)*h ≤ 1 → ∀ z ∈ B,
          truncatedFlow H Hj r k h z (Γ h z) ∧ (∀ t ∈ Icc 0 h, Γ h z t ∈ D) ∧
          ‖G h z-Γ h z h‖ ≤ C*h*(A*((k+1:ℕ):ℝ)*h)^(k+1)) ∧
      ∃ γ > 0, ∃ κ : ℝ → ℕ, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
        ∀ h ∈ Ioo 0 δ, r ≤ κ h ∧
          ∀ z ∈ B, truncatedFlow H Hj r (κ h) h z (Γ h z) ∧
            ‖G h z-Γ h z h‖ ≤ C*h*Real.exp (-γ/h) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.analyticBEA`；`MD.Ch03.analyticBEA_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 原文many standard classes未明说正则性；显式H和联合步映射解析、原有smoothSymplecticData及紧域；全阶系数构造与指数截断仍为结论。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 原文many standard classes未明说正则性；显式H和联合步映射解析、原有smoothSymplecticData及紧域；全阶系数构造与指数截断仍为结论。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；已展开Ch03\_deps.txt：SymplecticCoordinates n=(Fin n⊕Fin n)→ℝ；smoothSymplecticData要求r>0、开放凸D、紧凸B⊆D、H光滑、G(0)=id、联合光滑、Jacobian满足AᵀJA=J、B上真实H流以及局部O(|h|^(r+1))阶。Jacobian是实际fderiv矩阵。truncatedFlow要求Γ(0)=z及[0,h]上的实际ODE；Hamiltonian为H+Σ_{j=r}^k h^j Hj。解析假设、统一C/A/δ先于k、真实流估计均明确，且加入A(k+1)h≤1并另给指数截断。未找到缺失定义；原文many standard classes未界定适用类，需数学判断这些解析及域条件是否足以支持此全域解析系数结论；不能仅据名字或sorry判PASS。analyticBEA含sorry，与此语义判定分开。

### 7. 状态与证明位置

incomplete；`MD.Ch03.analyticBEA`：未证（原书疑误不证）；`MD.Ch03.analyticBEA_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1370)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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

## 1. MD-3.5-NoHamiltonianAttractor · unnumbered_claim · 印刷p.126 / PDFp.148

### 2. 原文陈述

> In the first phase, the discrete trajectory appears to be filling in the correct region and without any evidence of nonphysical behavior. The performance is very similar to a Verlet method without projection during this period. In the second phase the system begins to move toward a limit cycle, i.e. an attractive periodic orbit. The presence of such limit cycles is impossible in a Hamiltonian system, thus it is evident that a nonphysical artefact has been introduced by the projection method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem noHamiltonianAttractor :
  ∀ (n : ℕ) (H : SymplecticCoordinates n → ℝ) (Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (orbit B : Set (SymplecticCoordinates n)), ContDiff ℝ 2 H →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (textbookHamiltonianVectorField H (Φ t z)) t) →
    IsCompact orbit → orbit.Nonempty → volume orbit=0 → IsOpen B → 0 < volume B → volume B < ⊤ →
    ¬ (∀ z ∈ B, Tendsto (fun t => Metric.infDist (Φ t z) orbit) atTop (𝓝 0)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.noHamiltonianAttractor` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 明确C²Hamiltonian的全时间真实流、紧零体积周期轨道、开放正有限体积吸引盆；不只给任意一条轨道。 | [EXTRA] |

[EXTRA] 明确C²Hamiltonian的全时间真实流、紧零体积周期轨道、开放正有限体积吸引盆；不只给任意一条轨道。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；noHamiltonianAttractor量化任意维数的C² Hamiltonian和全实时间真实流，具有初值及群律。orbit要求紧、非空、零体积；B要求开放、正且有限体积。完整结论否定对所有z∈B，t→+∞时到orbit的距离趋零，确实排除正体积开放盆的吸引，不是错误地排除一条特殊收敛轨道。该声明甚至不需orbit周期性或不变性，覆盖任何紧零体积目标集，故包含普通周期轨道的情形。C² H给C¹向量场；ODE唯一性使所给全时间解族成为保体积流。取足够小的有限体积轨道邻域，点态吸引和保体积的Fatou估计即产生矛盾；无需把一致吸引偷加为前提。[EXTRA]的正有限盆及紧零体积目标是合理明确化。

### 7. 状态与证明位置

incomplete；`MD.Ch03.noHamiltonianAttractor`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1781)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-LinearContinuousIntegral · unnumbered_claim · 印刷p.123 / PDFp.145

### 2. 原文陈述

> Generalizing this slightly, we could imagine a system of ODEs of the form

$$
\dot{\boldsymbol z}=f(\boldsymbol z),
$$


> such that, for some vector $`\boldsymbol b`$,

$$
\boldsymbol b\cdot f(\boldsymbol z)\equiv0,
$$


> then $`I(\boldsymbol z)=\boldsymbol b\cdot\boldsymbol z`$ is a first integral.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem linearContinuousIntegral :
    ∀ (n : ℕ) (b : Fin n → ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
      (∀ z, ∑ i, b i*f z i = 0) →
      (∀ t, HasDerivAt γ (f (γ t)) t) →
      ∀ t, (∑ i, b i*γ t i) = ∑ i, b i*γ 0 i := by
  intro n b f γ hbf hγ t
  have hd : ∀ s, HasDerivAt (fun t => ∑ i, b i*γ t i) 0 s := by
    intro s
    simpa only [hbf] using HasDerivAt.fun_sum
      (u := Finset.univ) (fun i _ => ((hasDerivAt_pi.mp (hγ s)) i).const_mul (b i))
  exact is_const_of_deriv_eq_zero (fun s => (hd s).differentiableAt)
    (fun s => (hd s).deriv) t 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.linearContinuousIntegral` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实全时间轨道导数资格显式；不宣称任意f有全时间解。 | [EXTRA] |

[EXTRA] 真实全时间轨道导数资格显式；不宣称任意f有全时间解。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开依赖2816的 Q n=Fin n→ℝ，b为实有限向量，∑i b i*f z i 正是 b·f(z)。量词先全称 n,b,f,轨道γ，再假设∀z 的恒零点积和∀t 的真实轨道导数γ′(t)=f(γ(t))，最终对每个实t断言 b·γ(t)=b·γ(0)。这给出连续轨道上的完整 first integral，而不是仅 Euler 一步或某个离散格式。无需f额外光滑性：已有每时刻可微解和零点积，复合线性函数导数恒零即可。全时间轨道条件明确且合理，未断言所有f均有全局解；原文任何连通局部解区间上的版本是相应局部推广，本签名取已声明的全时间范围。所有数学结论子句在此范围内保留；相邻 Euler/RK 保持性质不属本条。Ch03.lean:1043–1049 所示证明以有限和求导及零导数推出常数，无本条 sorry；本次只读审计未编译工程。无 [ERRATUM?]。

### 7. 状态与证明位置

self-contained；`MD.Ch03.linearContinuousIntegral`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1792)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6-HamiltonianFlowStructures · unnumbered_claim · 印刷p.127–128 / PDFp.149–150

### 2. 原文陈述

> The flow of a Hamiltonian system of the form $`H=p^TM^{-1}p/2+U(q)`$ will preserve all of the following:
> 1. The symplectic two-form $`\mathrm dq\wedge\mathrm dp`$.
> 2. The Hamiltonian (i.e., the energy) $`H`$.
> 3. The volume in phase space (as the vector field is divergence free).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianFlowStructures :
  ∀ n (H : SymplecticCoordinates n → ℝ) D Ω
    (Φ : ℝ × SymplecticCoordinates n → SymplecticCoordinates n) τ,
    0 < τ → ContDiffOn ℝ 2 H D → localFlowC1 (textbookHamiltonianVectorField H) D Ω Φ τ →
    (∀ t ∈ Ioo 0 τ, ∀ z ∈ Ω,
      HasDerivAt (fun s => textbookJacobian (fun y => Φ (s,y)) z)
        (textbookJ n*textbookHamiltonianHessian H (Φ (t,z))*textbookJacobian (fun y => Φ (t,y)) z) t) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, IsTextbookSymplectic (textbookJacobian (fun y => Φ (t,y)) z)) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, (textbookJacobian (fun y => Φ (t,y)) z).det = 1) ∧
    (∀ t ∈ Icc 0 τ, ∀ z ∈ Ω, H (Φ (t,z))=H z) ∧
    (∀ t ∈ Icc 0 τ, ∀ S, MeasurableSet S → S ⊆ Ω →
      volume ((fun z => Φ (t,z)) '' S) = volume S) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hamiltonianFlowStructures` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Hamiltonian在开放域C²；真实localFlowC1的初值、ODE与局部定义域资格，未假设显式反步。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补原文Hamiltonian能量沿流守恒，保留变分/辛/体积全部结论；localFlowC1实际资格无显式反步，撤销旧EXTRA对此的过度描述，时间反演由3.6.1处理。 | [EXTRA] |

[EXTRA] Hamiltonian在开放域C²；真实localFlowC1的初值、ODE与局部定义域资格，未假设显式反步。；[EXTRA] 补原文Hamiltonian能量沿流守恒，保留变分/辛/体积全部结论；localFlowC1实际资格无显式反步，撤销旧EXTRA对此的过度描述，时间反演由3.6.1处理。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；逐项展开localFlowC1、J、Jacobian、Hessian与Hamiltonian向量场后，声明量化开放D、Ω⊆D、τ>0、H在D上C²及真实C¹局部流。完整结论有五组：内部时间上的Jacobian变分方程；闭时间区间上的辛性；det=1；H(Φ(t,z))=H z；以及每个可测S⊆Ω的像集合体积守恒。能量结论已经明确在第四个合取中，不能沿用旧注释说它缺失。初值与ODE资格没有预先供应辛性、能量或体积结论；虽然未假设反步公式，ODE局部唯一性仍给固定时刻的单射性。任意C² H是对原机械型H的合理推广；Ω的开放性使各时刻空间全导数有意义，变分式只取内部时间，端点保留空间辛性等结论，域与量词无缺漏。

### 7. 状态与证明位置

incomplete；`MD.Ch03.hamiltonianFlowStructures`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1808)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6-VolumeNotSymplectic · unnumbered_claim · 印刷p.128 / PDFp.150

### 2. 原文陈述

> The phase volume conservation can be seen as a consequence of the symplectic property, but it is a weaker condition. It is possible to construct methods that preserve volume but which are not symplectic, and we can build methods that exactly conserve the energy (as we shall show below).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem volumeNotSymplectic :
  ∃ G : SymplecticCoordinates 2 → SymplecticCoordinates 2,
    ContDiff ℝ 1 G ∧ Function.Injective G ∧
    (∀ S, MeasurableSet S → volume (G '' S)=volume S) ∧ (∀ z, (textbookJacobian G z).det=1) ∧ ¬ IsTextbookSymplecticMap G := by
  sorry

theorem volumeNotSymplectic_symplectic_volume (n : ℕ)
    (G : SymplecticCoordinates n → SymplecticCoordinates n)
    (_hG : IsTextbookSymplecticMap G) (_hinj : Function.Injective G) :
    ∀ S, MeasurableSet S → volume (G '' S)=volume S := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 辛C¹全局单射映射的真实体积保持及保体积非辛见证；精确能量方法构造由MD-3.5-ProjectionEnergy承担，Hamiltonian流实例由MD-3.6-HamiltonianFlowStructures承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.volumeNotSymplectic`；`MD.Ch03.volumeNotSymplectic_symplectic_volume` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补真实可测集合体积保存及单射，保留det=1和非辛见证；其余原句明确跨条映射HamiltonianFlowStructures及ProjectionEnergy，不静默删原文。 | [EXTRA] |

[EXTRA] [EXTRA] 补真实可测集合体积保存及单射，保留det=1和非辛见证；其余原句明确跨条映射HamiltonianFlowStructures及ProjectionEnergy，不静默删原文。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；两个声明全部核对。volumeNotSymplectic在SymplecticCoordinates 2即四维实空间选C¹单射G，明确要求所有可测集合的真实像体积相同、各点det=1且G不辛；它不只是一个行列式条件。第二个volumeNotSymplectic\_symplectic\_volume对任意n的全局C¹辛单射G给出全部可测集合的像体积守恒，确已覆盖“辛性蕴含体积守恒”。单射性排除重数造成的全局像体积问题，是已明示scope内的合理资格。四维足以提供严格较弱见证；例如按(q₁,q₂,p₁,p₂)取diag(2,1,1,1/2)，其det为1且全局保体积，但两个辛配对缩放分别为2与1/2，故不辛。旧context称仅有det=1且未覆盖其它结论，与当前两个完整签名不符，须更正元数据；不构成现行Lean签名失败。

### 7. 状态与证明位置

incomplete；`MD.Ch03.volumeNotSymplectic`：未证（缺大型理论）；`MD.Ch03.volumeNotSymplectic_symplectic_volume`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1824)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-LinearInvolution · definition · 印刷p.128 / PDFp.150

### 2. 原文陈述

> By an involution we mean a linear mapping $`\boldsymbol z\mapsto R\boldsymbol z`$ where $`R^2=I`$, i.e. $`R`$ is its own inverse.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def linearInvolution {n : ℕ} (R : Q n →L[ℝ] Q n) : Prop := R.comp R = ContinuousLinearMap.id ℝ (Q n)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.linearInvolution` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt：Chapter02/ReviewDefinitions.lean 中 Q n=Fin n→ℝ、Z n=Q n×Q n；这些是实有限维坐标。 Ch03.lean:1073 的 R 是实连续线性自映射，R.comp R=id 即 ∀z,R(Rz)=z。有限维线性自动连续，未添加实质限制。无需 Rᵀ=R；例如 [[1,1],[0,-1]] 是非对称involution。定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch03.linearInvolution`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1837)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-ReversedFieldPrinted · definition · 印刷p.128 / PDFp.150

### 2. 原文陈述

> Given the involution $`R`$ we define the time reversal of the vector field $`f`$ with respect to $`R`$ by

$$
\widetilde f(\boldsymbol z)=-R^Tf(R\boldsymbol z).
$$


> When a vector field is its own reversal we say that it is a time-reversible vector field.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def reversedField {n : ℕ} (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (z : Q n) : Q n :=
  -(R.transpose.mulVec (f (R.mulVec z)))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.reversedField` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt：Chapter02/ReviewDefinitions.lean 中 Q n=Fin n→ℝ、Z n=Q n×Q n；这些是实有限维坐标。 依赖 Chapter03/ReviewDefinitions.lean:3617 与本地1077均展开为 −(R.transpose.mulVec(f(R.mulVec z)))，即原书字面−Rᵀf(Rz)。定义容许一般矩阵是定义域扩展，应用到R²=I时完全相符；“自身反转”解释为∀z,f z=reversedField R f z，不是该函数定义本身的额外结论。[ERRATUM?]成立：轨道链式法则给−Rf(Rz)，一般involution不等于其转置；不应静默替换字面定义。定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch03.reversedField`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1841)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-MomentumReversal · definition · 印刷p.128 / PDFp.150

### 2. 原文陈述

> Let $`H(q,p)=p^TM^{-1}p/2+U(q)`$ be the Hamiltonian for a system of $`N_c`$ configuration variables. Define the $`2N_c\times2N_c`$ matrix $`R`$ by

$$
R=\begin{bmatrix}I&0\\0&-I\end{bmatrix}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def momentumReversal {n : ℕ} (z : Z n) : Z n := (z.1,-z.2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.momentumReversal` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt：Chapter02/ReviewDefinitions.lean 中 Q n=Fin n→ℝ、Z n=Q n×Q n；这些是实有限维坐标。 momentumReversal z=(z.1,−z.2)，正是块矩阵diag(I,−I)的作用。依赖中的 SymplecticCoordinates n=(Fin n⊕Fin n)→ℝ，pack z=Sum.elim z.1 z.2，canonicalReversal保持inl坐标并取反inr坐标，所以context等价坐标说法成立。H仅说明使用环境，定义R无需m、U参数或假设。定义无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch03.momentumReversal`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1845)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-MechanicalReversal · unnumbered_claim · 印刷p.128 / PDFp.150

### 2. 原文陈述

> The vector fields involved are

$$
f=\begin{bmatrix}M^{-1}p\\-\nabla U(q)\end{bmatrix},\qquad\widetilde f=-Rf(Rz)=-\begin{bmatrix}-M^{-1}p\\\nabla U(q)\end{bmatrix},
$$


> which are clearly equal. Therefore the molecular dynamics Hamiltonian system is time-reversible.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mechanicalReversalPrinted :
    ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (z : Z n),
      (-momentumReversal (mechanicalField m (fun q => -grad U q) (momentumReversal z)) =
        -(-invMass m z.2, grad U z.1)) ∧
      (-(-invMass m z.2, grad U z.1) = mechanicalField m (fun q => -grad U q) z) ∧
      mechanicalField m (fun q => -grad U q) (momentumReversal z) =
        -momentumReversal (mechanicalField m (fun q => -grad U q) z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.mechanicalReversalPrinted` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 按原页外部负号修复先前转录误读，两行均为−(−M⁻¹p,∇U)，原书此式无误；先前本条ERRATUM判断撤销，第三反演合取保留。 | [EXTRA] |

[EXTRA] [EXTRA] 按原页外部负号修复先前转录误读，两行均为−(−M⁻¹p,∇U)，原书此式无误；先前本条ERRATUM判断撤销，第三反演合取保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；mechanicalReversalPrinted的三个合取全部核对：−R f(Rz)等于带外负号的列向量；该列向量等于f(z)；并有f(Rz)=−R f(z)。momentumReversal(q,p)=(q,−p)，mechanicalField=(invMass m p,−grad U q)，invMass逐坐标线性；展开后所有负号一致。任意实质量参数和任意U是这个代数恒等式的合法推广；不需要为了梯度的物理解释而把不必要的光滑或质量正性加入代数结论。[EXTRA]所述外负号修复确已落实。

### 7. 状态与证明位置

incomplete；`MD.Ch03.mechanicalReversalPrinted`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1850)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-ReversedTrajectoryPrinted · unnumbered_claim · 印刷p.129 / PDFp.151

### 2. 原文陈述

> For the system $`\mathrm dz/\mathrm dt=f(\boldsymbol z)`$, a coordinate transformation $`\boldsymbol z\mapsto\widetilde{\boldsymbol z}=R\boldsymbol z`$ results in

$$
\frac{\mathrm d\widetilde{\boldsymbol z}}{\mathrm dt}=R\frac{\mathrm d\boldsymbol z}{\mathrm dt}=Rf(R^{-1}\widetilde{\boldsymbol z})=Rf(R\widetilde{\boldsymbol z}),
$$


> since $`R^{-1}=R`$. A change of time $`t\mapsto\tau=-t`$ results in

$$
\frac{\mathrm d\boldsymbol z}{\mathrm d\tau}=\frac{\mathrm dt}{\mathrm d\tau}\frac{\mathrm d\boldsymbol z}{\mathrm dt}=-f(\boldsymbol z).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem reversedTrajectoryPrinted :
  ∀ (n : ℕ) (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
    R*R=1 → (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (fun s => R.mulVec (γ (-s)))
      (-R.mulVec (f (γ (-t)))) t := by
  sorry

theorem reversedTrajectoryPrinted_coordinateChange (n : ℕ)
    (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (γ : ℝ → Q n)
    (_hR : R*R=1) (_hγ : ∀ t, HasDerivAt γ (f (γ t)) t) :
    ∀ t, HasDerivAt (fun s ↦ R.mulVec (γ s))
      (R.mulVec (f (R.mulVec (R.mulVec (γ t))))) t := by
  sorry

theorem reversedTrajectoryPrinted_timeChange (n : ℕ) (f : Q n → Q n) (γ : ℝ → Q n)
    (_hγ : ∀ t, HasDerivAt γ (f (γ t)) t) :
    ∀ t, HasDerivAt (fun s ↦ γ (-s)) (-f (γ (-t))) t := by
  sorry



/-- 修正版，对应原文 MD-3.6.1-ReversedTrajectoryPrinted。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem reversedTrajectoryPrinted_corrected :
  ∀ (n : ℕ) (R : Matrix (Fin n) (Fin n) ℝ) (f : Q n → Q n) (γ : ℝ → Q n),
    R*R=1 → (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∀ t, HasDerivAt (fun s => R.mulVec (γ (-s)))
      (-R.mulVec (f (γ (-t)))) t := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.reversedTrajectoryPrinted`；`MD.Ch03.reversedTrajectoryPrinted_coordinateChange`；`MD.Ch03.reversedTrajectoryPrinted_timeChange`；`MD.Ch03.reversedTrajectoryPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 按PDF151真实链式法则写−R f(γ(−t))，另列纯坐标变化Rf(Rz̃)及纯时间反向−f；不以转置reversedField偷换原链式右端。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA] 按PDF151真实链式法则写−R f(γ(−t))，另列纯坐标变化Rf(Rz̃)及纯时间反向−f；不以转置reversedField偷换原链式右端。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；同source\_id三条声明全部正确且忠实于当前所录原页129：主声明给Rγ(−t)的导数−Rf(γ(−t))；coordinateChange给Rγ(t)的导数Rf(R(Rγ(t)))，R²=I使其等于Rf(γ(t))，正是Rf(Rz̃)；timeChange给γ(−t)的导数−f(γ(−t))。R是任意实方阵且R²=I，γ在所有实时间满足真实ODE；主结论并未声称变换轨道仍解原f，也未使用Rᵀ或要求R对称。因此Printed版本没有被换成错误的转置反转版本，[EXTRA]补出的分离链式规则已存在。PASS仅就本条原文链式规则及三个当前签名；p128定义争议另留NEEDS\_HUMAN。

### 7. 状态与证明位置

incomplete；`MD.Ch03.reversedTrajectoryPrinted`：未证（原书疑误不证）；`MD.Ch03.reversedTrajectoryPrinted_coordinateChange`：未证（原书疑误不证）；`MD.Ch03.reversedTrajectoryPrinted_timeChange`：未证（原书疑误不证）；`MD.Ch03.reversedTrajectoryPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1864)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-ReversedTrajectory · unnumbered_claim · 印刷p.129 / PDFp.151

### 2. 原文陈述

> In other words, for a reversible vector field, the coordinate transformation $`\boldsymbol z\mapsto R\boldsymbol z`$ is equivalent to the change of time $`t\mapsto-t`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem reversedTrajectory :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (γ : ℝ → Q n),
    linearInvolution R → (∀ i j, R (Pi.single j 1) i = R (Pi.single i 1) j) → (∀ z, f (R z)=-R (f z)) →
    (∀ t, HasDerivAt γ (f (γ t)) t) → ∀ t,
      HasDerivAt (fun s => R (γ (-s))) (f (R (γ (-t)))) t := by
  sorry



/-- 修正版，对应原文 MD-3.6.1-ReversedTrajectory。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem reversedTrajectory_corrected :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (γ : ℝ → Q n),
    linearInvolution R → (∀ i j, R (Pi.single j 1) i = R (Pi.single i 1) j) → (∀ z, f (R z)=-R (f z)) →
    (∀ t, HasDerivAt γ (f (γ t)) t) → ∀ t,
      HasDerivAt (fun s => R (γ (-s))) (f (R (γ (-t)))) t := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.reversedTrajectory`；`MD.Ch03.reversedTrajectory_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]采用正确f(Rz)=−Rf(z)而非一般Rᵀ字面定义；每个实t均有真实γ导数。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补R的坐标矩阵对称资格，与R²=id合起来使Rᵀ=R=R⁻¹，现有经典反演条件才与原字面转置定义等价；该限制显式EXTRA。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]采用正确f(Rz)=−Rf(z)而非一般Rᵀ字面定义；每个实t均有真实γ导数。；[EXTRA] 补R的坐标矩阵对称资格，与R²=id合起来使Rᵀ=R=R⁻¹，现有经典反演条件才与原字面转置定义等价；该限制显式EXTRA。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；reversedTrajectory量化任意n、连续线性R、f和全实时间解γ；要求R²=id，另明确加入全部基矩阵元素R\_ij=R\_ji的对称资格，以及f(Rz)=−Rf(z)。结论Rγ(−t)仍满足原f的ODE；由链式法则导数=−Rf(γ(−t))=f(Rγ(−t))，数学正确。坐标对称资格不是隐藏的，它恰使Rᵀ=R=R⁻¹，从而可与原印反转定义兼容；这是一条合理但严格受限的修复，并未证明原书对任意非对称involution的宽泛句子。PASS针对已显式标注[EXTRA]的受限当前签名，原书一般性问题保留NEEDS\_HUMAN。

### 7. 状态与证明位置

incomplete；`MD.Ch03.reversedTrajectory`：未证（原书疑误不证）；`MD.Ch03.reversedTrajectory_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1900)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-FlowReversal · unnumbered_claim · 印刷p.129 / PDFp.151

### 2. 原文陈述

> From this we see that if we start from a point $`z_0`$ and integrate forward in time (i.e apply $`\mathcal F_t`$) then apply the involution $`R`$, we get the exact same result as if we start from $`\widetilde z(0)=Rz_0`$ and integrate backward in time (i.e apply $`\mathcal F_{-t}`$). In sum, since $`z_0`$ is an arbitrary point,

$$
\mathcal F_{-t}(Rz)=R\mathcal F_t(z).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem flowReversal :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) →
    ∀ t z, Φ (-t) (R z)=R (Φ t z) := by
  sorry



/-- 修正版，对应原文 MD-3.6.2-FlowReversal。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem flowReversal_corrected :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) →
    ∀ t z, Φ (-t) (R z)=R (Φ t z) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.flowReversal`；`MD.Ch03.flowReversal_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正确R反转、C¹场和全实时间真实流；不把所需反转等式藏进流假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 正确R反转、C¹场和全实时间真实流；不把所需反转等式藏进流假设。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；flowReversal作为经典修正版数学正确：任意n与连续线性involution R、全局C¹ f，显式要求f(Rz)=−Rf(z)，Φ对每个初值在全部实时间有正确初值和ODE导数，结论对所有t,z为Φ(−t,Rz)=RΦ(t,z)。C¹场保证唯一性；没有把所需反转等式塞进Φ的资格，也不需预先假设群律。对应原文的唯一未决点是“reversible”的含义：当前关系采用正确R版，而p128字面定义用Rᵀ；仅involution不使二者等价，且本条未像reversedTrajectory那样补对称R资格。因此不给数学正确的经典定理判FAIL，但原书与当前签名之间的定义对应仍需人工确认；NEEDS\_HUMAN不是sorry导致的。

### 7. 状态与证明位置

incomplete；`MD.Ch03.flowReversal`：未证（原书疑误不证）；`MD.Ch03.flowReversal_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1924)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-FlowReversalIdentity · (3.14) · 印刷p.129 / PDFp.151

### 2. 原文陈述

> For the flow map, $`\mathcal F_{-t}=\mathcal F_t^{-1}`$ so we can recast the identity as

$$
R\circ\mathcal F_t\circ R\circ\mathcal F_t=\mathrm{Id},\tag{3.14}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem flowReversalIdentity :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) → ∀ t z, R (Φ t (R (Φ t z)))=z := by
  sorry



/-- 修正版，对应原文 MD-3.6.2-FlowReversalIdentity。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem flowReversalIdentity_corrected :
  ∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) (Φ : ℝ → Q n → Q n),
    linearInvolution R → ContDiff ℝ 1 f → (∀ z, f (R z)=-R (f z)) →
    (∀ z, Φ 0 z=z) → (∀ s t z, Φ (s+t) z=Φ s (Φ t z)) →
    (∀ z t, HasDerivAt (fun s => Φ s z) (f (Φ t z)) t) → ∀ t z, R (Φ t (R (Φ t z)))=z := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.flowReversalIdentity`；`MD.Ch03.flowReversalIdentity_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正确R反转、C¹场、实际全时间流、群性质；不供应结论。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 正确R反转、C¹场、实际全时间流、群性质；不供应结论。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；flowReversalIdentity逐项包含线性involution、C¹向量场、经典反转条件、Φ初值、全实时间ODE和群律，完整结论对任意t,z给R(Φ t(R(Φ t z)))=z。群律加初值确实给Φ(−t)为双侧逆；结合经典反转得到(3.14)，无循环假设。和上一条一样，这个经典版本正确，但原印p128的Rᵀ定义与当前f(Rz)=−Rf(z)在一般R下不等价；本条没有对称性限定。NEEDS\_HUMAN用于确认原文到当前声明的勘误解释，不否定所给条件下的代数/ODE结论。

### 7. 状态与证明位置

incomplete；`MD.Ch03.flowReversalIdentity`：未证（原书疑误不证）；`MD.Ch03.flowReversalIdentity_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1948)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-ReversibleMethod · (3.15) · 印刷p.130 / PDFp.152

### 2. 原文陈述

> It does not automatically follow that a symmetric numerical method is time-reversible, i.e. satisfies a relation inspired by (3.14), namely

$$
R\circ\mathcal G_h\circ R\circ\mathcal G_h=\mathrm{Id}.\tag{3.15}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def reversibleMethod {E : Type*} (R : E → E) (G : ℝ → E → E) : Prop := ∀ h z, R (G h (R (G h z)))=z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.reversibleMethod` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；Ch03.lean 和依赖 Chapter03/ReviewDefinitions.lean 中 reversibleMethod 均逐字展开为 ∀h z, R(G h(R(G h z)))=z，即(3.15)在每一步长、每个状态的点态等式。E 的类型泛化不改变定义含义；R 作为外部给定 involution 的语境参数，定义本身无须再断言 R²=id。该 def 表达“time-reversible”的定义性关系；原句对 symmetric 不自动推出 reversible 的否定说明不是本 def 的定理结论。无 [EXTRA]、无 [ERRATUM?]，定义体无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch03.reversibleMethod`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1970)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-SymmetricMethod · definition · 印刷p.130 / PDFp.152

### 2. 原文陈述

> Recall from the previous chapter that a numerical method $`\mathcal G_h`$ was said to be symmetric if it satisfied

$$
\mathcal G_{-h}=\mathcal G_h^{-1}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def symmetricMethod {E : Type*} (G : ℝ → Equiv.Perm E) : Prop := ∀ h, G (-h)=(G h).symm
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.symmetricMethod` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；symmetricMethod对任意类型E，以G:ℝ→Equiv.Perm E显式保证各一步映射可逆，再对所有实h规定G(−h)=(G h).symm。右端是实际逆置换，而非任意候选反步或单侧逆；对象、步长符号和等号方向均与定义相同，不额外宣称R时间可逆性。

### 7. 状态与证明位置

self-contained；`MD.Ch03.symmetricMethod`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1973)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-AffineInvariant · Definition 3.1 · 印刷p.130 / PDFp.152

### 2. 原文陈述

> Definition 3.1 (Affine Invariance) Let

$$
\frac{\mathrm d\boldsymbol z}{\mathrm dt}=f(\boldsymbol z)\tag{3.16}
$$


> be a given ordinary differential equation. The transformation $`\widetilde{\boldsymbol z}=A\boldsymbol z`$, where $`A`$ is a non-singular square matrix, results in the modified differential equation

$$
\frac{\mathrm d\boldsymbol z}{\mathrm dt}=Af(A^{-1}\widetilde{\boldsymbol z}).\tag{3.17}
$$


> Let $`z_0,z_1,\ldots`$ be a sequence of points obtained by application of the numerical method $`\mathcal G_h`$ to (3.16). If the same method, when applied to (3.17) produces the set of points $`Az_0,Az_1,\ldots`$, then we say that the numerical method is invariant with respect to the transformation $`\widetilde{\boldsymbol z}=Az`$. An affine invariant method is one which is invariant under any such transformation.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def affineInvariant {n : ℕ} (G : (Q n → Q n) → ℝ → Q n → Q n) : Prop :=
  ∀ (A : Q n ≃L[ℝ] Q n) f h z, G (transportedField A f) h (A z) = A (G f h z)



/-- 修正版，对应原文 MD-3.6.2-AffineInvariant。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def affineInvariant_corrected {n : ℕ} (G : (Q n → Q n) → ℝ → Q n → Q n) : Prop :=
  ∀ (A : Q n ≃L[ℝ] Q n) f h z, G (transportedField A f) h (A z) = A (G f h z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.affineInvariant`；`MD.Ch03.affineInvariant_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；affineInvariant量化固定有限维实空间上的全部连续线性同构A、向量场f、实步长h和初值z；transportedField A f(z)=A(f(A⁻¹z))。完整关系G_{A f A⁻¹}(h,Az)=A(G\_f(h,z))正是变换初值后每一步等变，归纳即得所述序列。≃L准确表示有限维非奇异方阵；未偷加平移，也未把A限制成正交矩阵。PASS针对上下文已明示的变换坐标语义及当前方法定义；原印(3.17)左端记号疑误在json\_review保留NEEDS\_HUMAN。

### 7. 状态与证明位置

self-contained；`MD.Ch03.affineInvariant`：定义；`MD.Ch03.affineInvariant_corrected`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1978)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-SymmetricAffineReversible · unnumbered_claim · 印刷p.130 / PDFp.152

### 2. 原文陈述

> If a differential equation is time-reversible with respect to the involution $`R`$, and we apply a method which is affine invariant and symmetric, then the method will be time-reversible (3.15).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symmetricAffineReversible :
  ∀ (n : ℕ) (R : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (G : (Q n → Q n) → ℝ → Q n → Q n),
    (∀ z, R (R z)=z) → (∀ z, f (R z)=-R (f z)) → affineInvariant G →
    (∀ h z, G (fun x => -f x) h z=G f (-h) z) →
    (∀ h z, G f (-h) (G f h z)=z) → reversibleMethod R (G f) := by
  sorry



/-- 修正版，对应原文 MD-3.6.2-SymmetricAffineReversible。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem symmetricAffineReversible_corrected :
  ∀ (n : ℕ) (R : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (G : (Q n → Q n) → ℝ → Q n → Q n),
    (∀ z, R (R z)=z) → (∀ z, f (R z)=-R (f z)) → affineInvariant G →
    (∀ h z, G (fun x => -f x) h z=G f (-h) z) →
    (∀ h z, G f (-h) (G f h z)=z) → reversibleMethod R (G f) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.symmetricAffineReversible`；`MD.Ch03.symmetricAffineReversible_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]G_{−f}(h)=G\_f(−h)显式给步长符号相容性；原文没列这项，任意抽象方法仅线性等变与对称未必足够。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 明确本条是原印省略方法类资格后的受限修复；符号/时间尺度相容仅要求固定f，不对所有无关g全称。保留原书疑误说明。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]G_{−f}(h)=G\_f(−h)显式给步长符号相容性；原文没列这项，任意抽象方法仅线性等变与对称未必足够。；[EXTRA] 明确本条是原印省略方法类资格后的受限修复；符号/时间尺度相容仅要求固定f，不对所有无关g全称。保留原书疑误说明。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；symmetricAffineReversible的全部条件已核对：R为连续线性同构且平方为id；f有经典R反转；方法对全部线性同构等变；另只对本固定f显式要求G_{−f}(h)=G\_f(−h)；并要求所有h的反步复合G\_f(−h)∘G\_f(h)=id。因为量化所有h，最后一个条件同时给另一方向的逆关系，不必再把G编码为Perm。对R使用affineInvariant，利用transportedField R f=−f及变号相容性，得到R∘G\_f(h)∘R=G\_f(−h)，再复合G\_f(h)即为reversibleMethod。完整结论∀h,z,R(G\_f(h,R(G\_f(h,z))))=z与(3.15)一致；不存在把所需结论作为假设的问题。[EXTRA]变号相容性是实质新增且已明示的合理修复，不能把当前受限正确版本当作原句对所有抽象方法已成立。

### 7. 状态与证明位置

incomplete；`MD.Ch03.symmetricAffineReversible`：未证（原书疑误不证）；`MD.Ch03.symmetricAffineReversible_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1992)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-RKAffine · unnumbered_claim · 印刷p.130 / PDFp.152

### 2. 原文陈述

> All Runge-Kutta methods and Partitioned Runge-Kutta methods are affine invariant, thus, if they are also symmetric, then they preserve time-reversal symmetry.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rkAffine :
  ∀ (n s : ℕ) (L : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ) h z w F,
    rungeKuttaRelation f A b h z w F →
      rungeKuttaRelation (transportedField L f) A b h (L z) (L w) (fun i => L (F i)) := by
  exact MolecularDynamics.Chapter03Review.rkAffine_proved



/-- 修正版，对应原文 MD-3.6.2-RKAffine。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem rkAffine_corrected :
  ∀ (n s : ℕ) (L : Q n ≃L[ℝ] Q n) (f : Q n → Q n)
    (A : Matrix (Fin s) (Fin s) ℝ) (b : Fin s → ℝ) h z w F,
    rungeKuttaRelation f A b h z w F →
      rungeKuttaRelation (transportedField L f) A b h (L z) (L w) (fun i => L (F i)) := by
  exact MolecularDynamics.Chapter03Review.rkAffine_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 普通RK关系的线性坐标变换等变性子句；PRK保持分区的修复子句见MD-3.6.2-PartitionedAffine，时间反演推论见MD-3.6.2-SymmetricAffineReversible。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.rkAffine`；`MD.Ch03.rkAffine_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 仅承担普通RK阶段/更新的线性等变；PRK分区修复及对称方法反演另映射PartitionedAffine、SymmetricAffineReversible，原文整句保留。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA] 仅承担普通RK阶段/更新的线性等变；PRK分区修复及对称方法反演另映射PartitionedAffine、SymmetricAffineReversible，原文整句保留。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；普通RK子句签名正确：n、s允许零维/零阶段，L为实连续线性自同构；任意f、实系数A,b及实h，给定完整阶段解F与终点w，结论正是运输场L∘f∘L⁻¹下运输阶段、初末状态满足同一关系。没有偷加求解唯一性，也没有断言存在数值单值映射。原页定义所谓affine invariance实际只写非奇异线性变换，故本条不因缺平移判FAIL。[EXTRA]/scope明确只覆盖普通RK，未覆盖PRK和时间反演推论。原句对任意混合q,p变换的PRK全称过强，且时间反演仍须原微分方程对R可逆；这些原书资格疑点须保留。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.rkAffine`：已证；`MD.Ch03.rkAffine_corrected`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2018)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-PartitionedAffinePrinted · unnumbered_claim · 印刷p.130 / PDFp.152

### 2. 原文陈述

> All Runge-Kutta methods and Partitioned Runge-Kutta methods are affine invariant, thus, if they are also symmetric, then they preserve time-reversal symmetry.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem partitionedAffinePrinted :
  ∀ (n s : ℕ) (L : Z n ≃L[ℝ] Z n) (f : Z n → Z n)
    (Aq Ap : Matrix (Fin s) (Fin s) ℝ) (bq bp : Fin s → ℝ) h z w F,
    partitionedRKRelation f Aq Ap bq bp h z w F →
      partitionedRKRelation (fun x => L (f (L.symm x))) Aq Ap bq bp h (L z) (L w) (fun i => L (F i)) := by
  sorry



/-- 修正版，对应原文 MD-3.6.2-PartitionedAffinePrinted。改动：默认两套PRK表相同退化为普通相空间RK，才允许任意混合可逆线性变换；保持分区的更一般版本独立保留。 -/
```

独立修正版：

```lean
theorem partitionedAffinePrinted_corrected :
  ∀ (n s : ℕ) (L : Z n ≃L[ℝ] Z n) (f : Z n → Z n)
    (Aq Ap : Matrix (Fin s) (Fin s) ℝ) (bq bp : Fin s → ℝ) h z w F,
    Aq=Ap → bq=bp → partitionedRKRelation f Aq Ap bq bp h z w F →
      partitionedRKRelation (fun x => L (f (L.symm x))) Aq Ap bq bp h (L z) (L w) (fun i => L (F i)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.partitionedAffinePrinted`；`MD.Ch03.partitionedAffinePrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 默认两套PRK表相同退化为普通相空间RK，才允许任意混合可逆线性变换；保持分区的更一般版本独立保留。 | [EXTRA] |

[EXTRA] [ERRATUM?] 默认两套PRK表相同退化为普通相空间RK，才允许任意混合可逆线性变换；保持分区的更一般版本独立保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖展开：Ch03\_deps.txt 的 MolecularDynamics/Chapter02/ReviewDefinitions.lean 定义 Q n = Fin n → ℝ、Z n = Q n × Q n；Chapter03/ReviewDefinitions.lean 定义 linearInvolution R 为 R.comp R = ContinuousLinearMap.id ℝ (Q n)，即 ∀z, R(Rz)=z。 partitionedRKRelation 展开为 (∀i, F\_i=f(z\_q+h∑_j Aq\_ij(F\_j)_q, z\_p+h∑_j Ap\_ij(F\_j)_p)) ∧ w=(z\_q+h∑_i bq\_i(F\_i)_q,z\_p+h∑_i bp\_i(F\_i)_p)。签名全称允许独立 Aq,Ap,bq,bp 和任意混合 q,p 的连续线性等价 L，并用真运输场 x↦L(f(L⁻¹x))。因为分区不同表格的求和不与任意混合 L 交换，原文的全线性 PRK 主张和这个签名都被反例否定，[ERRATUM?] 成立，不需人工判断或缺失定义。签名也未覆盖原句对称时保持时间反转的后半句。声明体为 sorry，此处 FAIL 来自实际反例及遗漏，非来自 sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch03.partitionedAffinePrinted`：未证（原书疑误不证）；`MD.Ch03.partitionedAffinePrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2039)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-PartitionedAffine · unnumbered_claim · 印刷p.130 / PDFp.152

### 2. 原文陈述

> All Runge-Kutta methods and Partitioned Runge-Kutta methods are affine invariant, thus, if they are also symmetric, then they preserve time-reversal symmetry.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem partitionedAffine :
  ∀ (n s : ℕ) (Lq Lp : Q n ≃L[ℝ] Q n) (fq fp : Z n → Q n)
    (Aq Ap : Matrix (Fin s) (Fin s) ℝ) (bq bp : Fin s → ℝ) (h : ℝ) (z w : Z n) (Fq Fp : Fin s → Q n),
    (∀ i, Fq i=fq (z.1+h • ∑ j, Aq i j • Fq j,z.2+h • ∑ j, Ap i j • Fp j)) →
    (∀ i, Fp i=fp (z.1+h • ∑ j, Aq i j • Fq j,z.2+h • ∑ j, Ap i j • Fp j)) →
    w=(z.1+h • ∑ i, bq i • Fq i,z.2+h • ∑ i, bp i • Fp i) →
    (∀ i, Lq (Fq i)=Lq (fq (Lq.symm (Lq z.1+h • ∑ j, Aq i j • Lq (Fq j)),
      Lp.symm (Lp z.2+h • ∑ j, Ap i j • Lp (Fp j))))) ∧
    (∀ i, Lp (Fp i)=Lp (fp (Lq.symm (Lq z.1+h • ∑ j, Aq i j • Lq (Fq j)),
      Lp.symm (Lp z.2+h • ∑ j, Ap i j • Lp (Fp j))))) ∧
    (Lq w.1,Lp w.2)=(Lq z.1+h • ∑ i, bq i • Lq (Fq i),Lp z.2+h • ∑ i, bp i • Lp (Fp i)) := by
  intro n s Lq Lp fq fp Aq Ap bq bp h z w Fq Fp hq hp hw
  have tq : ∀ a : Fin s → ℝ,
      Lq.symm (Lq z.1+h • ∑ j, a j • Lq (Fq j)) = z.1+h • ∑ j, a j • Fq j := by
    intro a
    apply Lq.injective
    simp
  have tp : ∀ a : Fin s → ℝ,
      Lp.symm (Lp z.2+h • ∑ j, a j • Lp (Fp j)) = z.2+h • ∑ j, a j • Fp j := by
    intro a
    apply Lp.injective
    simp
  refine ⟨?_, ?_, ?_⟩
  · intro i
    rw [tq, tp]
    exact congrArg Lq (hq i)
  · intro i
    rw [tq, tp]
    exact congrArg Lp (hp i)
  · rw [hw]
    simp



/-- 修正版，对应原文 MD-3.6.2-PartitionedAffine。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem partitionedAffine_corrected :
  ∀ (n s : ℕ) (Lq Lp : Q n ≃L[ℝ] Q n) (fq fp : Z n → Q n)
    (Aq Ap : Matrix (Fin s) (Fin s) ℝ) (bq bp : Fin s → ℝ) (h : ℝ) (z w : Z n) (Fq Fp : Fin s → Q n),
    (∀ i, Fq i=fq (z.1+h • ∑ j, Aq i j • Fq j,z.2+h • ∑ j, Ap i j • Fp j)) →
    (∀ i, Fp i=fp (z.1+h • ∑ j, Aq i j • Fq j,z.2+h • ∑ j, Ap i j • Fp j)) →
    w=(z.1+h • ∑ i, bq i • Fq i,z.2+h • ∑ i, bp i • Fp i) →
    (∀ i, Lq (Fq i)=Lq (fq (Lq.symm (Lq z.1+h • ∑ j, Aq i j • Lq (Fq j)),
      Lp.symm (Lp z.2+h • ∑ j, Ap i j • Lp (Fp j))))) ∧
    (∀ i, Lp (Fp i)=Lp (fp (Lq.symm (Lq z.1+h • ∑ j, Aq i j • Lq (Fq j)),
      Lp.symm (Lp z.2+h • ∑ j, Ap i j • Lp (Fp j))))) ∧
    (Lq w.1,Lp w.2)=(Lq z.1+h • ∑ i, bq i • Lq (Fq i),Lp z.2+h • ∑ i, bp i • Lp (Fp i)) := by
  intro n s Lq Lp fq fp Aq Ap bq bp h z w Fq Fp hq hp hw
  have tq : ∀ a : Fin s → ℝ,
      Lq.symm (Lq z.1+h • ∑ j, a j • Lq (Fq j)) = z.1+h • ∑ j, a j • Fq j := by
    intro a
    apply Lq.injective
    simp
  have tp : ∀ a : Fin s → ℝ,
      Lp.symm (Lp z.2+h • ∑ j, a j • Lp (Fp j)) = z.2+h • ∑ j, a j • Fp j := by
    intro a
    apply Lp.injective
    simp
  refine ⟨?_, ?_, ?_⟩
  · intro i
    rw [tq, tp]
    exact congrArg Lq (hq i)
  · intro i
    rw [tq, tp]
    exact congrArg Lp (hp i)
  · rw [hw]
    simp
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | PRK保持分区的线性坐标变换下阶段/更新等变性的受限修复；普通RK见MD-3.6.2-RKAffine，时间反演见MD-3.6.2-SymmetricAffineReversible；任意混合分区的原印主张见待导师Printed条目。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.partitionedAffine`；`MD.Ch03.partitionedAffine_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正确限定为保持q,p分区的连续线性等价Lq,Lp；不同分区表格不要求混合线性等变。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条显式仅为保持分区的PRK阶段/更新等变修复；普通RK及有符号相容、对称资格的时间反演推论归RKAffine/SymmetricAffineReversible。保留混合变换错误的Printed导师条目。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]正确限定为保持q,p分区的连续线性等价Lq,Lp；不同分区表格不要求混合线性等变。；[EXTRA] 本条显式仅为保持分区的PRK阶段/更新等变修复；普通RK及有符号相容、对称资格的时间反演推论归RKAffine/SymmetricAffineReversible。保留混合变换错误的Printed导师条目。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；partitionedAffine作为受限修正版通过：对所有n,s及任意Lq,Lp、fq,fp、两套阶段和更新系数，三个前提精确给出PRK两阶段方程与更新；三个结论是分块运输后两阶段方程及终点更新。Lp/Lq逆像的位置和各自系数相配，h无额外限制。该修复不允许混合q,p，也不包含平移或时间反演；这些限制已明确写进scope/[EXTRA]，不是证明原文任意变换全称。[EXTRA]合理，但原印全称仍待人工勘误。

### 7. 状态与证明位置

self-contained；`MD.Ch03.partitionedAffine`：已证；`MD.Ch03.partitionedAffine_corrected`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2063)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.3-SymplecticNotReversible · unnumbered_claim · 印刷p.131 / PDFp.153

### 2. 原文陈述

> A method can be symplectic but not time-reversible (e.g. Symplectic Euler) or it can be time-reversible and not symplectic (e.g. Trapezoidal Rule).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticNotReversible :
  ∃ (h : ℝ) (z : Z 1),
    canonicalReversal (textbookSymplecticEuler (fun _ : Fin 1 => 1) (fun q => q 0^2/2) h
      (canonicalReversal (textbookSymplecticEuler (fun _ => 1) (fun q => q 0^2/2) h (pack z)))) ≠ pack z := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.symplecticNotReversible` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开 Ch03\_deps.txt：Q n=Fin n→ℝ，Z n=Q n×Q n，pack=Sum.elim q p；canonicalReversal(q,p)=(q,−p)。textbookPotentialForce 为负偏导，textbookSymplecticEuler 为先 momentumKick 后 positionDrift。因此本例 S\_h(q,p)=((1−h²)q+hp,p−hq)，签名恰为存在 h,z 使 R S\_h R S\_h z≠z。取 h=1,z=(1,0)，结果为(1,1)，不同于z。辛性未在本签名重述，但 context 已明确这是拆分后的非可逆反例；正式依赖 textbookSymplecticEuler\_isSymplectic 对 C² 势能给出辛性，本例满足资格，故组合内容覆盖原句的该分支。无额外假设。Ch03.lean 本定理含 sorry，签名 PASS 不表示证明已完成。

### 7. 状态与证明位置

incomplete；`MD.Ch03.symplecticNotReversible`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2131)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.3-TrapezoidalRelation · definition · 印刷p.131 / PDFp.153

### 2. 原文陈述

> A method can be symplectic but not time-reversible (e.g. Symplectic Euler) or it can be time-reversible and not symplectic (e.g. Trapezoidal Rule).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def trapezoidalRelation {n : ℕ} (f : Q n → Q n) (h : ℝ) (z w : Q n) : Prop := w=z+(h/2) • (f z+f w)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.trapezoidalRelation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 补梯形法标准隐式关系作为审阅上下文。 | [EXTRA] |

[EXTRA] 补梯形法标准隐式关系作为审阅上下文。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开本地及依赖 trapezoidalRelation，均是 w=z+(h/2)•(f z+f w)，Q n 为实有限维向量空间；对象、系数、隐式终点项均是梯形法。原页只有名称，没有定义公式；[EXTRA]明确标明补标准定义，必要且合理，不冒充原页原文。本项是定义，不含待证 sorry；原句的性质由相邻条目处理。

### 7. 状态与证明位置

self-contained；`MD.Ch03.trapezoidalRelation`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2139)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.3-TrapezoidalProperties · unnumbered_claim · 印刷p.131 / PDFp.153

### 2. 原文陈述

> A method can be symplectic but not time-reversible (e.g. Symplectic Euler) or it can be time-reversible and not symplectic (e.g. Trapezoidal Rule).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem trapezoidalProperties :
  (∀ (n : ℕ) (R : Q n →L[ℝ] Q n) (f : Q n → Q n) h z w,
    linearInvolution R → (∀ x, f (R x)=-R (f x)) → trapezoidalRelation f h z w →
    trapezoidalRelation f h (R w) (R z)) ∧
  ∃ (n : ℕ) (H : SymplecticCoordinates n → ℝ)
    (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (h : ℝ),
    ContDiff ℝ ∞ H ∧ ContDiff ℝ 1 (G h) ∧
    (∀ z, G h z=z+(h/2) • (textbookHamiltonianVectorField H z+textbookHamiltonianVectorField H (G h z))) ∧
    ¬ IsTextbookSymplecticMap (G h) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.trapezoidalProperties` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 完整实际隐式G与C¹Jacobian资格，不用求解存在作为结论前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |

[EXTRA] 完整实际隐式G与C¹Jacobian资格，不用求解存在作为结论前提。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；第一合取对任意维数、连续线性对合R、R可逆场f及任意h,z,w，给出梯形关系在(z,w)↦(Rw,Rz)下不变；反对易条件的负号正确，不要求隐式解存在或唯一。第二合取存在有限维真实Hamiltonian H（C∞）、某h及C¹的全局选解G h，逐点满足完整梯形隐式更新，且该C¹映射非辛；不是以任意非Hamiltonian向量场或不光滑解伪造反例。G其他步长不受约束，与所需某一步反例相符。原句的Symplectic Euler例子由context明确另列，本条只覆盖梯形例子。[EXTRA]中∞已用于H，1用于G h，均与声明一致。

### 7. 状态与证明位置

incomplete；`MD.Ch03.trapezoidalProperties`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2144)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.3-HamiltonianSpectrum · unnumbered_claim · 印刷p.131 / PDFp.153

### 2. 原文陈述

> For example, consider a linear Hamiltonian system $`\mathrm dz/\mathrm dt=JAz`$, with $`A`$ a symmetric matrix. If $`\lambda`$ is an eigenvalue of $`JA`$ then $`JAu=\lambda u`$ for some eigenvector $`u\ne0`$. Because the matrix $`JA`$ is real, we know that $`\overline\lambda`$ will also be an eigenvalue. At the same time, we know that since $`\lambda`$ is an eigenvalue of $`JA`$ it is also an eigenvalue of its transpose $`(JA)^T=A^TJ^T=-AJ`$, thus

$$
-AJu=\lambda u
$$


> multiplying by $`J`$ and setting $`v=Ju`$ we have

$$
-JAv=\lambda v
$$


> implying that $`-\lambda`$ (and hence also $`-\overline\lambda`$) is an eigenvalue of $`JA`$. Real eigenvalues of $`JA`$ are paired with their negatives. If the imaginary part is nonzero, the eigenvalues occur in quadruplets $`\{\pm\lambda,\pm\overline\lambda\}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianSpectrum :
  ∀ (n : ℕ) (A : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℝ), A.transpose=A → ∀ ζ,
    complexEigenvalue (textbookJ n*A) ζ → complexEigenvalue (textbookJ n*A) (-ζ) ∧
      complexEigenvalue (textbookJ n*A) (star ζ) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hamiltonianSpectrum` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开 complexEigenvalue 为存在非零复向量 v，实矩阵复化后的 mulVec v=ζ•v；不是抽象谱标签。A 是任意实对称 2n×2n 矩阵，J=[0 I;−I 0]，所以对象为真实 JA。负号和共轭闭包准确；将同一全称结论用于 star ζ 可得 −star ζ，故没有漏掉第四种值；不要求四值互异，纯虚特征值允许重复。[ERRATUM?]成立：原书从 JA 的特征向量 u 直接转为转置的同一 u 无效。例如 A=diag(1,2)，JA=[[0,2],[−1,0]]，ζ=i√2，u=(−i√2,1)；JA u=ζu，但 −AJu=(−1,−2i√2)≠ζu=(2,i√2)。应重新选转置特征向量。签名保留正确谱结论，不复制错误中间式；原书错误式仍原样保存在 statement\_latex。Ch03.lean 含 sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch03.hamiltonianSpectrum`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2157)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

