上一部分：无 / [目录](../../CH03_BLUEPRINT.zh-CN.md) / [下一部分](part02.zh-CN.md)

# 第3章 Lean Blueprint 本地审阅材料

149条；网站PASS 106，本地按意见修复10条（未再送网站），合并勘误30项。
统计与证明状态见[导师摘要](../../CH03_SUMMARY_FOR_MENTOR.zh-CN.md)，原书问题见[勘误清单](../../CH03_ERRATA.zh-CN.md)。网站原返回与本地修复结论分开保留；完整检查证据：blueprint/closeout24/ch03/full/CHECK\_REPORT.json。

## 1. MD-3-ModifiedConstruction · unnumbered_claim · 印刷p.97 / PDFp.119

### 2. 原文陈述

> We can express the fundamental consequence as follows: not only are Hamiltonian flow maps symplectic, but also near-identity symplectic maps are (in an approximate sense) Hamiltonian flow maps [31]. The fact leads to the existence of a modified (perturbed) Hamiltonian from which the discrete trajectory may be derived (as snapshots of continuous trajectories). In some cases we may derive this perturbed Hamiltonian as an expansion in powers of the stepsize.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def smoothSymplecticData {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (r : ℕ) : Prop :=
  0 < r ∧ IsOpen D ∧ Convex ℝ D ∧ IsCompact B ∧ Convex ℝ B ∧ B ⊆ D ∧
  ContDiffOn ℝ ∞ H D ∧
  (∀ z ∈ D, G 0 z=z) ∧
  (∃ η > 0, ContDiffOn ℝ ∞ (fun hz : ℝ × SymplecticCoordinates n => G hz.1 hz.2)
      (Ioo (-η) η ×ˢ D) ∧
    (∀ h ∈ Ioo (-η) η, ∀ z ∈ D, IsTextbookSymplectic (textbookJacobian (G h) z)) ∧
    actualFlowNearCompact (textbookHamiltonianVectorField H) D B Φ η) ∧ localOrder G Φ B r

def modifiedConstruction_statement24 : Prop :=
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ∞ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G

theorem modifiedConstruction :
  MolecularDynamics.Chapter02Review.hamiltonianSymplectic_statement ∧
  modifiedConstruction_statement24 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.smoothSymplecticData`；`MD.Ch03.modifiedConstruction_statement24`；`MD.Ch03.modifiedConstruction` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 近恒等、光滑、阶r≥1用smoothSymplecticData实际定义表达：开放凸D、紧凸B⊆D、H及(h,z)↦G\_h(z)无限可微、G₀=id、逐h辛、实际原始ODE流和局部阶。 | [EXTRA] |
| 技术资格或版本解释 | 按任意有限截断匹配解释“in an approximate sense”；不将形式无限级数当实际收敛解，不将finiteMatching结论作前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] EAUDIT01补原首句Hamiltonian流辛性为独立完整结论，与原近恒等辛映射修正Hamiltonian有限匹配合取；两个真实项目命题全部量词展开供审校，未把流辛性作构造前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 正式库冻结；在本Blueprint同名局部定义中把H、联合G的正则性改为scoped ∞，构造结论Hj也使用∞。主定理改接该本地完整命题，保留Hamilton流辛性合取及∃Hj后∀k量词。未改冻结库，未把解析充分条件当作C∞证明。 | [EXTRA] |

[EXTRA] 近恒等、光滑、阶r≥1用smoothSymplecticData实际定义表达：开放凸D、紧凸B⊆D、H及(h,z)↦G\_h(z)无限可微、G₀=id、逐h辛、实际原始ODE流和局部阶。；按任意有限截断匹配解释“in an approximate sense”；不将形式无限级数当实际收敛解，不将finiteMatching结论作前提。；[EXTRA] EAUDIT01补原首句Hamiltonian流辛性为独立完整结论，与原近恒等辛映射修正Hamiltonian有限匹配合取；两个真实项目命题全部量词展开供审校，未把流辛性作构造前提。；[EXTRA] 正式库冻结；在本Blueprint同名局部定义中把H、联合G的正则性改为scoped ∞，构造结论Hj也使用∞。主定理改接该本地完整命题，保留Hamilton流辛性合取及∃Hj后∀k量词。未改冻结库，未把解析充分条件当作C∞证明。

### 6. 审计结论

本轮修复：正式库冻结；在本Blueprint同名局部定义中把H、联合G的正则性改为scoped ∞，构造结论Hj也使用∞。主定理改接该本地完整命题，保留Hamilton流辛性合取及∃Hj后∀k量词。未改冻结库，未把解析充分条件当作C∞证明。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；完整结论是 Hamiltonian 流辛性与修正 Hamiltonian 有限匹配的合取，没有把其中任一结论当作前提。前者量化 n,H,Φ,τ，H 为 C²、Φ 为 C¹，初值恒等且在 Icc 0 τ 满足实际 ODE；τ<0 时结论区间为空，τ=0 时由初值恒等成立。后者量化 n,r,H,D,B,G,Φ；0<r、开放凸 D、紧凸 B⊆D、G₀=id、逐 h 辛、实际流与局部误差均已展开。Hj 是一次选择的整个序列，对所有 k≥r 存在 δ,A,Γ，截断 Hamiltonian 含 r 至 k 次项、轨道留在 D、误差 ≤A h^(k+1)，只断言正小步长的有限截断。问题在于 smoothSymplecticData、Hj 输出采用 ContDiffOn ℝ ⊤，按本任务给出的版本约定是解析资格，不能称作原文的 C∞ 资格；与同批第17条特别修复说明矛盾。局部阶只在 B 上给出，本次不将它擅自提升为 D 上的阶条件。

### 7. 状态与证明位置

incomplete；`MD.Ch03.smoothSymplecticData`：定义；`MD.Ch03.modifiedConstruction_statement24`：定义；`MD.Ch03.modifiedConstruction`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L23)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-AdjointEulerOscillator · definition · 印刷p.98 / PDFp.120

### 2. 原文陈述

> Let us begin with an illustrative example. Consider the harmonic oscillator with frequency $`\Omega`$ which has Hamiltonian $`H(q,p)=p^2/2+\Omega^2q^2/2`$, and consider the adjoint symplectic Euler method

$$
Q=q+hp,\qquad P=p-h\Omega^2Q,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def oscillatorAdjointEuler (Ω h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := z.1+h*z.2
  (q,z.2-h*Ω^2*q)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.oscillatorAdjointEuler` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03.lean:30–32 的实际定义：z=(q,p)，局部变量 q 保存更新后 Q=q+hp，返回 (Q,p−hΩ²Q)，第二分量使用新位置而非旧位置，忠实于 adjoint symplectic Euler。Ch03\_deps.txt 的 MolecularDynamics/Chapter03/ReviewDefinitions.lean:3530–3532 的正式库同名定义亦为相同映射，没有隐藏条件或符号差异。对象、参数与两条更新均一致。本条无 [EXTRA]、[ERRATUM?]；完整 def 无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch03.oscillatorAdjointEuler`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L47)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-ShadowHamiltonian · (3.1) · 印刷p.98 / PDFp.120

### 2. 原文陈述

> However, if we modify the Hamiltonian from $`H(q,p)=p^2/2+\Omega^2q^2/2`$ to

$$
\widetilde H(q,p)=\frac{p^2+h\Omega^2pq+\Omega^2q^2}{2},\tag{3.1}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def oscillatorShadow (Ω h : ℝ) (z : ℝ × ℝ) : ℝ := (z.2^2+h*Ω^2*z.2*z.1+Ω^2*z.1^2)/2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.oscillatorShadow` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；Ch03.lean:35 将 z.1=q、z.2=p 代入后，实际定义是 (p²+hΩ²pq+Ω²q²)/2，交叉项为正号，分母覆盖整个分子，与原页式(3.1)一致。已展开 Ch03\_deps.txt 的 MolecularDynamics/Chapter03/ReviewDefinitions.lean:3534，正式库同名定义相同；没有把影子能量替换成原始 oscillatorEnergy。这里定义的是依赖 h 的实值二次型，不宣称所有步长下均正定。本条无 [EXTRA]、[ERRATUM?]；完整 def 无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch03.oscillatorShadow`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L52)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-EnergyFailure · unnumbered_claim · 印刷p.98 / PDFp.120

### 2. 原文陈述

> If $`H(q,p)=E`$ then, for typical steps, we cannot expect $`H(Q,P)=E`$. (Just insert the formulas for $`Q`$ and $`P`$ into the Hamiltonian and check that the value is not the same as $`H(q,p)`$.)

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem oscillatorEnergyFailure : ∀ Ω h : ℝ, 0 < Ω → h ≠ 0 →
  (∀ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)-oscillatorEnergy Ω z =
    (h^2*Ω^2/2)*(Ω^2*(z.1+h*z.2)^2-z.2^2)) ∧
  (∀ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)=oscillatorEnergy Ω z ↔
    Ω*(z.1+h*z.2)=z.2 ∨ Ω*(z.1+h*z.2)=-z.2) ∧
  (∃ z : ℝ × ℝ, oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z) ≠ oscillatorEnergy Ω z) := by
  intro Ω h hΩ hh
  have hh2 : 0 < h^2 := sq_pos_of_ne_zero hh
  have hΩ2 : 0 < Ω^2 := sq_pos_of_ne_zero hΩ.ne'
  have hc : h^2*Ω^2/2 ≠ 0 := (div_pos (mul_pos hh2 hΩ2) (by norm_num : (0 : ℝ)<2)).ne'
  have hdelta : ∀ z : ℝ × ℝ,
      oscillatorEnergy Ω (oscillatorAdjointEuler Ω h z)-oscillatorEnergy Ω z =
        (h^2*Ω^2/2)*(Ω^2*(z.1+h*z.2)^2-z.2^2) := by
    intro z
    simp only [oscillatorEnergy,oscillatorAdjointEuler]
    ring
  refine ⟨hdelta,?_,?_⟩
  · intro z
    rw [← sub_eq_zero,hdelta z,mul_eq_zero]
    simp only [hc,false_or]
    have he : Ω^2*(z.1+h*z.2)^2=(Ω*(z.1+h*z.2))^2 := by ring
    rw [he,sub_eq_zero]
    exact sq_eq_sq_iff_eq_or_eq_neg
  · refine ⟨(1,0),?_⟩
    intro heq
    have hd := hdelta (1,0)
    rw [heq,sub_self] at hd
    norm_num at hd
    rcases hd with hzero | hzero
    · exact hh hzero
    · exact hΩ.ne' hzero
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.oscillatorEnergyFailure` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] EAUDIT01对每个Ω>0和h≠0保存完整ΔH恒等、能量不变的两条例外直线和一般不守恒见证；精确代数为原typical的形式化展开，不回填成教材原句。 | [EXTRA] |

[EXTRA] [EXTRA] EAUDIT01对每个Ω>0和h≠0保存完整ΔH恒等、能量不变的两条例外直线和一般不守恒见证；精确代数为原typical的形式化展开，不回填成教材原句。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀Ω,h，前提 Ω>0、h≠0；∀实相点 z 给出完整能量差恒等式及能量相等当且仅当 Ω(q+hp)=±p，并给出存在不守恒点。项目映射是先 Q=q+hp、再 P=p−hΩ²Q；能量是 (p²+Ω²q²)/2。因非零因子 h²Ω²/2，可约去得到两条例外直线；z=(1,0) 的能量增量 h²Ω⁴/2>0。它精确解释 typical，未错误断言所有初值均不守恒。

### 7. 状态与证明位置

self-contained；`MD.Ch03.oscillatorEnergyFailure`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L56)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-ShadowInvariant · unnumbered_claim · 印刷p.99 / PDFp.121

### 2. 原文陈述

> This means that $`\widetilde H`$ is a conserved quantity of the numerical method.

### 3. 原文证明


$$
\begin{aligned}\widetilde H(Q,P)&=\frac{P^2}{2}+\frac{h\Omega^2PQ}{2}+\frac{\Omega^2Q^2}{2}\\ &=\frac12p^2-\frac{h\Omega^2}{2}pQ+\frac{\Omega^2Q^2}{2}\\&=\widetilde H(q,p)\end{aligned}
$$


原书计算按原页转录。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem oscillatorShadowInvariant :
  ∀ Ω h z, oscillatorShadow Ω h (oscillatorAdjointEuler Ω h z)=oscillatorShadow Ω h z := by
  exact MolecularDynamics.Chapter03Review.oscillatorShadowInvariant_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.oscillatorShadowInvariant` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀实数 Ω,h 及 z∈ℝ²，项目 shadow 恰为原式 (p²+hΩ²pq+Ω²q²)/2，项目映射恰为 adjoint symplectic Euler。代入后交叉项消去，得到原值；无需 h 小、Ω>0 或正定性。声明只谈守恒，没有把任意步长下的等值线都说成椭圆。proof\_latex 的三行与原页对应。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.oscillatorShadowInvariant`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L89)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-ShadowEllipses · unnumbered_claim · 印刷p.99 / PDFp.121

### 2. 原文陈述

> Recall that the graph of

$$
\frac{x^2}{a^2}+\frac{y^2}{b^2}=1
$$


> is an ellipse with major and minor axes aligned to the coordinate axes. If $`\epsilon`$ is a small value, then

$$
\frac{x^2}{a^2}+\frac{y^2}{b^2}+\epsilon xy=1
$$


> will be a slightly rotated ellipse (with slightly different major and minor axes). Thus we can think of the energy surface of the numerical method as being a small perturbation of the ellipse which represents the ‘energy surface’ (energy curve, in this case) of the harmonic oscillator itself.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shadowEllipses :
    (∀ a b : ℝ, a ≠ 0 → b ≠ 0 →
      ∃ δ > 0, ∃ θ A B : ℝ → ℝ,
        Tendsto A (𝓝 0) (𝓝 |a|) ∧ Tendsto B (𝓝 0) (𝓝 |b|) ∧
        (∀ ε ∈ Ioo (-δ) δ, 0 < A ε ∧ 0 < B ε ∧ ∀ x y : ℝ,
          x^2/a^2+y^2/b^2+ε*x*y =
            (Real.cos (θ ε)*x+Real.sin (θ ε)*y)^2/(A ε)^2+
            (-Real.sin (θ ε)*x+Real.cos (θ ε)*y)^2/(B ε)^2)) ∧
    (∀ Ω h : ℝ, 0 < Ω → |h*Ω| < 2 →
      (∀ z : ℝ × ℝ, z ≠ 0 → 0 < oscillatorShadow Ω h z) ∧
      ∃ L : (ℝ × ℝ) ≃ₗ[ℝ] (ℝ × ℝ), ∀ z,
        oscillatorShadow Ω h (L z)=(z.1^2+z.2^2)/2) := by
  sorry



/-- 修正版，对应原文 MD-3.1-ShadowEllipses。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shadowEllipses_corrected :
    (∀ a b : ℝ, a ≠ 0 → b ≠ 0 →
      ∃ δ > 0, ∃ θ A B : ℝ → ℝ,
        Tendsto A (𝓝 0) (𝓝 |a|) ∧ Tendsto B (𝓝 0) (𝓝 |b|) ∧
        (∀ ε ∈ Ioo (-δ) δ, 0 < A ε ∧ 0 < B ε ∧ ∀ x y : ℝ,
          x^2/a^2+y^2/b^2+ε*x*y =
            (Real.cos (θ ε)*x+Real.sin (θ ε)*y)^2/(A ε)^2+
            (-Real.sin (θ ε)*x+Real.cos (θ ε)*y)^2/(B ε)^2)) ∧
    (∀ Ω h : ℝ, 0 < Ω → |h*Ω| < 2 →
      (∀ z : ℝ × ℝ, z ≠ 0 → 0 < oscillatorShadow Ω h z) ∧
      ∃ L : (ℝ × ℝ) ≃ₗ[ℝ] (ℝ × ℝ), ∀ z,
        oscillatorShadow Ω h (L z)=(z.1^2+z.2^2)/2) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.shadowEllipses`；`MD.Ch03.shadowEllipses_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 显式Ω>0、\|hΩ\|<2，排除退化与不稳定步长；线性等价给出振子二次型标准形。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 显式Ω>0、|hΩ|<2，排除退化与不稳定步长；线性等价给出振子二次型标准形。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；所有相关自定义对象均已在依赖中找到并展开，没有缺失定义。Ch03.lean:52–64 的第一项是 ∀a,b≠0 后 ∃δ>0、∃θ,A,B（均为 ε 的函数），A→|a|、B→|b|，对每个 |ε|<δ 有正半轴和对全部 x,y 成立的实际正交旋转恒等式，确实覆盖一般椭圆及半轴长度的小扰动，不是仅振子特例。第二项展开 oscillatorShadow 得矩阵 [[Ω²,hΩ²/2],[hΩ²/2,1]]；[EXTRA] Ω>0 是正频率约定（数学上 Ω≠0 已足够），|hΩ|<2 正是正定性的必要充分步长条件，合理且未假设结论。L 是真实实线性等价，表达正定二次型标准化。对 E>0，令 x=q、y=p、a=√(2E)/Ω、b=√(2E)、ε=hΩ²/(2E)，一般合取项即给出影子能量水平集和 h→0 的形状扰动，此联系能从现有定义推得，不能据“未统一”报材料不足。真正需要人工裁定的是原书“slightly rotated”含义：签名只断言旋转存在，未要求 θ(ε)→0；当 a²=b² 时原曲线是圆，原始主轴无唯一方向，而微小交叉项选择的轴相对于固定坐标轴可以是45°。需确认作者仅指曲线形状接近，还是在非圆条件下还要求小角度变化。原书未明确，这个原文问题是本条 NEEDS\_HUMAN 的唯一原因。本条没有 [ERRATUM?] 标注，疑点已另行记录；有 sorry，只表示证明未完成，与上述签名审计分开判断。

### 7. 状态与证明位置

incomplete；`MD.Ch03.shadowEllipses`：未证（原书疑误不证）；`MD.Ch03.shadowEllipses_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L97)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-EulerGrowth · unnumbered_claim · 印刷p.100 / PDFp.122

### 2. 原文陈述

> Obviously this conservation property (the existence of a perturbed energy surface) is a special feature of the method we have considered. If we used Euler’s method to solve the harmonic oscillator we would find that energy grows without bound.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem eulerOscillatorGrowth :
  ∀ Ω h : ℝ, Ω ≠ 0 → h ≠ 0 → ∀ z : ℝ × ℝ, 0 < oscillatorEnergy Ω z →
    Tendsto (fun ν : ℕ => oscillatorEnergy Ω ((oscillatorEuler Ω h)^[ν] z)) atTop atTop := by
  intro Ω h hΩ hh z hz
  have hfactor : 1 < 1+h^2*Ω^2 := by
    have hp := mul_pos (sq_pos_of_ne_zero hh) (sq_pos_of_ne_zero hΩ)
    linarith
  have hstep : ∀ w, oscillatorEnergy Ω (oscillatorEuler Ω h w) =
      (1+h^2*Ω^2)*oscillatorEnergy Ω w := by
    intro w
    simp only [oscillatorEnergy, oscillatorEuler]
    ring
  have hiter : ∀ ν : ℕ, oscillatorEnergy Ω ((oscillatorEuler Ω h)^[ν] z) =
      (1+h^2*Ω^2)^ν*oscillatorEnergy Ω z := by
    intro ν
    induction ν with
    | zero => simp
    | succ ν ih =>
      rw [Function.iterate_succ_apply', hstep, ih, pow_succ]
      ring
  simpa only [hiter] using
    (tendsto_pow_atTop_atTop_of_one_lt hfactor).atTop_mul_const hz
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.eulerOscillatorGrowth` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | Ω≠0、固定h≠0且初始能量>0，排除平衡点和零步长。 | [EXTRA] |

[EXTRA] Ω≠0、固定h≠0且初始能量>0，排除平衡点和零步长。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt 的 ReviewDefinitions.lean:3533、3535：EΩ=(p²+Ω²q²)/2，显式 Euler 的第二分量使用旧位置 q。定义给出 EΩ(new)=(1+h²Ω²)EΩ(old)，ν 次迭代即 (1+h²Ω²)^ν EΩ(z)。Ch03.lean:68–88 的全称参数、Function.iterate 和 Tendsto … atTop atTop 精确表达固定步长下能量随步数趋于正无穷，覆盖“grows without bound”。[EXTRA] Ω≠0、h≠0、初始能量>0 必要且合理：Ω=0 时 p 不变而原能量恒定，h=0 时映射恒等，初能为0时平衡点能量始终为0。允许负频率参数或负步长也成立，因为放大因子只依赖平方；通常源语境取正频率和正步长。没有 [ERRATUM?]；现证明无 sorry。本次只读检查，没有编译或补证明。

### 7. 状态与证明位置

self-contained；`MD.Ch03.eulerOscillatorGrowth`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L134)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-FormalHamiltonian · definition · 印刷p.100 / PDFp.122

### 2. 原文陈述

> Now consider the more general Hamiltonian setting. Let $`\mathcal G_h`$ be a $`r`$th order symplectic integrator, $`r\ge1`$. Suppose that it is the flow map of a certain Hamiltonian system, with Hamiltonian $`\widetilde H_h`$. If the method order is $`r`$, we may expect this Hamiltonian to be a $`\mathcal O(h^r)`$ approximation of $`H`$, thus we posit an expansion of the form

$$
\widetilde H_h=H+h^rH^{(r)}+h^{r+1}H^{(r+1)}+\cdots
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def formalHamiltonian {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then H z else if r ≤ j then Hj j z else 0)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.formalHamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] EAUDIT01显式1≤r，排除r=0遗漏Hr0的错义；仍是真实逐系数形式级数，不声称无限收敛或实际流嵌入。 | [EXTRA] |

[EXTRA] [EXTRA] EAUDIT01显式1≤r，排除r=0遗漏Hr0的错义；仍是真实逐系数形式级数，不声称无限收敛或实际流嵌入。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对象是 n 自由度实相空间，r∈ℕ 且显式 1≤r；对每点 z 构造 PowerSeries ℝ，零次为 H z，1≤j<r 为零，j≥r 为 Hj j z。正确避免 r=0 分支吞掉 H^(0)，不声称形式和收敛或实际嵌入流。此定义仅编码所 posit 的展开，不是构造系数或证明方法确为该流的存在性定理。

### 7. 状态与证明位置

self-contained；`MD.Ch03.formalHamiltonian`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L159)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-FormalHamiltonianField · definition · 印刷p.100 / PDFp.122

### 2. 原文陈述

> To determine the terms $`H^{(r)},H^{(r+1)},\ldots`$, we write the differential equations on $`\widetilde H_h`$:

$$
\dot{\boldsymbol z}=J\nabla H+h^rJ\nabla H^{(r)}+h^{r+1}J\nabla H^{(r+1)}+\cdots
$$



### 3. 原文证明

原书无独立完整证明。
> The solution of this system can be expanded in powers of $`h`$ and equated term-by-term with the expansion of $`\mathcal G_h`$ in powers of $`h`$. In this way, successive terms may be computed. Although mechanical, this procedure is tedious.
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def formalHamiltonianField {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r : ℕ) (_hr : 1 ≤ r)
    (_hH : ContDiff ℝ ∞ H) (_hHj : ∀ j, ContDiff ℝ ∞ (Hj j))
    (z : SymplecticCoordinates n) (i : Fin n ⊕ Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then textbookHamiltonianVectorField H z i else
    if r ≤ j then textbookHamiltonianVectorField (Hj j) z i else 0)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.formalHamiltonianField` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] EAUDIT01显式1≤r及H和全部Hj全域C∞，保证真实Fréchet梯度；原平滑逐阶形式展开资格，不预置匹配结论。 | [EXTRA] |

[EXTRA] [EXTRA] EAUDIT01显式1≤r及H和全部Hj全域C∞，保证真实Fréchet梯度；原平滑逐阶形式展开资格，不预置匹配结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；n,r,H,Hj,z 与坐标 i:Fin n⊕Fin n 均明确；1≤r、H 及每个 Hj 的 ContDiff ℝ ∞ 是光滑资格。零次为 J∇H 的 i 分量，r 起每次为 J∇Hj 的 i 分量，中间系数为零。项目 J=fromBlocks 0 1 (−1) 0、梯度由真实 fderiv 在单位基上取值，给出正确位置正、动量负的 Hamilton 方程。是逐坐标形式级数，不把无限级数当实际 ODE 解。

### 7. 状态与证明位置

self-contained；`MD.Ch03.formalHamiltonianField`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L166)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-LieDerivative · definition · 印刷p.100 / PDFp.122

### 2. 原文陈述

> The right hand side suggests a shorthand notation. If we define the Lie derivative $`\mathcal L_f`$ by

$$
\mathcal L_f\phi=f\cdot\nabla\phi,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def textbookLieDerivative (f : E → E) (φ : E → ℝ) (z : E) : ℝ :=
  (fderiv ℝ φ z) (f z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.textbookLieDerivative` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；PASS。已展开 Ch03.lean 中 MD.Ch03.textbookLieDerivative，以及 Ch03\_deps.txt 的 -- FILE: MolecularDynamics/Chapter03/LiePoisson.lean 中 MolecularDynamics.textbookLieDerivative；二者均为 (fderiv ℝ φ z) (f z)，即 Dφ(z)[f(z)]。E 的实际约束为实赋范向量空间，φ:E→ℝ、f:E→E，z 为评价点；取 E=R^m 且 φ 光滑时恰为 ∇φ(z)·f(z)，方向、标量值和作用次序均正确。推广至一般 E 和将 fderiv 全函数化不改变原文光滑情形；不据此宣称不可微点存在经典导数。没有额外假设或 [ERRATUM?]。证明状态独立记录：这是直接给出函数体的 def，不是含 sorry 的待证定理；未运行 Lean 编译。

### 7. 状态与证明位置

self-contained；`MD.Ch03.textbookLieDerivative`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L174)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-ObservableDerivative · (3.2) · 印刷p.100–101 / PDFp.122–123

### 2. 原文陈述

> At any point $`\boldsymbol z=\boldsymbol\zeta`$ in phase space assume that there is a unique solution $`\boldsymbol z(t,\boldsymbol\zeta)`$ such that $`\dot{\boldsymbol z}(t)=f(\boldsymbol z(t))`$, $`\boldsymbol z(0)=\boldsymbol\zeta`$ that is globally defined for all $`t`$. Now differentiate $`\hat\phi(t)=\phi(\boldsymbol z(t))`$ with respect to time, using the chain rule, to see how $`\phi(\boldsymbol z(t))`$ is changing as $`t`$ is varied:

$$
\left.\frac{\mathrm d}{\mathrm dt}\hat\phi\right|_{t=0}=\left[\sum_{i=1}^m\frac{\partial\phi}{\partial z_i}\dot z_i\right]_{\boldsymbol z=\boldsymbol\zeta}=\nabla\phi(\boldsymbol\zeta)\cdot f(\boldsymbol\zeta).
$$


> and note that the origin of time is irrelevant, then the equation for the evolution of $`\phi`$ could be written

$$
\frac{\mathrm d}{\mathrm dt}\hat\phi=(\mathcal L_f\phi)(\boldsymbol z).\tag{3.2}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem observableDerivative (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (t : ℝ) (hφ : DifferentiableAt ℝ φ (γ t))
    (hγ : HasDerivAt γ (f (γ t)) t) :
    HasDerivAt (fun u => φ (γ u)) (textbookLieDerivative f φ (γ t)) t := by
  apply MolecularDynamics.hasDerivAt_textbookLieDerivative <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.observableDerivative` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意实赋范空间 E 中，f:E→E、φ:E→ℝ、实际曲线 γ、任意 t；只需 φ 在 γ(t) 可微及 γ 在 t 有导数 f(γ(t))。结论是 φ∘γ 在 t 的 HasDerivAt，导数正是 fderiv φ (γ t) 作用于 f(γ t)。这是比原文全局唯一解及全局光滑假设更一般的局部链式法则，原文解当然可实例化；t=0 且 γ(0)=ζ 给出首式，无遗漏演化式。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.observableDerivative`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L178)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-ObservableSecondDerivative · unnumbered_claim · 印刷p.101 / PDFp.123

### 2. 原文陈述

> Similarly,

$$
\frac{\mathrm d^2}{\mathrm dt^2}\phi(\boldsymbol z(t))=(\mathcal L_f^2\phi)(\boldsymbol z(t)).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem observableSecondDerivative (f : E → E) (φ : E → ℝ)
    (γ : ℝ → E) (hf : ContDiff ℝ 1 f) (hφ : ContDiff ℝ 2 φ)
    (hγ : ∀ t, HasDerivAt γ (f (γ t)) t) (t : ℝ) :
    HasDerivAt (fun u => deriv (fun v => φ (γ v)) u)
      (textbookLieDerivative f (textbookLieDerivative f φ) (γ t)) t := by
  apply MolecularDynamics.hasDerivAt_textbookLieDerivative_second <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.observableSecondDerivative` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | f全域C¹、φ全域C²，显式化原文smooth及第二次求导资格。 | [EXTRA] |

[EXTRA] f全域C¹、φ全域C²，显式化原文smooth及第二次求导资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；PASS。已展开 MD.Ch03.textbookLieDerivative 和 Ch03\_deps.txt 的 -- FILE: MolecularDynamics/Chapter03/LiePoisson.lean 中 contDiff\_textbookLieDerivative、hasDerivAt\_textbookLieDerivative\_second。右端实为 D(Dφ[ f ])(γ(t))[f(γ(t))]，即 L\_f(L\_f φ)，不是函数值的平方；左端是 u↦deriv(v↦φ(γ(v)))(u) 的真实一阶导数，正好为二阶时间导数。hf:ContDiff ℝ 1 f、hφ:ContDiff ℝ 2 φ 保证第一次 Lie 导数为 C¹；∀t 的真实ODE条件使内层 deriv 在邻近时间与 L\_f φ∘γ 相等。量词允许任意满足条件的 γ 和任意 t，不预设所求二阶等式。[EXTRA]是合理的经典求二阶导数资格：C¹/C² 足够，全域要求和全时间解条件比仅沿曲线的局部条件强，因此不是最小假设，但不引入无关限制；它们不能被理解为原书证明了任意不光滑 f 的同一公式。没有本条 [ERRATUM?]。证明状态独立记录：当前声明调用该二阶导数依赖定理；已读到的依赖函数体用链式法则和可微性推导，无 sorry；未编译。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.observableSecondDerivative`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L186)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-OperatorExponential · definition · 印刷p.101 / PDFp.123

### 2. 原文陈述

> By analogy with the derivation of the matrix exponential, it is tempting to express the exponential as a series expansion in powers of $`t`$:

$$
e^{t\mathcal L_f}=\mathrm{Id}+t\mathcal L_f+\frac{t^2}{2}\mathcal L_f^2+\cdots.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def formalOperatorExponential (A : R) : PowerSeries R :=
  PowerSeries.mk (fun n => (1 / (n.factorial : ℝ)) • A ^ n)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.formalOperatorExponential` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；PASS。Ch03.lean 实际给出 R 的约束 [Ring R] [Algebra ℝ R]，并将 formalOperatorExponential A 定义为 PowerSeries.mk(n↦(1/(n!:ℝ))•A^n)。Ch03\_deps.txt 的 -- FILE: MolecularDynamics/Chapter03/FormalOperatorSeries.lean 中 textbookFormalOperatorExponential 为同一完整定义，coeff 定理明确第 n 项为该系数。常数、一次、二次系数依次为1、A、(1/2)•A²；形式不定元对应原文时间 t，1 对应算子 Id。结合的实代数可以非交换，未额外假设算子可交换；实数上的除法仅在系数1/n!中进行。给定任意 A 是抽象形式指数的推广，代入 A=L\_f 时恢复原文表达；这里并未构造或断言作用于实际函数空间的有界指数算子。没有求和收敛、解析性或把形式变量取实数值的额外前提，符合原文保留意见，无 [ERRATUM?]。证明状态独立记录：本条为显式 def，不含 sorry；未编译。

### 7. 状态与证明位置

self-contained；`MD.Ch03.formalOperatorExponential`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L194)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-FormalObservable · definition · 印刷p.101 / PDFp.123

### 2. 原文陈述

> The Taylor series expansion of $`\phi(\boldsymbol z(t))`$ along a solution of the differential equation can therefore be written as

$$
\begin{aligned}\phi(\boldsymbol z(t))&=\phi(\boldsymbol z(0))+t\left.\frac{\mathrm d}{\mathrm dt}\phi(\boldsymbol z(t))\right|_{t=0}+\frac{t^2}{2}\left.\frac{\mathrm d^2}{\mathrm dt^2}\phi(\boldsymbol z(t))\right|_{t=0}+\cdots\\ &=\phi(\boldsymbol z(0))+t(\mathcal L_f\phi)(\boldsymbol z(0))+\frac{t^2}{2}(\mathcal L_f^2\phi)(\boldsymbol z(0))+\cdots\\ &=(e^{t\mathcal L_f}\phi)(\boldsymbol z(0)).\end{aligned}
$$



### 3. 原文证明

原书无独立完整证明。
> However, as $`\mathcal L_f`$ is a first order operator, this series involves high order mixed partial derivatives, and the convergence of the expansion has to be considered in connection with its application to given initial data, that is, we should consider the expansion

$$
e^{t\mathcal L_f}\phi=\phi+t\mathcal L_f\phi+\frac{t^2}{2}\mathcal L_f^2\phi+\cdots
$$


> then the primary issue is the boundedness of the terms with respect to functions $`\phi`$ of a certain space of functions; we ignore the convergence issue here and treat the operator exponential as a formal series expansion.
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def formalObservable {n : ℕ} (f : Q n → Q n) (φ : Q n → ℝ) (z : Q n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => ((textbookLieDerivative f)^[j] φ) z/(Nat.factorial j : ℝ))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.formalObservable` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；PASS，适用范围为本条明示的形式系数定义。已展开 Ch03\_deps.txt 的 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean 中 Q n=Fin n→ℝ、-- FILE: MolecularDynamics/Chapter03/LiePoisson.lean 中 textbookLieDerivative，以及 -- FILE: MolecularDynamics/Chapter03/ReviewDefinitions.lean 中 formalObservable；Ch03.lean 的本地定义与后者相同。第 j 个系数为 ((L\_f)^[j] φ)(z)/j!，^[j] 是对函数φ反复施加算子：j=0为φ(z)，j=1为L\_fφ(z)，j=2为L\_f(L\_fφ)(z)/2，符合原文。z 在公式应用时取γ(0)，并非在γ(t)处评价各Taylor系数。对象为任意有限维实相空间和实值观测量，定义扩展到非光滑输入只是fderiv的全函数化，不声称这些输入具有经典Taylor展开。无 γ 参数、无ODE前提是因为本条定义的是展示式右侧形式级数；它本身不是沿实际解的全阶时间导数定理，也不证明左侧实际函数等于收敛级数。原文三行中沿解的解释应在光滑ODE语境下作形式Taylor解释，本条context已限定这一范围；其有限实际余项属于另一审计条目。无 [EXTRA] 或 [ERRATUM?]。证明状态独立记录：本条为显式 def，无 sorry；未编译。

### 7. 状态与证明位置

self-contained；`MD.Ch03.formalObservable`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L198)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-FiniteLieTaylor · unnumbered_claim · 印刷p.101 / PDFp.123

### 2. 原文陈述

> The Taylor series expansion of $`\phi(\boldsymbol z(t))`$ along a solution of the differential equation can therefore be written as

$$
\phi(\boldsymbol z(t))=\phi(\boldsymbol z(0))+t(\mathcal L_f\phi)(\boldsymbol z(0))+\frac{t^2}{2}(\mathcal L_f^2\phi)(\boldsymbol z(0))+\cdots.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem lieTaylor :
  ∀ (n k : ℕ) (f : Q n → Q n) (φ : Q n → ℝ) (γ : ℝ → Q n),
    ContDiff ℝ ⊤ f → ContDiff ℝ ⊤ φ →
    (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∃ C > 0, ∃ δ > 0, ∀ t ∈ Ioo (-δ) δ,
      |φ (γ t)-∑ j ∈ Finset.range (k+1), t^j/(Nat.factorial j:ℝ)*
        ((textbookLieDerivative f)^[j] φ) (γ 0)| ≤ C*|t|^(k+1) := by
  sorry



/-- 修正版，对应原文 MD-3.2-FiniteLieTaylor。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem lieTaylor_corrected :
  ∀ (n k : ℕ) (f : Q n → Q n) (φ : Q n → ℝ) (γ : ℝ → Q n),
    ContDiff ℝ ∞ f → ContDiff ℝ ∞ φ →
    (∀ t, HasDerivAt γ (f (γ t)) t) →
    ∃ C > 0, ∃ δ > 0, ∀ t ∈ Ioo (-δ) δ,
      |φ (γ t)-∑ j ∈ Finset.range (k+1), t^j/(Nat.factorial j:ℝ)*
        ((textbookLieDerivative f)^[j] φ) (γ 0)| ≤ C*|t|^(k+1) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.lieTaylor`；`MD.Ch03.lieTaylor_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]有限阶k+1统一局部余项是原文形式展开的额外严格有限解释，原文未明写常数C与δ。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA]f与φ取全域C∞并给定实际ODE解；不预设无限级数收敛。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]有限阶k+1统一局部余项是原文形式展开的额外严格有限解释，原文未明写常数C与δ。；[EXTRA]f与φ取全域C∞并给定实际ODE解；不预设无限级数收敛。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；相关自定义定义均已找到，不存在缺失定义。已展开 Ch03\_deps.txt 的 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean 中 Q n=Fin n→ℝ，以及 -- FILE: MolecularDynamics/Chapter03/LiePoisson.lean 中 L\_fφ(z)=Dφ(z)[f(z)]；-- FILE: MolecularDynamics/Chapter03/Statements.lean 的 lieTaylor\_statement 与 Ch03.lean 此签名相同。量词是先任取 n、k、f、φ、γ，给出全域C∞和∀t真实ODE条件，再存在依赖这些数据及k的C>0、δ>0，对所有|t|<δ给出从j=0到k、在γ(0)评价的余项界；不是一个C、δ对所有k统一成立，也没有把余项界当前提。此实际有限Taylor结论数学上合理，不需要analytic或无限级数收敛；全域光滑、全时间解比局部所需资格强。原文需要数学判断的问题明确为：PDF p.123 的实际函数等号随后被声明按formal series解释，是否允许以新增的每一有限阶实际O(|t|^(k+1))估计，作为该形式等号的完整替代陈述。原页没有这种定量不等式，而 [EXTRA] 中的余项界其实是新增结论、不是额外假设；仅“此估计为真”不足以自动认可 source-to-signature 的替代范围。本批已有的严格化待裁定问题因此保留为 NEEDS\_HUMAN。若接受全阶Taylor jet／渐近展开解释，可接受该签名作为严格版本；若要求只对应原句的形式系数，应单列形式系数与沿解时间导数的等式，将此余项定理列作辅助结果。不能据光滑性把原式静默改成实际收敛的无限和；本条没有 [ERRATUM?] 标记，本审查也不修改原书。证明状态独立记录：Ch03.lean 的 lieTaylor 函数体为 sorry；这是未完成证明，既不是此语义待裁定的理由，也不提供数学验证。

### 7. 状态与证明位置

incomplete；`MD.Ch03.lieTaylor`：未证（原书疑误不证）；`MD.Ch03.lieTaylor_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L206)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-FlowCoordinates · unnumbered_claim · 印刷p.101 / PDFp.123

### 2. 原文陈述

> This gives a concise formula for the evolution of any function of the phase variables, including, in particular, any solution component $`z_i`$. Thus the flow map of the system can be represented by $`\exp(t\mathcal L_f)`$. When one writes $`\mathcal F_t=\exp(t\mathcal L_f)`$, what is actually meant is that the individual components satisfy

$$
z_i(t,\boldsymbol\zeta)=[\mathcal F_t(\boldsymbol\zeta)]_i=\left.(\exp(t\mathcal L_f)z_i)\right|_{\boldsymbol z=\boldsymbol\zeta}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem flowCoordinates :
    ∀ (n k : ℕ) (f : Q n → Q n) (D : Set (Q n))
      (Φ : ℝ → Q n → Q n) (η : ℝ),
      ContDiff ℝ ⊤ f → actualFlow f D Φ η →
      ∀ ζ ∈ D, ∀ i : Fin n, ∃ C > 0, ∃ δ > 0, δ ≤ η ∧
        ∀ t ∈ Ioo (-δ) δ,
          |Φ t ζ i - ∑ j ∈ Finset.range (k+1),
            t^j * PowerSeries.coeff j (formalObservable f (fun z => z i) ζ)|
            ≤ C * |t|^(k+1) := by
  sorry



/-- 修正版，对应原文 MD-3.2-FlowCoordinates。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem flowCoordinates_corrected :
    ∀ (n k : ℕ) (f : Q n → Q n) (D : Set (Q n))
      (Φ : ℝ → Q n → Q n) (η : ℝ),
      ContDiff ℝ ∞ f → actualFlow f D Φ η →
      ∀ ζ ∈ D, ∀ i : Fin n, ∃ C > 0, ∃ δ > 0, δ ≤ η ∧
        ∀ t ∈ Ioo (-δ) δ,
          |Φ t ζ i - ∑ j ∈ Finset.range (k+1),
            t^j * PowerSeries.coeff j (formalObservable f (fun z => z i) ζ)|
            ≤ C * |t|^(k+1) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.flowCoordinates`；`MD.Ch03.flowCoordinates_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 有限截断阶k+1真实余项是额外严格化，原文没有此显式不等式；f全域C∞。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 有限截断阶k+1真实余项是额外严格化，原文没有此显式不等式；f全域C∞。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；相关自定义定义均已找到。已展开 Ch03\_deps.txt 的 -- FILE: MolecularDynamics/Chapter02/ReviewDefinitions.lean 中 Q n=Fin n→ℝ、-- FILE: MolecularDynamics/Chapter03/ReviewDefinitions.lean 中 formalObservable 的系数 ((L\_f)^[j]φ)(ζ)/j!，以及 -- FILE: MolecularDynamics/Chapter03/Statements.lean 中 actualFlow：0<η，且对每个ζ∈D有Φ(0,ζ)=ζ，对每个|t|<η有Φ(t,ζ)∈D并具有真实导数 f(Φ(t,ζ))。所以初值和真实ODE资格没有遗漏，也没有用形式流或目标余项代替实际流。坐标观测量φ(z)=z\_i的选取正确，常数项是ζ\_i；系数乘t^j、截至j=k，其评价点和阶数与形式exp作用于坐标一致。量词为任取n、k、f、D、Φ、η，在光滑f和actualFlow之后任取ζ∈D和i，再存在可依赖ζ、i、k的C>0、δ>0且δ≤η，界对所有|t|<δ成立；没有对所有初值、坐标、阶数的共同余项常数。该局部实际估计数学上合理，但全域C∞、共同η和D内不离域是显式选用的局部流框架，不是原文给出的全部全局流数据。[EXTRA]中的有限余项是新增结论；没有本条 [ERRATUM?]。需要数学判断的具体原文问题是：页上 z\_i(t,ζ)=[F\_t(ζ)]_i=(exp(tL\_f)z\_i)|_(z=ζ) 的实际流与形式算子的连接，在原书不讨论收敛的条件下应怎样精确解释；是否接受每个初值处、任意有限阶的局部渐近估计作为此源等式的完整对应。此签名未直接声明实际流等于某个已定义的算子作用，也没有另声明时间Taylor系数与Lie系数相等；采用Taylor jet解释可认可现有估计，要求原式逐子句对应则应另列形式jet身份，并将余项界作为辅助结果。不能以额外估计本身为真就代替对原文含义的裁定，故 NEEDS\_HUMAN，而不是因缺少定义或sorry。证明状态独立记录：Ch03.lean 的 flowCoordinates 为 sorry，尚未证明；本次只读审计未编译。

### 7. 状态与证明位置

incomplete；`MD.Ch03.flowCoordinates`：未证（原书疑误不证）；`MD.Ch03.flowCoordinates_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L235)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonBracket · definition · 印刷p.102 / PDFp.124

### 2. 原文陈述

> Another common notation for performing computations involving Hamiltonian systems is the Poisson bracket which is defined for two smooth scalar-valued functions $`g_1`$ and $`g_2`$ of the phase variables $`(\boldsymbol q,\boldsymbol p)`$ of a Hamiltonian system in $`\mathbb R^m`$ by

$$
\{g_1,g_2\}=\sum_{i=1}^{N_c}\left(\frac{\partial g_1}{\partial q_i}\frac{\partial g_2}{\partial p_i}-\frac{\partial g_2}{\partial q_i}\frac{\partial g_1}{\partial p_i}\right)=\nabla g_1^T J\nabla g_2,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def textbookPoissonBracket (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : ℝ :=
  (fderiv ℝ F z) (textbookHamiltonianVectorField G z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.textbookPoissonBracket` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；定义取 F 的真实 Fréchet 导数作用于 X\_G；X\_G=J∇G，故在原文光滑函数域上就是 ∇FᵀJ∇G。空间为 (Fin Nc⊕Fin Nc)→ℝ，维数 2Nc，未误把 Nc 当总维数。定义在非光滑函数上也有 Lean 的总化值，这只是域扩张；不声称非光滑函数有经典偏导。

### 7. 状态与证明位置

self-contained；`MD.Ch03.textbookPoissonBracket`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L265)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

