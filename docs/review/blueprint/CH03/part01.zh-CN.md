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

## 1. MD-3.2-PoissonCoordinates · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述


$$
\{g_1,g_2\}=\sum_{i=1}^{N_c}\left(\frac{\partial g_1}{\partial q_i}\frac{\partial g_2}{\partial p_i}-\frac{\partial g_2}{\partial q_i}\frac{\partial g_1}{\partial p_i}\right)=\nabla g_1^T J\nabla g_2.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem poissonCoordinates (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = ∑ i : Fin Nc,
      ((fderiv ℝ F z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ G z) (Pi.single (Sum.inr i) 1) -
      (fderiv ℝ G z) (Pi.single (Sum.inl i) 1) *
        (fderiv ℝ F z) (Pi.single (Sum.inr i) 1)) := by
  apply MolecularDynamics.textbookPoissonBracket_coordinates <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.poissonCoordinates` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,G,z 的坐标恒等式：inl 是 q，inr 是 p，求和 i:Fin Nc；第一项 F\_q G\_p，第二项 G\_q F\_p，符号及两个因子均与原式一致。fderiv 本身总是连续线性映射，所以即使未假设可微，有限维坐标展开仍成立；在原文光滑域上得到标准偏导公式。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.poissonCoordinates`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L270)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonBilinearity · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> The Poisson bracket has the following properties, which are easily verified from the definition (for $`g_1,g_2,g_3`$ being three arbitrary functions of the phase variables):
> Bilinearity $`\{g_1,\alpha g_2+\beta g_3\}=\alpha\{g_1,g_2\}+\beta\{g_1,g_3\}`$.

### 3. 原文证明

原书无独立完整证明。
> The Poisson bracket has the following properties, which are easily verified from the definition (for $`g_1,g_2,g_3`$ being three arbitrary functions of the phase variables):
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem poissonBilinearity (F G H : SymplecticCoordinates Nc → ℝ)
    (α β : ℝ) (z : SymplecticCoordinates Nc)
    (hF : DifferentiableAt ℝ F z) (hG : DifferentiableAt ℝ G z)
    (hH : DifferentiableAt ℝ H z) :
    (textbookPoissonBracket F (fun x => α*G x+β*H x) z =
      α*textbookPoissonBracket F G z+β*textbookPoissonBracket F H z) ∧
    (textbookPoissonBracket (fun x => α*F x+β*G x) H z =
      α*textbookPoissonBracket F H z+β*textbookPoissonBracket G H z) := by
  exact ⟨MolecularDynamics.textbookPoissonBracket_linear_right F G H α β z hG hH,
    MolecularDynamics.textbookPoissonBracket_linear_left F H G α β z hF hG⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.poissonBilinearity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 原文smooth函数按点可微资格显式化；保留旧清单双变量线性的完整两条结论。 | [EXTRA] |

[EXTRA] 原文smooth函数按点可微资格显式化；保留旧清单双变量线性的完整两条结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,G,H,α,β,z，分别假设三个函数在 z 可微；合取右变量与左变量的实线性。原文只显示右变量线性，额外左线性明确记录且可由反对称性推出；没有遗漏系数或错用函数顺序。逐点可微比原 smooth 弱，足以应用 fderiv 的加法与数乘规则。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.poissonBilinearity`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L281)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonSkew · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> Skew symmetry $`\{g_1,g_2\}=-\{g_2,g_1\}`$

### 3. 原文证明

原书无独立完整证明。
> The Poisson bracket has the following properties, which are easily verified from the definition (for $`g_1,g_2,g_3`$ being three arbitrary functions of the phase variables):
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem poissonSkew (F G : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) :
    textbookPoissonBracket F G z = -textbookPoissonBracket G F z := by
  apply MolecularDynamics.textbookPoissonBracket_skew <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.poissonSkew` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,G,z，无额外前提，结论 {F,G}(z)=−{G,F}(z)。项目 J 的两个非零块互为负转置，因此两个总化 fderiv 的配对也满足反对称；对非可微函数的扩张不妨碍原 smooth 域上的忠实性。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.poissonSkew`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L293)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonSelf · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> and this implies $`\{g_1,g_1\}=0`$.

### 3. 原文证明

原书无独立完整证明。
> The Poisson bracket has the following properties, which are easily verified from the definition (for $`g_1,g_2,g_3`$ being three arbitrary functions of the phase variables):
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem poissonSelf (F : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) : textbookPoissonBracket F F z = 0 := by
  apply MolecularDynamics.textbookPoissonBracket_self <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.poissonSelf` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,z，结论 {F,F}(z)=0；底域 ℝ，反对称性可推出 2{F,F}=0。与原文 and this implies 的结论一致，未增加无关域或前提。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.poissonSelf`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L299)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonJacobi · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> Jacobi identity $`\{g_1,\{g_2,g_3\}\}+\{g_3,\{g_1,g_2\}\}+\{g_2,\{g_3,g_1\}\}=0`$.

### 3. 原文证明

原书无独立完整证明。
> The Poisson bracket has the following properties, which are easily verified from the definition (for $`g_1,g_2,g_3`$ being three arbitrary functions of the phase variables):
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem poissonJacobi (F G H : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hF : ContDiffAt ℝ 2 F z)
    (hG : ContDiffAt ℝ 2 G z) (hH : ContDiffAt ℝ 2 H z) :
    textbookPoissonBracket F (textbookPoissonBracket G H) z +
      textbookPoissonBracket H (textbookPoissonBracket F G) z +
      textbookPoissonBracket G (textbookPoissonBracket H F) z = 0 := by
  apply MolecularDynamics.textbookPoissonBracket_jacobi <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.poissonJacobi` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 显式各函数在z为C²；真实二阶导数对称性支持Jacobi。 | [EXTRA] |

[EXTRA] 显式各函数在z为C²；真实二阶导数对称性支持Jacobi。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,G,H,z，每个函数在 z 为 ContDiffAt ℝ 2；三个嵌套括号的次序严格为 {F,{G,H}}+{H,{F,G}}+{G,{H,F}}。C² 局部资格足以保证内层括号可微及 Hessian 对称性，原文 smooth 可以满足；不是对任意不可微函数无条件宣称 Jacobi。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.poissonJacobi`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L305)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-HamiltonianObservableDerivative · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> More generally, if $`F(\boldsymbol q,\boldsymbol p)`$ is any smooth, scalar-valued function of the phase variables, we may write

$$
\dot F=\frac{\mathrm d}{\mathrm dt}F(\boldsymbol q(t),\boldsymbol p(t))=\{F,H\}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianObservableDerivative
    (F H : SymplecticCoordinates Nc → ℝ) (γ : ℝ → SymplecticCoordinates Nc)
    (t : ℝ) (hF : DifferentiableAt ℝ F (γ t))
    (hγ : HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t) :
    HasDerivAt (fun u => F (γ u)) (textbookPoissonBracket F H (γ t)) t := by
  exact MolecularDynamics.hasDerivAt_textbookLieDerivative
    (textbookHamiltonianVectorField H) F γ t hF hγ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hamiltonianObservableDerivative` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | smooth只需在γ(t)可微；ODE真实导数明示。 | [EXTRA] |

[EXTRA] smooth只需在γ(t)可微；ODE真实导数明示。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt 中 MolecularDynamics/Chapter02/SymplecticForm.lean 的 SymplecticCoordinates Nc=(Fin Nc ⊕ Fin Nc)→ℝ（inl 为 q、inr 为 p），textbookJ=fromBlocks 0 1 (-1) 0；Chapter02/SplittingError.lean 的 textbookHamiltonianVectorField H z=J·((DH(z))(e\_i))；Chapter03/LiePoisson.lean 的 textbookPoissonBracket F G z=DF(z)[J∇G(z)]、textbookLieDerivative f F z=DF(z)[f(z)]。Ch03.lean 同名局部定义与库定义一致。hγ是γ在t的真实导数等于J∇H(γ(t))，忠实表达Hamiltonian轨道的点态ODE；hF是smooth所需的局部可微资格。HasDerivAt结论同时给出复合函数可微及其导数为{F,H}(γ(t))。不需要额外假设H全局光滑来证明此点态链式法则；对原文光滑H当然适用。 本条无[ERRATUM?]。证明状态单独记录：Ch03.lean本条无直接sorry；所调用的相关库证明在依赖摘录中也给出了证明体。此PASS仅是签名语义判定，本任务未运行Lean编译，不据此宣称整个工程无sorry。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.hamiltonianObservableDerivative`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L315)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-HamiltonianLie · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> As a consequence, we have the following relation between the Lie derivative and the Poisson bracket:

$$
\mathcal L_{J\nabla H}F\equiv \{F,H\}.
$$


> For a Hamiltonian flow, we typically simplify notation by writing $`\mathcal L_H`$ in place of $`\mathcal L_{J\nabla H}`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianLie_eq_poisson
    (F H : SymplecticCoordinates Nc → ℝ) :
    textbookLieDerivative (textbookHamiltonianVectorField H) F =
      textbookPoissonBracket F H := by
  apply MolecularDynamics.textbookLieDerivative_hamiltonian_eq_poisson <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hamiltonianLie_eq_poisson` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,H，结论是两个相空间函数相等，故包括所有 z；左边 L_(J∇H) F，右边 {F,H}，与两个项目定义逐字展开后相同。L\_H 的简写由左边的 Hamiltonian 向量场参数实现，没有误取 {H,F}。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.hamiltonianLie_eq_poisson`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L324)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-HamiltonianCoordinateDerivative · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> In terms of the Poisson bracket, it is possible to write the differential equation corresponding to a coordinate $`q_i`$, say, as

$$
\dot q_i=\{q_i,H\}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianCoordinateDerivative
    (H : SymplecticCoordinates Nc → ℝ) (γ : ℝ → SymplecticCoordinates Nc)
    (i : Fin Nc) (t : ℝ)
    (hγ : HasDerivAt γ (textbookHamiltonianVectorField H (γ t)) t) :
    HasDerivAt (fun u => γ u (Sum.inl i))
      (textbookPoissonBracket (fun z => z (Sum.inl i)) H (γ t)) t := by
  exact hamiltonianObservableDerivative (fun z => z (Sum.inl i)) H γ t
    (differentiableAt_pi.mp differentiableAt_id (Sum.inl i)) hγ
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hamiltonianCoordinateDerivative` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt 中 MolecularDynamics/Chapter02/SymplecticForm.lean 的 SymplecticCoordinates Nc=(Fin Nc ⊕ Fin Nc)→ℝ（inl 为 q、inr 为 p），textbookJ=fromBlocks 0 1 (-1) 0；Chapter02/SplittingError.lean 的 textbookHamiltonianVectorField H z=J·((DH(z))(e\_i))；Chapter03/LiePoisson.lean 的 textbookPoissonBracket F G z=DF(z)[J∇G(z)]、textbookLieDerivative f F z=DF(z)[f(z)]。Ch03.lean 同名局部定义与库定义一致。观测量固定为z↦z(Sum.inl i)，而非任意F；HasDerivAt轨道坐标函数给出q̇_i={q\_i,H}。hγ明示原文隐含Hamiltonian方程；坐标函数自动可微，无遗漏假设或结论。 本条无[ERRATUM?]。证明状态单独记录：Ch03.lean本条无直接sorry；所调用的相关库证明在依赖摘录中也给出了证明体。此PASS仅是签名语义判定，本任务未运行Lean编译，不据此宣称整个工程无sorry。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.hamiltonianCoordinateDerivative`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L331)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-HamiltonianLieAdditivity · unnumbered_claim · 印刷p.103 / PDFp.125

### 2. 原文陈述

> As the relation

$$
\mathcal L_H\phi=\{\phi,H\}
$$


> is linear in $`H`$, we may write, for Hamiltonians $`H_1,H_2`$,

$$
\mathcal L_{H_1+H_2}=\mathcal L_{H_1}+\mathcal L_{H_2}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianLieAdditivity (F H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (z : SymplecticCoordinates Nc) (hH₁ : DifferentiableAt ℝ H₁ z)
    (hH₂ : DifferentiableAt ℝ H₂ z) :
    textbookLieDerivative (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x)) F z =
      textbookLieDerivative (textbookHamiltonianVectorField H₁) F z +
      textbookLieDerivative (textbookHamiltonianVectorField H₂) F z := by
  apply MolecularDynamics.textbookHamiltonianLieDerivative_add <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hamiltonianLieAdditivity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | H₁,H₂在z可微；原文smooth资格显式化。 | [EXTRA] |

[EXTRA] H₁,H₂在z可微；原文smooth资格显式化。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀F,H₁,H₂,z，仅需 H₁,H₂ 在 z 可微；结论逐点为 L_(X_(H₁+H₂))F=L_(X\_H₁)F+L_(X\_H₂)F。fderiv H 的加法给出向量场加法，再由 fderiv F 的线性推出，F 即使没有可微前提也可使用总化导数，原文光滑对象当然涵盖。全称 F,z 对应算子等式。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.hamiltonianLieAdditivity`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L342)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-FormalSplitting · definition · 印刷p.103 / PDFp.125

### 2. 原文陈述

> The flow map of the system with Hamiltonian $`H=H_1+H_2`$ is

$$
\mathcal F_t=e^{t(\mathcal L_{H_1}+\mathcal L_{H_2})}.
$$


> On the other hand, the splitting method based on a composition of flows on $`H_1`$ and $`H_2`$ is

$$
\mathcal G_h=e^{h\mathcal L_{H_1}}e^{h\mathcal L_{H_2}}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def formalSplitting {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential A * textbookFormalOperatorExponential B

def formalExactSplit {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential (A+B)

def hamiltonianSplittingObservable {n : ℕ}
    (A B φ : SymplecticCoordinates n → ℝ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun k ↦ ∑ i ∈ Finset.range (k+1),
    ((textbookLieDerivative (textbookHamiltonianVectorField A))^[i]
      ((textbookLieDerivative (textbookHamiltonianVectorField B))^[k-i] φ)) z /
      ((Nat.factorial i : ℝ)*(Nat.factorial (k-i) : ℝ)))

def hamiltonianExactObservable {n : ℕ}
    (A B φ : SymplecticCoordinates n → ℝ) (z : SymplecticCoordinates n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j ↦
    ((textbookLieDerivative (textbookHamiltonianVectorField (fun x ↦ A x+B x)))^[j] φ) z /
      (Nat.factorial j : ℝ))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.formalSplitting`；`MD.Ch03.formalExactSplit`；`MD.Ch03.hamiltonianSplittingObservable`；`MD.Ch03.hamiltonianExactObservable` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 同时保留精确形式exp(A+B)及分裂形式expA expB，并用真实Hamiltonian Lie导数的卷积系数实例连接A=L\_H1、B=L\_H2；仅形式系数，不宣称解析收敛。 | [EXTRA] |

[EXTRA] [EXTRA] 同时保留精确形式exp(A+B)及分裂形式expA expB，并用真实Hamiltonian Lie导数的卷积系数实例连接A=L\_H1、B=L\_H2；仅形式系数，不宣称解析收敛。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；formalExactSplit 在任意实结合环代数中取 exp(A+B)，formalSplitting 取 exp(A)exp(B)，未增加 AB=BA。指数第 j 系数为 A^j/j!。Hamiltonian 实例的 split 系数为 Σ_(i=0)^k (L\_A^i L\_B^(k−i)φ)(z)/(i!(k−i)!)，顺序与原显示一致；exact 实例为 L_(A+B)^jφ/j!。这些是定义，不是关于所有非光滑函数的算子加法定理；在原文光滑域用第14条连接。状态流与 pullback 的组合顺序不同，当前定义采用原文形式算子顺序，并未错误声称相反状态组合。

### 7. 状态与证明位置

self-contained；`MD.Ch03.formalSplitting`：定义；`MD.Ch03.formalExactSplit`：定义；`MD.Ch03.hamiltonianSplittingObservable`：定义；`MD.Ch03.hamiltonianExactObservable`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L352)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-ExactExponentialCubic · unnumbered_claim · 印刷p.103 / PDFp.125

### 2. 原文陈述

> Expanding these out using the exponential series we have

$$
\begin{aligned}e^{h(A+B)}&=\mathrm{Id}+h(A+B)+\frac{h^2}{2}(A+B)^2+\frac{h^3}{6}(A+B)^3+O(h^4)\\ &=\mathrm{Id}+h(A+B)+\frac{h^2}{2}(AB+BA+A^2+B^2)\\ &\quad+\frac{h^3}{6}(A^3+A^2B+AB^2+ABA+B^2A+BA^2+BAB+B^3)+O(h^4),\end{aligned}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem exactExponentialCubic (A B : R) :
    (∀ j < 4, PowerSeries.coeff j (textbookFormalOperatorExponential (A+B)) =
      (1/(j.factorial : ℝ)) • (A+B)^j) ∧
    ((A+B)^2 = A*B+B*A+A^2+B^2) ∧
    ((A+B)^3 = A^3+A^2*B+A*B^2+A*B*A+B^2*A+B*A^2+B*A*B+B^3) := by
  refine ⟨fun j _ => textbookFormalOperatorExponential_coeff (A+B) j, ?_, ?_⟩
  · noncomm_ring
  · noncomm_ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.exactExponentialCubic` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意实结合环代数的 A,B，不设交换性；∀j<4 给出 exp(A+B) 的系数，另合取平方的四个词和立方的八个词展开。常数与一次系数由 j=0,1 实例得到，平方与立方恰对应 1/2、1/6，八个词各出现一次。PowerSeries 语境中余项的次数至少四，不暗中断言范数 O(h⁴) 或解析收敛。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.exactExponentialCubic`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L372)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-ProductExponentialCubic · unnumbered_claim · 印刷p.104 / PDFp.126

### 2. 原文陈述

> whereas,

$$
\begin{aligned}e^{hA}e^{hB}&=(\mathrm{Id}+hA+\frac{h^2A^2}{2}+\frac{h^3A^3}{6}+O(h^4))\times(\mathrm{Id}+hB+\frac{h^2B^2}{2}+\frac{h^3B^3}{6}+O(h^4))\\ &=\mathrm{Id}+h(A+B)+\frac{h^2}{2}(2AB+A^2+B^2)+\frac{h^3}{6}(A^3+B^3+3AB^2+3A^2B)+O(h^4).\end{aligned}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem productExponentialCubic (A B : R) :
    PowerSeries.coeff 0 (formalSplitting A B)=1 ∧
    PowerSeries.coeff 1 (formalSplitting A B)=A+B ∧
    PowerSeries.coeff 2 (formalSplitting A B)=
      (1/2:ℝ) • A^2+A*B+(1/2:ℝ) • B^2 ∧
    PowerSeries.coeff 3 (formalSplitting A B)=
      (1/6:ℝ) • A^3+(1/2:ℝ) • (A^2*B)+(1/2:ℝ) • (A*B^2)+(1/6:ℝ) • B^3 := by
  exact ⟨textbookFormalOperatorProduct_coeff_zero A B,
    textbookFormalOperatorProduct_coeff_one A B,
    textbookFormalOperatorProduct_coeff_two A B,
    textbookFormalOperatorProduct_coeff_three A B⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.productExponentialCubic` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；审阅Ch03.lean:259–269。MD.Ch03.formalSplitting A B展开为textbookFormalOperatorExponential A * textbookFormalOperatorExponential B；FormalOperatorSeries.lean把后者指数定义为PowerSeries.mk(n↦(1/(n! : ℝ))•A^n)，两个因子的低次展开由定义确定，乘法是真实的形式Cauchy乘积。R为任意实结合环代数，不预设交换；1\_R对应Id，形式变量对应h。四个合取覆盖系数0、1、2、3：1，A+B，A²/2+AB+B²/2，A³/6+A²B/2+AB²/2+B³/6。它们分别等于原页(2AB+A²+B²)/2及(A³+B³+3AB²+3A²B)/6，只有加法项的排列变化，没有把AB改成BA或改变因子顺序。所有低于4次的项都已包括，形式O(h⁴)解释充分，不涉及收敛。无[EXTRA]、[ERRATUM?]。证明状态另记：调用FormalOperatorSeries.lean四个Product\_coeff引理，本条与相应引理未见sorry；此次未编译，不以证明状态代替签名审计。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.productExponentialCubic`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L382)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-DifferenceCommutator · unnumbered_claim · 印刷p.104 / PDFp.126

### 2. 原文陈述

> So the difference is

$$
\begin{aligned}e^{hA}e^{hB}-e^{h(A+B)}&=\frac{h^2}{2}(AB-BA)\\&\quad+\frac{h^3}{6}(2AB^2+2A^2B-BA^2-BAB-B^2A-ABA)+O(h^4)\\&=\frac{h^2}{2}[A,B]+O(h^3),\end{aligned}
$$


> where $`[A,B]=AB-BA`$ is the commutator of $`A`$ and $`B`$.
> For a splitting method, we have, replacing $`A`$ by $`\mathcal L_{H_1}`$ and $`B`$ by $`\mathcal L_{H_2}`$,

$$
e^{h\mathcal L_{H_1}}e^{h\mathcal L_{H_2}}-e^{h\mathcal L_H}=\frac{h^2}{2}[\mathcal L_{H_1},\mathcal L_{H_2}]+O(h^3).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem differenceCommutator (A B : R) :
    PowerSeries.coeff 0 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = 0 ∧
    PowerSeries.coeff 1 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = 0 ∧
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = (1/2 : ℝ) • (A*B-B*A) := by
  sorry

theorem differenceCommutator_coeff2 (A B : R) :
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 2 : ℝ) • (A * B - B * A) := by
  apply MolecularDynamics.textbookFormalOperatorDifference_coeff_two <;> assumption

theorem differenceCommutator_hamiltonian (n : ℕ)
    (A B φ : SymplecticCoordinates n → ℝ)
    (_hA : ContDiff ℝ ∞ A) (_hB : ContDiff ℝ ∞ B) (_hφ : ContDiff ℝ ∞ φ)
    (z : SymplecticCoordinates n) :
    let S := hamiltonianSplittingObservable A B φ z-hamiltonianExactObservable A B φ z
    PowerSeries.coeff 0 S = 0 ∧ PowerSeries.coeff 1 S = 0 ∧
    PowerSeries.coeff 2 S = (1/2 : ℝ)*
      (textbookLieDerivative (textbookHamiltonianVectorField A)
        (textbookLieDerivative (textbookHamiltonianVectorField B) φ) z -
       textbookLieDerivative (textbookHamiltonianVectorField B)
        (textbookLieDerivative (textbookHamiltonianVectorField A) φ) z) := by
  sorry

theorem differenceCommutator_coeff3 (A B : R) :
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) =
      (1/6 : ℝ) • ((2 : ℝ) • (A*B^2)+(2 : ℝ) • (A^2*B)-
        B*A^2-B*A*B-B^2*A-A*B*A) := by
  rw [map_sub, textbookFormalOperatorProduct_coeff_three,
    textbookFormalOperatorExponential_coeff]
  norm_num
  have hp : (A+B)^3 = A^3+A^2*B+A*B*A+A*B^2+
      B*A^2+B*A*B+B^2*A+B^3 := by noncomm_ring
  rw [hp]
  module

theorem differenceCommutator_hamiltonian_coeff3 (n : ℕ)
    (A B φ : SymplecticCoordinates n → ℝ)
    (_hA : ContDiff ℝ ∞ A) (_hB : ContDiff ℝ ∞ B) (_hφ : ContDiff ℝ ∞ φ)
    (z : SymplecticCoordinates n) :
    let LA := textbookLieDerivative (textbookHamiltonianVectorField A)
    let LB := textbookLieDerivative (textbookHamiltonianVectorField B)
    PowerSeries.coeff 3 (hamiltonianSplittingObservable A B φ z-
      hamiltonianExactObservable A B φ z) = (1/6 : ℝ)*
      (2*LA (LB (LB φ)) z+2*LA (LA (LB φ)) z-
        LB (LA (LA φ)) z-LB (LA (LB φ)) z-LB (LB (LA φ)) z-LA (LB (LA φ)) z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.differenceCommutator`；`MD.Ch03.differenceCommutator_coeff2`；`MD.Ch03.differenceCommutator_hamiltonian`；`MD.Ch03.differenceCommutator_coeff3`；`MD.Ch03.differenceCommutator_hamiltonian_coeff3` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式合取零次/一次/二次及本条三次系数，完整保留所引形式余项阶；原已证单系数定理保留为辅助并重查。新增完整陈述暂sorry。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留零至二次结论；补一般非交换代数三次系数及Hamilton算子实例。原JSON恢复印刷p.104/PDF126的三次项和O(h⁴)展示式，已视觉复核原页。一般三次系数尝试有限代数展开证明；Hamilton算子实例尚未证明，最终逐声明状态以本地核验日志为准。 | [EXTRA] |

[EXTRA] [EXTRA] 显式合取零次/一次/二次及本条三次系数，完整保留所引形式余项阶；原已证单系数定理保留为辅助并重查。新增完整陈述暂sorry。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[EXTRA] 保留零至二次结论；补一般非交换代数三次系数及Hamilton算子实例。原JSON恢复印刷p.104/PDF126的三次项和O(h⁴)展示式，已视觉复核原页。一般三次系数尝试有限代数展开证明；Hamilton算子实例尚未证明，最终逐声明状态以本地核验日志为准。

### 6. 审计结论

本轮修复：保留零至二次结论；补一般非交换代数三次系数及Hamilton算子实例。原JSON恢复印刷p.104/PDF126的三次项和O(h⁴)展示式，已视觉复核原页。一般三次系数尝试有限代数展开证明；Hamilton算子实例尚未证明，最终逐声明状态以本地核验日志为准。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；已逐一核对 differenceCommutator、differenceCommutator\_coeff2 与 differenceCommutator\_hamiltonian。一般代数版包含差的零、一次系数为零及二次系数 (AB−BA)/2；辅助版仅二次系数；Hamiltonian 版在 n 自由度、A,B,φ 全域 C∞ 下对所有 z 给出同样三项，右边是 (L\_A L\_Bφ−L\_B L\_Aφ)(z)/2。它们正确覆盖 JSON 当前摘录的 O(h³) 结论。但 [EXTRA] 明确声称还包含三次系数，三份声明均没有该项；原页同一个差的展示式还给出三次项及 O(h⁴)，JSON 将该行省略。不能把二次系数辅助定理当作三次结论。

### 7. 状态与证明位置

incomplete；`MD.Ch03.differenceCommutator`：未证（缺大型理论）；`MD.Ch03.differenceCommutator_coeff2`：已证；`MD.Ch03.differenceCommutator_hamiltonian`：未证（缺大型理论）；`MD.Ch03.differenceCommutator_coeff3`：已证；`MD.Ch03.differenceCommutator_hamiltonian_coeff3`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L398)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-DifferenceCubic · unnumbered_claim · 印刷p.104 / PDFp.126

### 2. 原文陈述


$$
e^{hA}e^{hB}-e^{h(A+B)}=\frac{h^2}{2}(AB-BA)+\frac{h^3}{6}(2AB^2+2A^2B-BA^2-BAB-B^2A-ABA)+O(h^4).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem differenceCubic (A B : R) :
    PowerSeries.coeff 0 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = 0 ∧
    PowerSeries.coeff 1 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = 0 ∧
    PowerSeries.coeff 2 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = (1/2 : ℝ) • (A*B-B*A) ∧
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A+B)) = (1 / 6 : ℝ) • ((2 : ℝ) • (A * B ^ 2) + (2 : ℝ) • (A ^ 2 * B) -
        B * A ^ 2 - B * A * B - B ^ 2 * A - A * B * A) := by
  sorry

theorem differenceCubic_coeff3 (A B : R) :
    PowerSeries.coeff 3 (textbookFormalOperatorExponential A *
      textbookFormalOperatorExponential B - textbookFormalOperatorExponential (A + B)) =
      (1 / 6 : ℝ) • ((2 : ℝ) • (A * B ^ 2) + (2 : ℝ) • (A ^ 2 * B) -
        B * A ^ 2 - B * A * B - B ^ 2 * A - A * B * A) := by
  apply MolecularDynamics.textbookFormalOperatorDifference_coeff_three <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.differenceCubic`；`MD.Ch03.differenceCubic_coeff3` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 显式合取零次/一次/二次及本条三次系数，完整保留所引形式余项阶；原已证单系数定理保留为辅助并重查。新增完整陈述暂sorry。 | [EXTRA] |

[EXTRA] [EXTRA] 显式合取零次/一次/二次及本条三次系数，完整保留所引形式余项阶；原已证单系数定理保留为辅助并重查。新增完整陈述暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：differenceCubic对任意环境实代数中的A、B，合取差式0、1次系数为0、2次系数为(AB−BA)/2及完整3次六项系数；differenceCubic\_coeff3是同一3次等式的辅助声明。项目指数定义的第n项为A^n/n!，乘法次序为先A后B；没有交换性前提。形式O(h^4)恰为0至3次这些系数约束，不涉及解析收敛。[EXTRA]增加低次合取恢复了完整差式，合理。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

incomplete；`MD.Ch03.differenceCubic`：未证（缺大型理论）；`MD.Ch03.differenceCubic_coeff3`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L451)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-HamiltonianCommutator · unnumbered_claim · 印刷p.104–105 / PDFp.126–127

### 2. 原文陈述

> Observe that, for any real-valued functions $`f`$ and $`H`$ of phase space,

$$
\mathcal L_Hf=\nabla f^TJ\nabla H=\{f,H\}.
$$


> Hence $`\mathcal L_{H_1}\mathcal L_{H_2}f=\{\{f,H_2\},H_1\}`$, and, using this and skew-symmetry of the Poisson bracket,

$$
[\mathcal L_{H_1},\mathcal L_{H_2}]f=\{\{f,H_2\},H_1\}-\{\{f,H_1\},H_2\}=\{\{f,H_2\},H_1\}+\{\{H_1,f\},H_2\}.
$$


> By the Jacobi identity, $`\{\{f,H_2\},H_1\}+\{\{H_2,H_1\},f\}+\{\{H_1,f\},H_2\}=0`$.
> Therefore

$$
[\mathcal L_{H_1},\mathcal L_{H_2}]f=-\{\{H_2,H_1\},f\}=\{f,\{H_2,H_1\}\}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem hamiltonianCommutator
    (F H₁ H₂ : SymplecticCoordinates Nc → ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiffAt ℝ 2 F z) (hH₁ : ContDiffAt ℝ 2 H₁ z)
    (hH₂ : ContDiffAt ℝ 2 H₂ z) :
    textbookLieDerivative (textbookHamiltonianVectorField H₁)
        (textbookLieDerivative (textbookHamiltonianVectorField H₂) F) z -
      textbookLieDerivative (textbookHamiltonianVectorField H₂)
        (textbookLieDerivative (textbookHamiltonianVectorField H₁) F) z =
      textbookLieDerivative (textbookHamiltonianVectorField
        (textbookPoissonBracket H₂ H₁)) F z := by
  apply MolecularDynamics.textbookHamiltonianLieDerivative_commutator <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hamiltonianCommutator` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | F,H₁,H₂在z为C²；原文smooth资格显式化。 | [EXTRA] |

[EXTRA] F,H₁,H₂在z为C²；原文smooth资格显式化。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；审阅Ch03.lean:288–298。依赖SymplecticForm.lean中相空间是q、p标记的有限维实坐标，textbookJ=[0,I;-I,0]；SplittingError.lean的Hamiltonian场是J乘实际Fréchet导数的坐标梯度。LiePoisson.lean及本文件的textbookLieDerivative f F z均为DF(z)[f(z)]，textbookPoissonBracket G H z=DG(z)[J∇H(z)]，即{G,H}，不是顺序倒置的定义。故本声明左边确为L\_H₁L\_H₂F−L\_H₂L\_H₁F，右边确为{F,{H₂,H₁}}。它对任意Nc、F、H₁、H₂、z及局部C²假设量化，完整对应原文跨页推导的最终结论；第一识别、反对称及Jacobi等中间行是该结论的推导步骤，不是被改成假设。所用实际定义给出L\_HF={F,H}，依赖中skew与Jacobi也按此J约定展开，未省略独立的结论。[EXTRA] 三个ContDiffAt ℝ 2是自然且充分的局部正则资格，使嵌套导数及Hessian对称可用；原文smooth情形满足这些资格，不引入解析性、全局流或结论本身。C²是充分条件，不主张它对每组特例都是最弱条件。本条无[ERRATUM?]，它对应PDF127第一式的正确顺序；紧接的印刷反序公式另属本批下一条。证明状态另记：本条调用textbookHamiltonianLieDerivative\_commutator，其依赖证明使用实际二阶导数和Hessian对称，本条及相应引理未见sorry；此次未编译。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.hamiltonianCommutator`：已证。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L468)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-HamiltonianCommutatorPrinted · unnumbered_claim · 印刷p.105 / PDFp.127

### 2. 原文陈述

> This means that it is possible to relate the commutator of Lie derivatives of Hamiltonian vector fields to the Lie derivative of the Poisson bracket of the corresponding Hamiltonians, i.e.,

$$
[\mathcal L_{H_1},\mathcal L_{H_2}]f=\mathcal L_{\{H_1,H_2\}}f.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem leadingShadowPrinted :
  ∀ (n : ℕ) (A B F : SymplecticCoordinates n → ℝ), ContDiff ℝ 2 A →
    ContDiff ℝ 2 B → ContDiff ℝ 2 F → ∀ z,
    hamiltonianLie A (hamiltonianLie B F) z-hamiltonianLie B (hamiltonianLie A F) z=
      hamiltonianLie (textbookPoissonBracket A B) F z := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.leadingShadowPrinted` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | F,H₁,H₂取C²，原文smooth资格明示。 | [EXTRA] |

[EXTRA] F,H₁,H₂取C²，原文smooth资格明示。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；签名忠实性PASS，原命题的数学真伪另外判为错误，二者不混同。审阅Ch03.lean:303–308，并展开Ch03\_deps.txt中ReviewDefinitions.lean的hamiltonianLie H φ=textbookLieDerivative (textbookHamiltonianVectorField H) φ；LiePoisson.lean中textbookLieDerivative f φ z=Dφ(z)[f(z)]、textbookPoissonBracket A B z=DA(z)[J∇B(z)]；SplittingError.lean实际场为J梯度，SymplecticForm.lean实际J=[0,I;-I,0]，相空间为(Fin n ⊕ Fin n)→ℝ。因而∀n,A,B,F，C² A→C² B→C² F→∀z的结论实际就是[L\_A,L\_B]F(z)=L_{ {A,B} }F(z)，与本条印刷式逐项一致，未暗改为正确的{B,A}。[EXTRA] 全局ContDiff ℝ 2是对原文smooth资格的合理充分表达，保证任意z的二阶计算；它比逐点资格强，但符合全空间∀z的陈述，且不能挽救下述光滑多项式反例。[ERRATUM?]确实成立：按这些实际定义正确公式是[L\_A,L\_B]F=L_{ {B,A} }F=−L_{ {A,B} }F。因此PASS仅表示签名忠实于所冻结的印刷来源，绝不表示该错误印刷断言可以证明。证明状态另记：本条证明体显式为sorry；没有把sorry当作签名不忠实的理由，也没有把它当作原书错误的验证。实际反例独立确立原式为假。此次未编译或补证明。

### 7. 状态与证明位置

incomplete；`MD.Ch03.leadingShadowPrinted`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L483)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-LeadingModifiedExponential · unnumbered_claim · 印刷p.105 / PDFp.127

### 2. 原文陈述

> Because of this, we may interpret the first term in the expansion of the error as itself being derived from a Hamiltonian. This is a crucial observation which suggests an alternative perspective on the error expansion in splitting. The idea is to view the product of exponentials as an exponential:

$$
e^{hA}e^{hB}=e^{h(A+B+hR)},
$$


> for some operator $`R`$. Expanding out the right hand side gives

$$
\begin{aligned}e^{h(A+B+hR)}&=\mathrm{Id}+h(A+B+hR)+\frac{h^2}{2}(A+B+hR)^2+\cdots\\ &=\mathrm{Id}+hA+hB+h^2R+\frac{h^2}{2}\bigl(A^2+AB+BA+B^2+h^2R^2+h(A+B)R+hR(A+B)\bigr)+\cdots.\end{aligned}
$$


> Comparing this to our expansion for $`e^{hA}e^{hB}`$, for agreement to $`O(h^2)`$ we must have

$$
\frac12(2AB+A^2+B^2)=R+\frac12(A^2+AB+BA+B^2)=O(h),
$$


> or

$$
R=AB-\frac12(AB+BA)=\frac12[A,B]+O(h),
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem leadingModifiedExponential (A B : R) (n : ℕ) (hn : n < 3) :
    PowerSeries.coeff n
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) =
      PowerSeries.coeff n
        (textbookFormalModifiedExponential A B ((1 / 2 : ℝ) • (A * B - B * A))) := by
  sorry



/-- 修正版，对应原文 MD-3.3-LeadingModifiedExponential。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem leadingModifiedExponential_corrected (A B : R) (n : ℕ) (hn : n < 3) :
    PowerSeries.coeff n
      (textbookFormalOperatorExponential A * textbookFormalOperatorExponential B) =
      PowerSeries.coeff n
        (textbookFormalModifiedExponential A B ((1 / 2 : ℝ) • (A * B - B * A))) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.leadingModifiedExponential`；`MD.Ch03.leadingModifiedExponential_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；C：A、B属于同一实代数；n为自然数且n<3，即全部低于3次的系数相等。modifiedGenerator为(A+B)X+CX²；textbookFormalZeroConstantExponential确为零常项形式级数的指数，故C=(AB−BA)/2时结论正确。没有假设完整R(h)存在，更未形式化原书错误的系数比较链。context已披露该限制，但extra\_assumptions空列表未列出这一范围缩减；整段原文的数学问题需人工保留处理。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

incomplete；`MD.Ch03.leadingModifiedExponential`：未证（原书疑误不证）；`MD.Ch03.leadingModifiedExponential_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L493)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-LeadingShadowHamiltonian · unnumbered_claim · 印刷p.105 / PDFp.127

### 2. 原文陈述

> and from this it follows that

$$
e^{h\mathcal L_{H_1}}e^{h\mathcal L_{H_2}}=e^{h\mathcal L_G},
$$


> where

$$
G=H_1+H_2+\frac h2\{H_1,H_2\}+O(h^2).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem leadingShadowHamiltonian :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D K : Set (SymplecticCoordinates n))
    (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → IsCompact K → K ⊆ D → ContDiffOn ℝ ⊤ A D → ContDiffOn ℝ ⊤ B D →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
      ∀ h ∈ Ioo 0 δ, ∀ z ∈ K, Γ h z 0=z ∧
        solution (textbookHamiltonianVectorField (fun x => A x+B x+h/2*textbookPoissonBracket A B x)) (Γ h z) 0 h ∧
        ‖Φ h (Ψ h z)-Γ h z h‖ ≤ C*h^3 := by
  sorry



/-- 修正版，对应原文 MD-3.3-LeadingShadowHamiltonian。改动：默认保留状态复合Φ_h∘Ψ_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL_B)exp(hL_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。 -/
```

独立修正版：

```lean
theorem leadingShadowHamiltonian_corrected :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D K : Set (SymplecticCoordinates n))
    (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → IsCompact K → K ⊆ D → ContDiffOn ℝ ∞ A D → ContDiffOn ℝ ∞ B D →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    ∃ C > 0, ∃ δ > 0, ∃ Γ : ℝ → SymplecticCoordinates n → ℝ → SymplecticCoordinates n,
      ∀ h ∈ Ioo 0 δ, ∀ z ∈ K, Γ h z 0=z ∧
        solution (textbookHamiltonianVectorField (fun x => A x+B x+h/2*textbookPoissonBracket A B x)) (Γ h z) 0 h ∧
        ‖Φ h (Ψ h z)-Γ h z h‖ ≤ C*h^3 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.leadingShadowHamiltonian`；`MD.Ch03.leadingShadowHamiltonian_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | D开放、K紧且K⊆D、A/B在D无限可微并给定真实局部流；实际修正ODE解及O(h³)端点余项为结论。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 默认保留状态复合Φ\_h∘Ψ\_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL\_B)exp(hL\_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。 | [EXTRA] |

[EXTRA] D开放、K紧且K⊆D、A/B在D无限可微并给定真实局部流；实际修正ODE解及O(h³)端点余项为结论。；[ERRATUM?] 默认保留状态复合Φ\_h∘Ψ\_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL\_B)exp(hL\_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已读取 Ch03.lean 实际声明和 Ch03\_deps.txt 对应 -- FILE 段，审计针对签名语义；该 theorem 的证明体为 sorry，不据此判断签名 PASS/FAIL，亦不声称已获 Lean 验证。依赖展开：SymplecticCoordinates n=(Fin n ⊕ Fin n)→ℝ，inl 为 q、inr 为 p；textbookJ=[[0,I],[-I,0]]；X\_H=textbookHamiltonianVectorField H=J∇H；textbookPoissonBracket F G=DF(X\_G)=Σ(F\_q G\_p−G\_q F\_p)。actualFlow f D Φ η 展开为 η>0，且每个 z∈D 有 Φ(0,z)=z，对全部 |t|<η 有 Φ(t,z)∈D 和时间方向 HasDerivAt Φ(·,z) f(Φ(t,z)) t；未把复合相等或匹配放进假设。solution f γ 0 h 展开为在整个闭区间 [0,h] 的 HasDerivWithinAt γ (f(γ(t)))。按原页及 PDF124/印刷102 的 L\_H F={F,H}，exp(hL\_A) 是 Φ\_A 的 pullback；exp(hL\_A)exp(hL\_B)F=F∘Ψ\_B∘Φ\_A，而 Lean 端点是 Φ\_A∘Ψ\_B。实际 [L\_A,L\_B]=L_{ {B,A} }=−L_{ {A,B} }，PDF127 顶部第一式也给出 {B,A}，紧接的第二式却改成 {A,B}，故该原书符号疑误可确定。Lean 的正号 Hamiltonian 对 Φ\_A∘Ψ\_B 是合理的，但这不是所引原文算子等式的逐义形式化。 [EXTRA] 开放域和无限光滑保证局部 ODE 唯一及 Taylor 控制，紧 K⊆D 用于统一 C、δ，均合理；无限光滑高于此低阶估计所需但符合原书 smooth 语境。actualFlow 要求全 D 统一时间且保持 D，是强于普通局部流的实质限制，应披露；不能仅解释为给定一点的局部流。结论 C、δ、Γ 先于 h,z，确为统一端点 O(h³)，但只是首阶截断的有限近似，并非原文全部形式等式。

### 7. 状态与证明位置

incomplete；`MD.Ch03.leadingShadowHamiltonian`：未证（原书疑误不证）；`MD.Ch03.leadingShadowHamiltonian_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L518)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-BCH4 · unnumbered_claim · 印刷p.106 / PDFp.128

### 2. 原文陈述

> Higher order terms can also be worked out, for example,

$$
e^Ae^B=\exp\left(A+B+\frac12[A,B]+\frac1{12}([A,[A,B]]-[B,[A,B]])-\frac1{24}[B,[A,[A,B]]]+\cdots\right).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem bch4 :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R), ∀ j < 5,
    PowerSeries.coeff j (formalLog (formalSplitting A B))=PowerSeries.coeff j (bchLog4 A B) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.bch4` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已读取 Ch03.lean 实际声明和 Ch03\_deps.txt 对应 -- FILE 段，审计针对签名语义；该 theorem 的证明体为 sorry，不据此判断签名 PASS/FAIL，亦不声称已获 Lean 验证。 依赖 formalSplitting=exp(XA)exp(XB)，指数系数 A^n/n!；formalLog 的第 n 系数为 Σ_{j=1}^n (−1)^{j+1}coeff\_n((P−1)^j)/j，formalSplitting 常数项1使该有限和是真实形式 log。commutator A B=AB−BA；bchLog4 的次数1、2、3、4分别是 A+B、[A,B]/2、([A,[A,B]]−[B,[A,B]])/12、−[B,[A,[A,B]]]/24，其余次数0。∀j<5 包括零次零系数并逐一覆盖全部展示阶；任意非交换实代数允许这些实标量，无多余交换性假设，不主张级数收敛。

### 7. 状态与证明位置

incomplete；`MD.Ch03.bch4`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L548)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-BCHHamiltonian · definition · 印刷p.106 / PDFp.128

### 2. 原文陈述

> and, using the correspondence between Lie and Poisson brackets,

$$
e^{h\mathcal L_{H_1}}e^{h\mathcal L_{H_2}}=e^{h\mathcal L_{\widetilde H_h}},
$$


> where

$$
\widetilde H_h=H_1+H_2+\frac h2\{H_1,H_2\}+\frac{h^2}{12}\bigl(\{H_1,\{H_1,H_2\}\}-\{H_2,\{H_1,H_2\}\}\bigr)-\frac{h^3}{24}\{H_2,\{H_1,\{H_1,H_2\}\}\}+\cdots.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bchHamiltonian3 {n : ℕ} (A B : SymplecticCoordinates n → ℝ) (h : ℝ) (z : SymplecticCoordinates n) : ℝ :=
  A z+B z+h/2*textbookPoissonBracket A B z+
    h^2/12*(textbookPoissonBracket A (textbookPoissonBracket A B) z-
      textbookPoissonBracket B (textbookPoissonBracket A B) z)-
    h^3/24*textbookPoissonBracket B (textbookPoissonBracket A (textbookPoissonBracket A B)) z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.bchHamiltonian3` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已核对 Ch03.lean 的本地 def 及依赖同名定义；本条没有 theorem 证明体，也无 sorry。依赖展开：SymplecticCoordinates n=(Fin n ⊕ Fin n)→ℝ，inl 为 q、inr 为 p；textbookJ=[[0,I],[-I,0]]；X\_H=textbookHamiltonianVectorField H=J∇H；textbookPoissonBracket F G=DF(X\_G)=Σ(F\_q G\_p−G\_q F\_p)。 展开后 bchHamiltonian3 逐点等于原页到 h³ 的有限函数：常数 A+B，h 项 {A,B}/2，h² 项两重括号之差 /12，h³ 项三重括号负 /24。n 隐式任意，A、B、h、z 全部参数对应原文。按本条 context\_notation 明示范围，省略号及指数匹配不作为定义的结论；本 PASS 是有限印刷函数的忠实定义，不为原文指数关系背书。无 [EXTRA]。虽允许非光滑函数，fderiv 在不可微点的全定义扩展只是 Lean 函数定义的扩大定义域；在原文光滑对象上公式一致。原页算子关系存在前述符号疑误，有限函数本身仍如实保存印刷正负号。

### 7. 状态与证明位置

self-contained；`MD.Ch03.bchHamiltonian3`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L554)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-BCHHamiltonianMatching · unnumbered_claim · 印刷p.106 / PDFp.128

### 2. 原文陈述

> We refer to this series as the modified (also perturbed, shadow) Hamiltonian corresponding to the splitting method. The implication of the series is that the numerical method may be viewed as being equivalent to the exact solution of a nearby Hamiltonian system, although we have not addressed the convergence of the expansion.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem bchHamiltonianMatching :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D K : Set (SymplecticCoordinates n))
    (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → IsCompact K → K ⊆ D → ContDiffOn ℝ ⊤ A D → ContDiffOn ℝ ⊤ B D →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    matchesHamiltonian (bchHamiltonian3 A B) (fun h => Φ h ∘ Ψ h) K 4 := by
  sorry



/-- 修正版，对应原文 MD-3.3-BCHHamiltonianMatching。改动：默认保留状态复合Φ_h∘Ψ_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL_B)exp(hL_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。 -/
```

独立修正版：

```lean
theorem bchHamiltonianMatching_corrected :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D K : Set (SymplecticCoordinates n))
    (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → IsCompact K → K ⊆ D → ContDiffOn ℝ ∞ A D → ContDiffOn ℝ ∞ B D →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    matchesHamiltonian (bchHamiltonian3 A B) (fun h => Φ h ∘ Ψ h) K 4 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.bchHamiltonianMatching`；`MD.Ch03.bchHamiltonianMatching_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际匹配按截断至h³、端点误差O(h⁵)表达；D开放、K紧、光滑Hamiltonian与真实局部流明示。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 默认保留状态复合Φ\_h∘Ψ\_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL\_B)exp(hL\_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。 | [EXTRA] |

[EXTRA] 实际匹配按截断至h³、端点误差O(h⁵)表达；D开放、K紧、光滑Hamiltonian与真实局部流明示。；[ERRATUM?] 默认保留状态复合Φ\_h∘Ψ\_h及其正号修正Hamiltonian；对应拉回算子应为exp(hL\_B)exp(hL\_A)。原印反向算子顺序作为勘误保留。只声明现有有限实际流匹配。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已读取 Ch03.lean 实际声明和 Ch03\_deps.txt 对应 -- FILE 段，审计针对签名语义；该 theorem 的证明体为 sorry，不据此判断签名 PASS/FAIL，亦不声称已获 Lean 验证。依赖展开：SymplecticCoordinates n=(Fin n ⊕ Fin n)→ℝ，inl 为 q、inr 为 p；textbookJ=[[0,I],[-I,0]]；X\_H=textbookHamiltonianVectorField H=J∇H；textbookPoissonBracket F G=DF(X\_G)=Σ(F\_q G\_p−G\_q F\_p)。actualFlow f D Φ η 展开为 η>0，且每个 z∈D 有 Φ(0,z)=z，对全部 |t|<η 有 Φ(t,z)∈D 和时间方向 HasDerivAt Φ(·,z) f(Φ(t,z)) t；未把复合相等或匹配放进假设。solution f γ 0 h 展开为在整个闭区间 [0,h] 的 HasDerivWithinAt γ (f(γ(t)))。 matchesHamiltonian K G B p 展开为 ∃C>0、δ>0、Γ，对全部 0<h<δ、z∈B 有 Γ(h,z,0)=z、solution X_{K(h)} Γ 0 h 及 ‖G(h,z)−Γ(h,z,h)‖≤C h^{p+1}；本条 p=4 即 O(h⁵)，不是预设匹配假设。bchHamiltonian3 展开为原页到 h³ 的印刷函数；该有限阶 O(h⁵) 解释是光滑情况下合理的形式级数有限后果，不证明收敛或无限级数的实际精确等价。按原页及 PDF124/印刷102 的 L\_H F={F,H}，exp(hL\_A) 是 Φ\_A 的 pullback；exp(hL\_A)exp(hL\_B)F=F∘Ψ\_B∘Φ\_A，而 Lean 端点是 Φ\_A∘Ψ\_B。实际 [L\_A,L\_B]=L_{ {B,A} }=−L_{ {A,B} }，PDF127 顶部第一式也给出 {B,A}，紧接的第二式却改成 {A,B}，故该原书符号疑误可确定。Lean 的正号 Hamiltonian 对 Φ\_A∘Ψ\_B 是合理的，但这不是所引原文算子等式的逐义形式化。 [EXTRA] 开放 D、紧 K⊆D、光滑性用于统一有限阶余项，合理；全 D 统一 η 且所有轨线留在 D 比一般局部流强，应披露。无需因所谓未知定义、组合次序或余项阶而 NEEDS\_HUMAN：相关定义全部在附件中，次序与 O(h⁵) 已可明确判定。

### 7. 状态与证明位置

incomplete；`MD.Ch03.bchHamiltonianMatching`：未证（原书疑误不证）；`MD.Ch03.bchHamiltonianMatching_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L564)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-CommutingFlows · unnumbered_claim · 印刷p.106 / PDFp.128

### 2. 原文陈述

> If $`H_1`$ and $`H_2`$ Poisson-commute, i.e.

$$
\{H_1,H_2\}=0,
$$


> then there is no error in splitting.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem commutingFlows :
  ∀ (n : ℕ) (A B : SymplecticCoordinates n → ℝ) (D : Set (SymplecticCoordinates n))
    (Φ Ψ Χ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) η,
    IsOpen D → ContDiffOn ℝ ∞ A D → ContDiffOn ℝ ∞ B D →
    (∀ z ∈ D, textbookPoissonBracket A B z=0) →
    actualFlow (textbookHamiltonianVectorField A) D Φ η → actualFlow (textbookHamiltonianVectorField B) D Ψ η →
    actualFlow (textbookHamiltonianVectorField (fun z => A z+B z)) D Χ η →
    ∀ z ∈ D, ∀ h ∈ Ioo (-η/2) (η/2), Φ h (Ψ h z)=Χ h z := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.commutingFlows` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 光滑Hamiltonian、开放域及三个真实局部流；\|h\|<η/2保证复合时间在所给流的定义区间。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |

[EXTRA] 光滑Hamiltonian、开放域及三个真实局部流；|h|<η/2保证复合时间在所给流的定义区间。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：量化任意有限维n、Hamiltonian A/B、开放域D、三个时间参数流Φ/Ψ/Χ及η；A/B在D上C∞，Poisson括号在D上恒零。actualFlow含η>0、初值恒等、整段(−η,η)的ODE及D内不变性，不预设复合等于总流。结论对D内全部z及|h|<η/2给出Φ\_h∘Ψ\_h=Χ\_h。J=[0 I;−I 0]及括号dA(X\_B)符合标准坐标。光滑性保证局部唯一性；域内不变性保证中间点合法。[EXTRA]这些局部流及光滑域资格合理，∞恢复C∞也合理。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

incomplete；`MD.Ch03.commutingFlows`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L590)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.1-SymplecticEulerShadow · definition · 印刷p.106 / PDFp.128

### 2. 原文陈述

> Splitting our Hamiltonian using $`H_1=T(\boldsymbol p)=\boldsymbol p^TM^{-1}\boldsymbol p/2`$ and $`H_2=U(\boldsymbol q)`$ gives the symplectic Euler method. The BCH expansion gives the perturbed Hamiltonian

$$
\widetilde H_h=H-\frac h2\boldsymbol p^TM^{-1}\nabla U(\boldsymbol q)+\frac{h^2}{12}\bigl(\boldsymbol p^TM^{-1}U''(\boldsymbol q)M^{-1}\boldsymbol p+\nabla U(\boldsymbol q)^TM^{-1}\nabla U(\boldsymbol q)\bigr)-\frac{h^3}{12}\nabla U(\boldsymbol q)^TM^{-1}U''(\boldsymbol q)M^{-1}\boldsymbol p+O(h^4).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def symplecticEulerShadow3 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : ℝ :=
  mechanicalEnergy m U z-h/2*(∑ i, invMass m z.2 i*grad U z.1 i)+
    h^2/12*((shadowTerms m U z).1+(shadowTerms m U z).2.1)-h^3/12*(shadowTerms m U z).2.2
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.symplecticEulerShadow3` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | M取固定对角质量矩阵，与第1章机械模型一致；不包括任意非对角M。 | [EXTRA] |

[EXTRA] M取固定对角质量矩阵，与第1章机械模型一致；不包括任意非对角M。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；PASS（有限截断定义的语义，不是无限级数收敛或匹配定理的证明）。依赖Ch03\_deps.txt中逐项展开：Q n=Fin n→ℝ，Z n=Q n×Q n，z.1=q、z.2=p；invMass m v i=(m i)⁻¹v\_i；quadraticKinetic=(Σ p\_i²/m\_i)/2，mechanicalEnergy=T+U；grad U q i=fderiv U q(e\_i)，hessianAction U q v=fderiv (grad U) q(v)。shadowTerms三个分量分别是vᵀU″v、gᵀM⁻¹g、(M⁻¹g)ᵀU″v，其中v=M⁻¹p、g=∇U。故symplecticEulerShadow3准确保存PDF第128页的h⁰至h³全部系数；O(h⁴)未作为函数项，已由context\_notation说明是有限截断，并交由另一条匹配陈述处理。[EXTRA]固定对角质量与机械模型一致，是明确限制；不宣称推广到任意非对角M。定义本身未要求positiveMass或可微性，Lean的逆元及fderiv为全域算子：零质量/不可微势处为形式扩展，不赋予这些输入教材力学含义；在正质量且势足够光滑的原文语境内完全一致。无[ERRATUM?]标记，无需修正原书公式。此条是定义，不含sorry；不据此声称后续匹配已有证明。依赖定位：Ch03\_deps.txt:2816–2817、2840、2932、3569–3579。

### 7. 状态与证明位置

self-contained；`MD.Ch03.symplecticEulerShadow3`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L602)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.1-SymplecticEulerShadowMatching · unnumbered_claim · 印刷p.106 / PDFp.128

### 2. 原文陈述

> The BCH expansion gives the perturbed Hamiltonian

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticEulerShadowMatching :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (SymplecticCoordinates n)),
    positiveMass m → ContDiff ℝ ∞ U → IsCompact B →
    matchesHamiltonian (fun h z => symplecticEulerShadow3 m U h (unpack z))
      (textbookSymplecticEuler m U) B 4 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.symplecticEulerShadowMatching` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正对角质量、U全域C∞、紧初值集B；截断h³的实际局部流端点O(h⁵)为额外严格化。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |

[EXTRA] 正对角质量、U全域C∞、紧初值集B；截断h³的实际局部流端点O(h⁵)为额外严格化。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：量化n、正对角质量m、全域C∞势U及任意紧初值集B；unpack将inl/inr坐标分别解释为q/p。算法为drift\_h∘kick\_h，先p减h∇U(q)，再q加hM⁻¹p\_new。symplecticEulerShadow3中h、h²、h³的符号及两项h²收缩、h³收缩均与附件第4页相同；J的约定使这些符号匹配此数值次序。matchesHamiltonian的p=4精确要求存在C>0、δ>0、对每个0<h<δ和z∈B有真实初值解且端点差≤Ch^5，而不是Hamiltonian余项O(h^5)。从Hamiltonian截断误差O(h^4)经一步时间h得到该端点阶，[EXTRA]紧集一致局部解及光滑性是合理严格化。原issues中的次序/阶疑问由所给定义可消除。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

incomplete；`MD.Ch03.symplecticEulerShadowMatching`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L610)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-VerletMaps · (3.3) · 印刷p.107 / PDFp.129

### 2. 原文陈述

> Recall the position and velocity Verlet methods:

$$
\begin{array}{ll}\text{Position Verlet:}&\text{Velocity Verlet:}\\ \widehat Q:=q+(h/2)M^{-1}p,&\widehat P:=p-(h/2)\nabla U(q),\\ P:=p-h\nabla U(\widehat Q),&Q:=q+hM^{-1}\widehat P,\\ Q:=\widehat Q+(h/2)M^{-1}P.&P:=\widehat P-(h/2)\nabla U(Q).\end{array}\tag{3.3}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def verletMaps {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) :
    (SymplecticCoordinates n → SymplecticCoordinates n) ×
      (SymplecticCoordinates n → SymplecticCoordinates n) :=
  (positionVerlet m (textbookPotentialForce U) h,
    coordinateVerlet m (textbookPotentialForce U) h)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.verletMaps` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 固定对角质量M，保持第1章对象；无非对角质量一般化。 | [EXTRA] |

[EXTRA] 固定对角质量M，保持第1章对象；无非对角质量一般化。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；依赖展开：Q n=Fin n→ℝ，SymplecticCoordinates n=(Fin n⊕Fin n)→ℝ；pack=Sum.elim q p，unpack=(z∘inl,z∘inr)。textbookPotentialForce U q i=−fderiv ℝ U q (Pi.single i 1)；kick保持q并令p\_i↦p\_i+hF(q)_i；drift保持p并令q\_i↦q\_i+h(m\_i)⁻¹p\_i。coordinateVerlet=kick(h/2)∘drift(h)∘kick(h/2)，positionVerlet=drift(h/2)∘kick(h)∘drift(h/2)，函数组合从右至左作用。 展开所得六个赋值及返回位置/速度Verlet的顺序均与(3.3)一致。[EXTRA] 对角固定质量与教材机械模型相符；Lean还允许零质量（实数逆零定义为零）及非光滑U，这是总函数延拓，并非对退化对象声称物理逆矩阵存在。定义没有sorry；数学适用域应理解为教材非退化质量、可微势能。

### 7. 状态与证明位置

self-contained；`MD.Ch03.verletMaps`：定义。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L619)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-VerletHamiltonianParts · definition · 印刷p.107 / PDFp.129

### 2. 原文陈述

> We can think of the velocity Verlet method as being defined by a splitting into three parts:

$$
H(q,p)=H_1+H_2+H_3,\qquad H_1=\frac12U(q),\qquad H_2=\frac12p^TM^{-1}p,\qquad H_3=\frac12U(q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def verletHamiltonianParts {n : ℕ} (m : Fin n → ℝ)
    (_hm : positiveMass m) (U : Q n → ℝ) : Fin 3 → SymplecticCoordinates n → ℝ :=
  ![(fun z ↦ U (unpack z).1/2),
    (fun z ↦ quadraticKinetic m (unpack z).2), (fun z ↦ U (unpack z).1/2)]

theorem verletHamiltonianParts_sum {n : ℕ} (m : Fin n → ℝ)
    (hm : positiveMass m) (U : Q n → ℝ) (z : SymplecticCoordinates n) :
    (∑ i : Fin 3, verletHamiltonianParts m hm U i z) =
      quadraticKinetic m (unpack z).2+U (unpack z).1 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.verletHamiltonianParts`；`MD.Ch03.verletHamiltonianParts_sum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 绑定真实正对角质量、T(p)=pᵀM⁻¹p/2及U(q)，补H1+H2+H3=H；移除任意相空间函数替代机械分解。 | [EXTRA] |

[EXTRA] [EXTRA] 绑定真实正对角质量、T(p)=pᵀM⁻¹p/2及U(q)，补H1+H2+H3=H；移除任意相空间函数替代机械分解。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：任意n、m及正质量证明hm、任意U，定义Fin 3索引的三个真实相空间函数，依次为U(q)/2、(∑p\_i²/m\_i)/2、U(q)/2；不把T或U替换成任意相空间函数。sum声明对每个z断言三项之和为T(p)+U(q)，覆盖原文H=H1+H2+H3。正对角质量由[EXTRA]明确，既无额外轨迹假设也无漏掉的求和结论。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

incomplete；`MD.Ch03.verletHamiltonianParts`：定义；`MD.Ch03.verletHamiltonianParts_sum`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L627)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

