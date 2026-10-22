# 第3章 Lean Blueprint 本地审阅材料

149条；网站PASS 106，本地按意见修复10条（未再送网站），合并勘误30项。
统计与证明状态见[导师摘要](CH03_SUMMARY_FOR_MENTOR.zh-CN.md)，原书问题见[勘误清单](CH03_ERRATA.zh-CN.md)。网站原返回与本地修复结论分开保留；完整检查证据：blueprint/closeout24/ch03/full/CHECK\_REPORT.json。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L23)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-AdjointEulerOscillator · definition · 印刷p.98 / PDFp.120

### 2. 原文陈述

> Let us begin with an illustrative example. Consider the harmonic oscillator with frequency $\Omega$ which has Hamiltonian $H(q,p)=p^2/2+\Omega^2q^2/2$, and consider the adjoint symplectic Euler method

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L47)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-ShadowHamiltonian · (3.1) · 印刷p.98 / PDFp.120

### 2. 原文陈述

> However, if we modify the Hamiltonian from $H(q,p)=p^2/2+\Omega^2q^2/2$ to

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L52)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-EnergyFailure · unnumbered_claim · 印刷p.98 / PDFp.120

### 2. 原文陈述

> If $H(q,p)=E$ then, for typical steps, we cannot expect $H(Q,P)=E$. (Just insert the formulas for $Q$ and $P$ into the Hamiltonian and check that the value is not the same as $H(q,p)$.)

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L56)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-ShadowInvariant · unnumbered_claim · 印刷p.99 / PDFp.121

### 2. 原文陈述

> This means that $\widetilde H$ is a conserved quantity of the numerical method.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L89)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-ShadowEllipses · unnumbered_claim · 印刷p.99 / PDFp.121

### 2. 原文陈述

> Recall that the graph of

$$
\frac{x^2}{a^2}+\frac{y^2}{b^2}=1
$$


> is an ellipse with major and minor axes aligned to the coordinate axes. If $\epsilon$ is a small value, then

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L97)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L134)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-FormalHamiltonian · definition · 印刷p.100 / PDFp.122

### 2. 原文陈述

> Now consider the more general Hamiltonian setting. Let $\mathcal G_h$ be a $r$th order symplectic integrator, $r\ge1$. Suppose that it is the flow map of a certain Hamiltonian system, with Hamiltonian $\widetilde H_h$. If the method order is $r$, we may expect this Hamiltonian to be a $\mathcal O(h^r)$ approximation of $H$, thus we posit an expansion of the form

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L159)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.1-FormalHamiltonianField · definition · 印刷p.100 / PDFp.122

### 2. 原文陈述

> To determine the terms $H^{(r)},H^{(r+1)},\ldots$, we write the differential equations on $\widetilde H_h$:

$$
\dot{\boldsymbol z}=J\nabla H+h^rJ\nabla H^{(r)}+h^{r+1}J\nabla H^{(r+1)}+\cdots
$$



### 3. 原文证明

原书无独立完整证明。
> The solution of this system can be expanded in powers of $h$ and equated term-by-term with the expansion of $\mathcal G_h$ in powers of $h$. In this way, successive terms may be computed. Although mechanical, this procedure is tedious.
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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L166)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-LieDerivative · definition · 印刷p.100 / PDFp.122

### 2. 原文陈述

> The right hand side suggests a shorthand notation. If we define the Lie derivative $\mathcal L_f$ by

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L174)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-ObservableDerivative · (3.2) · 印刷p.100–101 / PDFp.122–123

### 2. 原文陈述

> At any point $\boldsymbol z=\boldsymbol\zeta$ in phase space assume that there is a unique solution $\boldsymbol z(t,\boldsymbol\zeta)$ such that $\dot{\boldsymbol z}(t)=f(\boldsymbol z(t))$, $\boldsymbol z(0)=\boldsymbol\zeta$ that is globally defined for all $t$. Now differentiate $\hat\phi(t)=\phi(\boldsymbol z(t))$ with respect to time, using the chain rule, to see how $\phi(\boldsymbol z(t))$ is changing as $t$ is varied:

$$
\left.\frac{\mathrm d}{\mathrm dt}\hat\phi\right|_{t=0}=\left[\sum_{i=1}^m\frac{\partial\phi}{\partial z_i}\dot z_i\right]_{\boldsymbol z=\boldsymbol\zeta}=\nabla\phi(\boldsymbol\zeta)\cdot f(\boldsymbol\zeta).
$$


> and note that the origin of time is irrelevant, then the equation for the evolution of $\phi$ could be written

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L178)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L186)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-OperatorExponential · definition · 印刷p.101 / PDFp.123

### 2. 原文陈述

> By analogy with the derivation of the matrix exponential, it is tempting to express the exponential as a series expansion in powers of $t$:

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L194)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-FormalObservable · definition · 印刷p.101 / PDFp.123

### 2. 原文陈述

> The Taylor series expansion of $\phi(\boldsymbol z(t))$ along a solution of the differential equation can therefore be written as

$$
\begin{aligned}\phi(\boldsymbol z(t))&=\phi(\boldsymbol z(0))+t\left.\frac{\mathrm d}{\mathrm dt}\phi(\boldsymbol z(t))\right|_{t=0}+\frac{t^2}{2}\left.\frac{\mathrm d^2}{\mathrm dt^2}\phi(\boldsymbol z(t))\right|_{t=0}+\cdots\\ &=\phi(\boldsymbol z(0))+t(\mathcal L_f\phi)(\boldsymbol z(0))+\frac{t^2}{2}(\mathcal L_f^2\phi)(\boldsymbol z(0))+\cdots\\ &=(e^{t\mathcal L_f}\phi)(\boldsymbol z(0)).\end{aligned}
$$



### 3. 原文证明

原书无独立完整证明。
> However, as $\mathcal L_f$ is a first order operator, this series involves high order mixed partial derivatives, and the convergence of the expansion has to be considered in connection with its application to given initial data, that is, we should consider the expansion

$$
e^{t\mathcal L_f}\phi=\phi+t\mathcal L_f\phi+\frac{t^2}{2}\mathcal L_f^2\phi+\cdots
$$


> then the primary issue is the boundedness of the terms with respect to functions $\phi$ of a certain space of functions; we ignore the convergence issue here and treat the operator exponential as a formal series expansion.
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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L198)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-FiniteLieTaylor · unnumbered_claim · 印刷p.101 / PDFp.123

### 2. 原文陈述

> The Taylor series expansion of $\phi(\boldsymbol z(t))$ along a solution of the differential equation can therefore be written as

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L206)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-FlowCoordinates · unnumbered_claim · 印刷p.101 / PDFp.123

### 2. 原文陈述

> This gives a concise formula for the evolution of any function of the phase variables, including, in particular, any solution component $z_i$. Thus the flow map of the system can be represented by $\exp(t\mathcal L_f)$. When one writes $\mathcal F_t=\exp(t\mathcal L_f)$, what is actually meant is that the individual components satisfy

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L235)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonBracket · definition · 印刷p.102 / PDFp.124

### 2. 原文陈述

> Another common notation for performing computations involving Hamiltonian systems is the Poisson bracket which is defined for two smooth scalar-valued functions $g_1$ and $g_2$ of the phase variables $(\boldsymbol q,\boldsymbol p)$ of a Hamiltonian system in $\mathbb R^m$ by

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L265)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L270)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonBilinearity · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables):
> Bilinearity $\{g_1,\alpha g_2+\beta g_3\}=\alpha\{g_1,g_2\}+\beta\{g_1,g_3\}$.

### 3. 原文证明

原书无独立完整证明。
> The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables):
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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L281)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonSkew · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> Skew symmetry $\{g_1,g_2\}=-\{g_2,g_1\}$

### 3. 原文证明

原书无独立完整证明。
> The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables):
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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L293)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonSelf · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> and this implies $\{g_1,g_1\}=0$.

### 3. 原文证明

原书无独立完整证明。
> The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables):
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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L299)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-PoissonJacobi · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> Jacobi identity $\{g_1,\{g_2,g_3\}\}+\{g_3,\{g_1,g_2\}\}+\{g_2,\{g_3,g_1\}\}=0$.

### 3. 原文证明

原书无独立完整证明。
> The Poisson bracket has the following properties, which are easily verified from the definition (for $g_1,g_2,g_3$ being three arbitrary functions of the phase variables):
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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L305)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-HamiltonianObservableDerivative · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> More generally, if $F(\boldsymbol q,\boldsymbol p)$ is any smooth, scalar-valued function of the phase variables, we may write

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L315)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-HamiltonianLie · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> As a consequence, we have the following relation between the Lie derivative and the Poisson bracket:

$$
\mathcal L_{J\nabla H}F\equiv \{F,H\}.
$$


> For a Hamiltonian flow, we typically simplify notation by writing $\mathcal L_H$ in place of $\mathcal L_{J\nabla H}$.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L324)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.2-HamiltonianCoordinateDerivative · unnumbered_claim · 印刷p.102 / PDFp.124

### 2. 原文陈述

> In terms of the Poisson bracket, it is possible to write the differential equation corresponding to a coordinate $q_i$, say, as

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L331)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-HamiltonianLieAdditivity · unnumbered_claim · 印刷p.103 / PDFp.125

### 2. 原文陈述

> As the relation

$$
\mathcal L_H\phi=\{\phi,H\}
$$


> is linear in $H$, we may write, for Hamiltonians $H_1,H_2$,

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L342)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-FormalSplitting · definition · 印刷p.103 / PDFp.125

### 2. 原文陈述

> The flow map of the system with Hamiltonian $H=H_1+H_2$ is

$$
\mathcal F_t=e^{t(\mathcal L_{H_1}+\mathcal L_{H_2})}.
$$


> On the other hand, the splitting method based on a composition of flows on $H_1$ and $H_2$ is

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L352)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L372)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L382)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-DifferenceCommutator · unnumbered_claim · 印刷p.104 / PDFp.126

### 2. 原文陈述

> So the difference is

$$
\begin{aligned}e^{hA}e^{hB}-e^{h(A+B)}&=\frac{h^2}{2}(AB-BA)\\&\quad+\frac{h^3}{6}(2AB^2+2A^2B-BA^2-BAB-B^2A-ABA)+O(h^4)\\&=\frac{h^2}{2}[A,B]+O(h^3),\end{aligned}
$$


> where $[A,B]=AB-BA$ is the commutator of $A$ and $B$.
> For a splitting method, we have, replacing $A$ by $\mathcal L_{H_1}$ and $B$ by $\mathcal L_{H_2}$,

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L398)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L451)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-HamiltonianCommutator · unnumbered_claim · 印刷p.104–105 / PDFp.126–127

### 2. 原文陈述

> Observe that, for any real-valued functions $f$ and $H$ of phase space,

$$
\mathcal L_Hf=\nabla f^TJ\nabla H=\{f,H\}.
$$


> Hence $\mathcal L_{H_1}\mathcal L_{H_2}f=\{\{f,H_2\},H_1\}$, and, using this and skew-symmetry of the Poisson bracket,

$$
[\mathcal L_{H_1},\mathcal L_{H_2}]f=\{\{f,H_2\},H_1\}-\{\{f,H_1\},H_2\}=\{\{f,H_2\},H_1\}+\{\{H_1,f\},H_2\}.
$$


> By the Jacobi identity, $\{\{f,H_2\},H_1\}+\{\{H_2,H_1\},f\}+\{\{H_1,f\},H_2\}=0$.
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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L468)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L483)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-LeadingModifiedExponential · unnumbered_claim · 印刷p.105 / PDFp.127

### 2. 原文陈述

> Because of this, we may interpret the first term in the expansion of the error as itself being derived from a Hamiltonian. This is a crucial observation which suggests an alternative perspective on the error expansion in splitting. The idea is to view the product of exponentials as an exponential:

$$
e^{hA}e^{hB}=e^{h(A+B+hR)},
$$


> for some operator $R$. Expanding out the right hand side gives

$$
\begin{aligned}e^{h(A+B+hR)}&=\mathrm{Id}+h(A+B+hR)+\frac{h^2}{2}(A+B+hR)^2+\cdots\\ &=\mathrm{Id}+hA+hB+h^2R+\frac{h^2}{2}\bigl(A^2+AB+BA+B^2+h^2R^2+h(A+B)R+hR(A+B)\bigr)+\cdots.\end{aligned}
$$


> Comparing this to our expansion for $e^{hA}e^{hB}$, for agreement to $O(h^2)$ we must have

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L493)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L518)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L548)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L554)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L564)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3-CommutingFlows · unnumbered_claim · 印刷p.106 / PDFp.128

### 2. 原文陈述

> If $H_1$ and $H_2$ Poisson-commute, i.e.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L590)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.1-SymplecticEulerShadow · definition · 印刷p.106 / PDFp.128

### 2. 原文陈述

> Splitting our Hamiltonian using $H_1=T(\boldsymbol p)=\boldsymbol p^TM^{-1}\boldsymbol p/2$ and $H_2=U(\boldsymbol q)$ gives the symplectic Euler method. The BCH expansion gives the perturbed Hamiltonian

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L602)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L610)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L619)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L627)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-VerletStructure · unnumbered_claim · 印刷p.107 / PDFp.129

### 2. 原文陈述

> This is a sequence of two types of operations: it consists of a “kick” exhibited by a jump in the momentum, linear “drift” with the resulting momentum, followed by a final kick. The symmetry of the method is one of its important features. Switching the order of the operations, i.e. drift-kick-drift, gives the position Verlet method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletStructure :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), ContDiff ℝ 2 U →
    (∀ h, IsTextbookSymplecticMap (coordinateVerlet m (textbookPotentialForce U) h) ∧
      IsTextbookSymplecticMap (positionVerlet m (textbookPotentialForce U) h)) ∧
    (∀ h z, coordinateVerlet m (textbookPotentialForce U) (-h)
      (coordinateVerlet m (textbookPotentialForce U) h z)=z) ∧
    (∀ h z, positionVerlet m (textbookPotentialForce U) (-h)
      (positionVerlet m (textbookPotentialForce U) h z)=z) := by
  exact MolecularDynamics.Chapter03Review.verletVariants_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.verletStructure` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | U全域C²以保障真实梯度kick为辛映射；原文光滑Hamiltonian假设显式化。 | [EXTRA] |

[EXTRA] U全域C²以保障真实梯度kick为辛映射；原文光滑Hamiltonian假设显式化。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；依赖展开：Q n=Fin n→ℝ，SymplecticCoordinates n=(Fin n⊕Fin n)→ℝ；pack=Sum.elim q p，unpack=(z∘inl,z∘inr)。textbookPotentialForce U q i=−fderiv ℝ U q (Pi.single i 1)；kick保持q并令p\_i↦p\_i+hF(q)_i；drift保持p并令q\_i↦q\_i+h(m\_i)⁻¹p\_i。coordinateVerlet=kick(h/2)∘drift(h)∘kick(h/2)，positionVerlet=drift(h/2)∘kick(h)∘drift(h/2)，函数组合从右至左作用。 IsTextbookSymplecticMap Φ=ContDiff ℝ 1 Φ ∧ ∀z,(DΦ(z))ᵀJ DΦ(z)=J，其中textbookJacobian=实际fderiv的坐标矩阵。量词为∀n,m,U，在U全域C²后，同时给所有h的两种辛性及所有h,z的反步恒等式；kick/drift结构已由实际定义体现。[EXTRA] C²足以使梯度kick为C¹且Hessian对称，是合理的光滑性显式化；m正性不为剪切映射辛性和反步所必需。当前证明调用verletVariants\_proved，其源码由真实kick/drift辛性与两条反步消去证明组成；本条不是sorry。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.verletStructure`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L640)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-VerletModifiedHamiltonian · definition · 印刷p.107 / PDFp.129

### 2. 原文陈述

> In general for the Verlet method applied to Hamiltonians of the form $H(q,p)=T(p)+U(q)$, the BCH lemma gives

$$
\begin{aligned}\widetilde H_h={}&T+U+\frac{h^2}{12}\left(\{T,\{T,U\}\}-\frac12\{U,\{U,T\}\}\right)\\ &+\frac{h^4}{120}\left(-\frac16\{T,\{T,\{T,\{T,U\}\}\}\}+\frac13\{U,\{T,\{T,\{T,U\}\}\}\}-\frac14\{U,\{U,\{T,\{T,U\}\}\}\}+\{T,\{T,\{U,\{U,T\}\}\}\}\right)+O(h^6).\end{aligned}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def verletModifiedH {n : ℕ} (T U : SymplecticCoordinates n → ℝ) (h : ℝ) (z : SymplecticCoordinates n) : ℝ :=
  T z+U z+h^2/12*(textbookPoissonBracket T (textbookPoissonBracket T U) z-
    textbookPoissonBracket U (textbookPoissonBracket U T) z/2)+h^4/120*(
      -textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/6+
      textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/3-
      textbookPoissonBracket U (textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T U))) z/4+
      textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket U (textbookPoissonBracket U T))) z)



/-- 修正版，对应原文 MD-3.3.2-VerletModifiedHamiltonian。改动：这份独立表达式只按机械二次动能解释，不能用于一般非二次T；机械匹配见verletModifiedMatching_corrected。一般T的h⁴公式尚待导师，不声称本通用函数对任意T正确。 -/
```

独立修正版：

```lean
def verletModifiedH_corrected {n : ℕ} (T U : SymplecticCoordinates n → ℝ) (h : ℝ) (z : SymplecticCoordinates n) : ℝ :=
  T z+U z+h^2/12*(textbookPoissonBracket T (textbookPoissonBracket T U) z-
    textbookPoissonBracket U (textbookPoissonBracket U T) z/2)+h^4/120*(
      -textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/6+
      textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket T U))) z/3-
      textbookPoissonBracket U (textbookPoissonBracket U (textbookPoissonBracket T (textbookPoissonBracket T U))) z/4+
      textbookPoissonBracket T (textbookPoissonBracket T (textbookPoissonBracket U (textbookPoissonBracket U T))) z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 展示式中到h⁴的有限多项式辅助定义；BCH系数匹配及Hamiltonian O(h⁶)余项范围由MD-3.3.2-VerletModifiedMatching承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.verletModifiedH`；`MD.Ch03.verletModifiedH_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 本条仅保留展示式到h⁴的有限多项式；一般可分离T(p),U(q)的完整形式系数及O(h⁶)匹配由MD-3.3.2-VerletModifiedMatching补全，原展示式及余项原文不删。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 这份独立表达式只按机械二次动能解释，不能用于一般非二次T；机械匹配见verletModifiedMatching\_corrected。一般T的h⁴公式尚待导师，不声称本通用函数对任意T正确。 | [EXTRA] |

[EXTRA] [EXTRA] 本条仅保留展示式到h⁴的有限多项式；一般可分离T(p),U(q)的完整形式系数及O(h⁶)匹配由MD-3.3.2-VerletModifiedMatching补全，原展示式及余项原文不删。；[ERRATUM?] 这份独立表达式只按机械二次动能解释，不能用于一般非二次T；机械匹配见verletModifiedMatching\_corrected。一般T的h⁴公式尚待导师，不声称本通用函数对任意T正确。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；C：verletModifiedH对任意n及任意两个相空间实函数T/U、任意h/z定义总化有限多项式；所有Poisson括号均用dF(J∇G)，与所引符号一致，h²两项和h⁴四项逐项完全一致。作为有限式定义它不主张可微性、可分离性、真实流或O(h^6)匹配，extra明确将这些义务分给第7条。定义的字面翻译通过；但整条原文一般T的数学主张有反例，因此合并裁定需人工，不能把有限式的忠实性当成一般BCH正确性。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

self-contained；`MD.Ch03.verletModifiedH`：定义；`MD.Ch03.verletModifiedH_corrected`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L653)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-VerletModifiedMatching · unnumbered_claim · 印刷p.107 / PDFp.129

### 2. 原文陈述

> In general for the Verlet method applied to Hamiltonians of the form $H(q,p)=T(p)+U(q)$, the BCH lemma gives

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletModifiedMatching :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (SymplecticCoordinates n)),
    positiveMass m → ContDiff ℝ ∞ U → IsCompact B →
    matchesHamiltonian (verletModifiedH (fun z => quadraticKinetic m (unpack z).2) (fun z => U (unpack z).1))
      (coordinateVerlet m (textbookPotentialForce U)) B 5 := by
  sorry

theorem verletModifiedMatching_general (n : ℕ) (T U : Q n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (Φ Ψ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (η : ℝ) (_hT : ContDiff ℝ ∞ T) (_hU : ContDiff ℝ ∞ U)
    (_hD : IsOpen D) (_hB : IsCompact B) (_hBD : B ⊆ D)
    (_hΦ : actualFlow (textbookHamiltonianVectorField (fun z ↦ T (unpack z).2)) D Φ η)
    (_hΨ : actualFlow (textbookHamiltonianVectorField (fun z ↦ U (unpack z).1)) D Ψ η) :
    let Tp := fun z : SymplecticCoordinates n ↦ T (unpack z).2
    let Uq := fun z : SymplecticCoordinates n ↦ U (unpack z).1
    let G := fun h ↦ Ψ (h/2) ∘ Φ h ∘ Ψ (h/2)
    matchesHamiltonian (verletModifiedH Tp Uq) G B 6 ∧
    (∃ Hj : ℕ → SymplecticCoordinates n → ℝ,
      (∀ j, ContDiffOn ℝ ∞ (Hj j) D) ∧
      (∀ z ∈ D, Hj 0 z = Tp z+Uq z) ∧
      (∀ z ∈ D, Hj 2 z =
        (textbookPoissonBracket Tp (textbookPoissonBracket Tp Uq) z-
          textbookPoissonBracket Uq (textbookPoissonBracket Uq Tp) z/2)/12) ∧
      (∀ z ∈ D, Hj 4 z =
        (-textbookPoissonBracket Tp (textbookPoissonBracket Tp (textbookPoissonBracket Tp (textbookPoissonBracket Tp Uq))) z/6+
          textbookPoissonBracket Uq (textbookPoissonBracket Tp (textbookPoissonBracket Tp (textbookPoissonBracket Tp Uq))) z/3-
          textbookPoissonBracket Uq (textbookPoissonBracket Uq (textbookPoissonBracket Tp (textbookPoissonBracket Tp Uq))) z/4+
          textbookPoissonBracket Tp (textbookPoissonBracket Tp (textbookPoissonBracket Uq (textbookPoissonBracket Uq Tp))) z)/120) ∧
      (∀ j z, Hj (2*j+1) z = 0) ∧
      ∀ k ≥ 6, matchesHamiltonian (fun h z ↦ ∑ j ∈ Finset.range k, h^j*Hj j z) G B k) := by
  sorry



/-- 修正版，对应原文 MD-3.3.2-VerletModifiedMatching。改动：独立修正版仅保留正质量机械二次动能的有限匹配，不复制一般T的有疑h⁴结论。标量h⁴另有独立系数核对。 -/
```

独立修正版：

```lean
theorem verletModifiedMatching_corrected :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (SymplecticCoordinates n)),
    positiveMass m → ContDiff ℝ ∞ U → IsCompact B →
    matchesHamiltonian (verletModifiedH (fun z => quadraticKinetic m (unpack z).2) (fun z => U (unpack z).1))
      (coordinateVerlet m (textbookPotentialForce U)) B 5 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.verletModifiedMatching`；`MD.Ch03.verletModifiedMatching_general`；`MD.Ch03.verletModifiedMatching_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正对角质量、U全域C∞、紧初值B；完整印刷h⁴截断实际O(h⁶)端点匹配为额外严格化。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留已列机械特例，新增一般分离T(p),U(q)、真实局部子流、h⁴系数及所有截断匹配；Hamiltonian余项从h⁶起（奇项零），对应端点O(h⁷)，不混同两个余项。新结论暂sorry，未裁定印刷系数是否正确。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 独立修正版仅保留正质量机械二次动能的有限匹配，不复制一般T的有疑h⁴结论。标量h⁴另有独立系数核对。 | [EXTRA] |

[EXTRA] 正对角质量、U全域C∞、紧初值B；完整印刷h⁴截断实际O(h⁶)端点匹配为额外严格化。；[EXTRA] 保留已列机械特例，新增一般分离T(p),U(q)、真实局部子流、h⁴系数及所有截断匹配；Hamiltonian余项从h⁶起（奇项零），对应端点O(h⁷)，不混同两个余项。新结论暂sorry，未裁定印刷系数是否正确。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[ERRATUM?] 独立修正版仅保留正质量机械二次动能的有限匹配，不复制一般T的有疑h⁴结论。标量h⁴另有独立系数核对。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；C：verletModifiedMatching量化正质量m、全域C∞的U及紧B；K以二次T和位置U代入，G是先半kick、全drift、半kick，matchesHamiltonian(...,5)为O(h⁶)，与更强的正确截断阶相容。general则量化任意全域C∞ T/U、开放D、紧B⊆D、η及两条D内真实子流；结论含K4截断匹配O(h⁷)、存在全套D上C∞ Hj、H0/H2/H4精确值、所有奇次全域为零、每个k≥6的截断匹配O(h^(k+1))。这些量词和余项阶已完整保留，负号和次序也正确；但[EXTRA]把二次动能式提升到任意T，所固定H4有具体反例，故不能批准general。机械版本单独在签名语义上通过；本条总裁定依原书疑误规则NEEDS\_HUMAN。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

incomplete；`MD.Ch03.verletModifiedMatching`：未证（原书疑误不证）；`MD.Ch03.verletModifiedMatching_general`：未证（原书疑误不证）；`MD.Ch03.verletModifiedMatching_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L678)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-ModifiedEven · unnumbered_claim · 印刷p.107–108 / PDFp.129–130

### 2. 原文陈述

> The extra power of $h$ in the leading perturbation reflects the fact that this method is 2nd order accurate, rather than first order, as Symplectic Euler. Note that only even order terms $(h^2,h^4,\ldots)$ appear in the perturbative expansion; this is a consequence of the symmetry of the method.
> Setting $s=-t$, the left hand side of (3.4) collapses to the identity. Hence the surviving even-powered terms in the expansion on the right hand side of (3.5) must be zero. If the even order terms vanish, then the effect of composing linear operators symmetrically is to keep only odd order terms in the exponent, giving the symmetric BCH formula

$$
\exp(\tfrac t2X)\exp(tY)\exp(\tfrac t2X)=\exp(t(X+Y)+t^3\widetilde Z_{[3]}+\cdots).\tag{3.6}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem modifiedEven :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R),
    PowerSeries.coeff 1 (formalLog (formalStrang A B))=A+B ∧ ∀ j : ℕ,
    PowerSeries.coeff (2*j) (formalLog (formalStrang A B))=0 := by
  sorry



/-- 修正版，对应原文 MD-3.3.2-ModifiedEven。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem modifiedEven_corrected :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R),
    PowerSeries.coeff 1 (formalLog (formalStrang A B))=A+B ∧ ∀ j : ℕ,
    PowerSeries.coeff (2*j) (formalLog (formalStrang A B))=0 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.modifiedEven`；`MD.Ch03.modifiedEven_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补一阶log系数A+B并保留全部偶次零，表达至少二阶及Hamiltonian偶性/log奇性；不沿用不同步长log交换的错误推理。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA] 补一阶log系数A+B并保留全部偶次零，表达至少二阶及Hamiltonian偶性/log奇性；不沿用不同步长log交换的错误推理。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；C：任意实代数R（Ring而非CommRing）及A/B，formalStrang是e^(XA/2)e^(XB)e^(XA/2)，formalLog为对P−1展开的形式log。结论一次系数A+B，且对所有j∈ℕ包括j=0，2j次系数均为0；因此指数含h(A+B)及至少h³的奇项，除以h后修正生成元只有偶项，涵盖至少二阶。formalStrang常项1确保formalLog使用合法，不需要收敛或不同步长log交换。[EXTRA]新增一次项并未把错误的原书证明当前提。Lean签名PASS；JSON因保留原书推理缺口NEEDS\_HUMAN。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

incomplete；`MD.Ch03.modifiedEven`：未证（原书疑误不证）；`MD.Ch03.modifiedEven_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L727)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-Strang · definition · 印刷p.108 / PDFp.130

### 2. 原文陈述

> For Hamiltonians $X$ and $Y$, consider symmetrizing a composition of exponentials (a Strang splitting), such that

$$
\exp(\tfrac t2X)\exp(tY)\exp(\tfrac t2X)=\exp(tZ_t)=\exp(t\widetilde Z_{[1]}+t^2\widetilde Z_{[2]}+t^3\widetilde Z_{[3]}+t^4\widetilde Z_{[4]}+\cdots).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def formalStrang {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  textbookFormalOperatorExponential ((1/2 : ℝ) • A) * textbookFormalOperatorExponential B *
    textbookFormalOperatorExponential ((1/2 : ℝ) • A)

def formalStrang_Zt {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) : PowerSeries R :=
  PowerSeries.mk (fun j => PowerSeries.coeff (j+1) (formalLog (formalStrang A B)))

theorem formalStrang_constant {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) :
    PowerSeries.coeff 0 (formalStrang A B) = 1 := by
  simp [formalStrang, PowerSeries.coeff_mul, textbookFormalOperatorExponential]

theorem formalStrang_log_constant {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) :
    PowerSeries.constantCoeff (formalLog (formalStrang A B)) = 0 := by
  rw [← PowerSeries.coeff_zero_eq_constantCoeff_apply]
  simp [formalLog]

theorem formalStrang_log_reconstruction {R : Type*} [Ring R] [Algebra ℝ R] (A B : R) :
    PowerSeries.coeff 0 (formalLog (formalStrang A B)) = 0 ∧
    PowerSeries.X * formalStrang_Zt A B = formalLog (formalStrang A B) ∧
    textbookFormalZeroConstantExponential ⟨formalLog (formalStrang A B), formalStrang_log_constant A B⟩ = formalStrang A B := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.formalStrang`；`MD.Ch03.formalStrang_Zt`；`MD.Ch03.formalStrang_constant`；`MD.Ch03.formalStrang_log_constant`；`MD.Ch03.formalStrang_log_reconstruction` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] formalStrang保留构造；补常项为1、log常项为0及零常项形式指数重建的全阶等式。Z\_t明确为log级数去掉一因子X后的移位级数；重建声明尚未证明，不声称真实ODE收敛。 | [EXTRA] |

[EXTRA] [EXTRA] formalStrang保留构造；补常项为1、log常项为0及零常项形式指数重建的全阶等式。Z\_t明确为log级数去掉一因子X后的移位级数；重建声明尚未证明，不声称真实ODE收敛。

### 6. 审计结论

本轮修复：formalStrang保留构造；补常项为1、log常项为0及零常项形式指数重建的全阶等式。Z\_t明确为log级数去掉一因子X后的移位级数；重建声明尚未证明，不声称真实ODE收敛。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；C：formalStrang对任意实代数及A/B定义三次形式指数乘积，1/2只缩放外侧生成元，乘法次序与原文相同，形式变量由PowerSeries携带。但原文陈述同时断言该乘积等于exp(tZ\_t)=exp(∑t^j Z_[j])；定义体没有Z\_t、任何Z_[j]存在性、formalLog或重建指数的等式。context仅解释左端，不能替代全部结论；本条[EXTRA]也未披露完整性缺口。按完整结论审校为FAIL，不是因为原文数学错误或sorry。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

incomplete；`MD.Ch03.formalStrang`：定义；`MD.Ch03.formalStrang_Zt`：定义；`MD.Ch03.formalStrang_constant`：已证；`MD.Ch03.formalStrang_log_constant`：已证；`MD.Ch03.formalStrang_log_reconstruction`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L749)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-DifferentLogsCommute · (3.4)–(3.5) · 印刷p.108 / PDFp.130

### 2. 原文陈述

> Multiplying by the same expansion using a different time step $s$, we have

$$
\exp(\tfrac s2X)\exp(sY)\exp(\tfrac s2X)\exp(\tfrac t2X)\exp(tY)\exp(\tfrac t2X)=\exp(sZ_s)\exp(tZ_t).\tag{3.4}
$$


> But we know that $Z_t$ commutes with $Z_s$, giving

$$
\begin{aligned}\exp(sZ_s)\exp(tZ_t)&=\exp(sZ_s+tZ_t)\\ &=\exp((s+t)\widetilde Z_{[1]}+(s^2+t^2)\widetilde Z_{[2]}+(s^3+t^3)\widetilde Z_{[3]}+(s^4+t^4)\widetilde Z_{[4]}+\cdots).\end{aligned}\tag{3.5}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem differentLogsCommute :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R) (s t : ℝ),
    commutator (formalLog (formalStrang (s • A) (s • B))) (formalLog (formalStrang (t • A) (t • B)))=0 := by
  sorry



/-- 修正版，对应原文 MD-3.3.2-DifferentLogsCommute。改动：仅在A、B交换这一明示充分条件下给不同步长log交换；不使用原书一般交换断言证明奇性。 -/
```

独立修正版：

```lean
theorem differentLogsCommute_corrected :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R) (s t : ℝ), A*B=B*A →
    commutator (formalLog (formalStrang (s • A) (s • B))) (formalLog (formalStrang (t • A) (t • B)))=0 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.differentLogsCommute`；`MD.Ch03.differentLogsCommute_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 仅在A、B交换这一明示充分条件下给不同步长log交换；不使用原书一般交换断言证明奇性。 | [EXTRA] |

[EXTRA] [ERRATUM?] 仅在A、B交换这一明示充分条件下给不同步长log交换；不使用原书一般交换断言证明奇性。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；textbookFormalOperatorExponential A 的第k系数为A^k/k!；formalStrang A B=exp(xA/2)exp(xB)exp(xA/2)；formalLog P 的第n系数为Σ_{j=1}^n (−1)^(j+1)/j·coeff\_n((P−1)^j)，在P(0)=1时就是真实形式log；commutator A B=AB−BA。 Lean量词∀R,A,B,s,t，结论是两条共享形式变量x的log的交换子为零；非零s,t时log S(sx)=sx Z_(sx)，交换性与生成元版本对应，零缩放时log=0。确实保留了原文的普遍交换断言，但该断言一般是假，[ERRATUM?]成立；不能靠sorry使其成为正确结论。所给反例使(3.5)对一般s,t也失效；s=−t的反步消去及最终奇性仍可独立成立。当前证明为sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch03.differentLogsCommute`：未证（原书疑误不证）；`MD.Ch03.differentLogsCommute_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L775)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-StrangInverse · unnumbered_claim · 印刷p.108 / PDFp.130

### 2. 原文陈述

> Setting $s=-t$, the left hand side of (3.4) collapses to the identity.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem strangInverse :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R), formalStrang A B * formalStrang (-A) (-B)=1 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.strangInverse` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt 的 MolecularDynamics/Chapter03/FormalOperatorSeries.lean 中 textbookFormalOperatorExponential：第n项为 (1/n!) • A^n；Chapter03/ReviewDefinitions.lean 中 formalStrang 为 E(A/2)E(B)E(A/2)。Ch03.lean:436 的同名局部定义与依赖定义完全相同，strangInverse实际使用此局部定义。PowerSeries R 表示中心形式变量的幂级数，Ring R允许非交换系数，Algebra ℝ R提供中心实数系数。于是 S(A,B)S(−A,−B)=E(A/2)E(B)E(A/2)E(−A/2)E(−B)E(−A/2)=1，逐对消去即可；虽然原页代入所得顺序是 S(−t)S(t)，对全称量化的A,B取负即可得到该顺序。全称R,A,B是原形式算子恒等式的合理代数推广，形式变量代替t，不缺步长量词，也不需要额外交换假设。本条无[EXTRA]或[ERRATUM?]标记；相邻条目的交换疑误不参与本条推理。签名语义PASS；Ch03.lean:450的证明为sorry，属于证明未完成，不改变签名审计结论。本次未编译或补证明。

### 7. 状态与证明位置

incomplete；`MD.Ch03.strangInverse`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L793)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-StrangCubic · (3.6)–(3.7) · 印刷p.108 / PDFp.130

### 2. 原文陈述


$$
\exp(\tfrac t2X)\exp(tY)\exp(\tfrac t2X)=\exp(t(X+Y)+t^3\widetilde Z_{[3]}+\cdots),\tag{3.6}
$$


> where

$$
\widetilde Z_{[3]}=\frac1{12}[Y,[Y,X]]-\frac1{24}[X,[X,Y]].\tag{3.7}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem strangCubic :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R),
    PowerSeries.coeff 1 (formalLog (formalStrang A B))=A+B ∧
    (∀ j : ℕ, PowerSeries.coeff (2*j) (formalLog (formalStrang A B))=0) ∧
    PowerSeries.coeff 3 (formalLog (formalStrang A B))=
      (1/12:ℝ) • commutator B (commutator B A)-(1/24:ℝ) • commutator A (commutator A B) := by
  sorry

theorem strangCubic_coeff3 :
  ∀ (R : Type) [Ring R] [Algebra ℝ R] (A B : R),
    PowerSeries.coeff 3 (formalLog (formalStrang A B))=
      (1/12:ℝ) • commutator B (commutator B A)-(1/24:ℝ) • commutator A (commutator A B) := by
  intro R _ _ A B
  norm_num [formalLog, formalStrang, textbookFormalOperatorExponential,
    PowerSeries.coeff_mk, PowerSeries.coeff_mul, Finset.Nat.antidiagonal_succ,
    Nat.factorial_succ, pow_succ, Finset.sum_Icc_succ_top, MolecularDynamics.Chapter03Review.commutator,
    mul_add, add_mul, mul_sub, sub_mul, smul_mul_assoc, mul_smul_comm,
    smul_add, smul_sub, smul_smul]
  simp only [mul_assoc]
  module
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.strangCubic`；`MD.Ch03.strangCubic_coeff3` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 补一次系数和全部偶次零，连同原三次公式覆盖完整奇次展开；原已证三次系数保留辅助并重查，新合取暂sorry。 | [EXTRA] |

[EXTRA] [EXTRA] 补一次系数和全部偶次零，连同原三次公式覆盖完整奇次展开；原已证三次系数保留辅助并重查，新合取暂sorry。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：strangCubic量化所有实代数R及A/B，结论完整包含一次系数A+B、所有偶次系数零（包括常项），以及三次系数[B,[B,A]]/12−[A,[A,B]]/24；commutator的定义AB−BA与原书一致。strangCubic\_coeff3单独保留同一三次等式，未以辅助单系数替代主结论。两个声明均无交换性假设。[EXTRA]补低次及奇性正好表达(3.6)省略的高阶奇次形式展开，(3.7)的两个符号和系数相符。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

incomplete；`MD.Ch03.strangCubic`：未证（缺大型理论）；`MD.Ch03.strangCubic_coeff3`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L799)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.3-YoshidaComposition · definition · 印刷p.109 / PDFp.131

### 2. 原文陈述

> We now consider iterating this scheme three times, first using a step of $\tau_0h$, followed by a step of $\tau_1h$, and finally another step with stepsize $\tau_0h$ (where $\tau_0h+\tau_1h+\tau_0h=h$). The overall effect on the system is given by a product of exponentials, as

$$
\exp(\tau_0h\widehat{\mathcal L}_{\tau_0h})\exp(\tau_1h\widehat{\mathcal L}_{\tau_1h})\exp(\tau_0h\widehat{\mathcal L}_{\tau_0h})=\exp(hZ_h).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def yoshidaCompose {E : Type*} (G : ℝ → E → E) (a b h : ℝ) : E → E := G (a*h) ∘ G (b*h) ∘ G (a*h)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.yoshidaCompose` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；Ch03.lean:467的定义展开为G(a h)(G(b h)(G(a h)z))，实际执行次序a,b,a，与PDF131的三步回文复合一致。E、G、a、b、h全部为任意参数，负步长未被排除。2a+b=1不是该通用组合子的定义域限制，而由本批Cancellation/Unique规定；任意参数的组合子本身不宣称它们满足系数条件，也不宣称任意G都有指数生成元Z\_h。原文exp(hZ\_h)是本节形式算子表示，当前定义只实现该表示中的三次复合，按definition及context\_notation审计通过。无[EXTRA]或[ERRATUM?]；此处为定义，非sorry命题。

### 7. 状态与证明位置

self-contained；`MD.Ch03.yoshidaCompose`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L821)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.3-YoshidaCoefficients · definition · 印刷p.109 / PDFp.131

### 2. 原文陈述

> We have free reign over constants $\tau_0$ and $\tau_1$ as long as $2\tau_0+\tau_1=1$. Hence we have an opportunity to annihilate the perturbation operator at order $h^{2s}$ by choosing $2\tau_0^{2s+1}+\tau_1^{2s+1}=0$ as well. Solving simultaneously, there exists a unique real solution

$$
\tau_0=\frac1{2-\kappa},\qquad\tau_1=-\frac\kappa{2-\kappa},\qquad\kappa^{2s+1}=2,
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def yoshidaCoefficients (s : ℕ) : ℝ × ℝ := (1/(2-yoshidaRoot s),-yoshidaRoot s/(2-yoshidaRoot s))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.yoshidaCoefficients` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；Ch03\_deps.txt:3593实际定义yoshidaRoot s=Real.rpow 2 (1/((2*s+1:ℕ):ℝ))，并非未解释常数；3594及Ch03.lean:470展开为(1/(2−κ),−κ/(2−κ))。s≥1时1<κ<2、κ^(2s+1)=2，故分母非零且与PDF131公式一致。定义本身接受s=0，此时κ=2且Lean的除法给(0,0)，不属于教材s≥1的使用范围；本批Cancellation和Unique均显式限制s≥1，故该全域延拓未冒充s=0系数结论。原句包含存在唯一性，但按context\_notation的明确分条安排，它由Unique完整表达；单独定义不证明唯一性。无[ERRATUM?]，无sorry证明义务。

### 7. 状态与证明位置

self-contained；`MD.Ch03.yoshidaCoefficients`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L824)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.3-YoshidaCancellation · unnumbered_claim · 印刷p.109 / PDFp.131

### 2. 原文陈述

> We have free reign over constants $\tau_0$ and $\tau_1$ as long as $2\tau_0+\tau_1=1$. Hence we have an opportunity to annihilate the perturbation operator at order $h^{2s}$ by choosing $2\tau_0^{2s+1}+\tau_1^{2s+1}=0$ as well.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem yoshidaCancellation :
  ∀ s : ℕ, 1 ≤ s → let ab := yoshidaCoefficients s
    2*ab.1+ab.2=1 ∧ 2*ab.1^(2*s+1)+ab.2^(2*s+1)=0 ∧ ab.2 < 0 := by
  intro s hs
  let κ := yoshidaRoot s
  have hκ0 : 0 < κ := Real.rpow_pos_of_pos (by norm_num) _
  have hN : 1 < ((2*s+1 : ℕ) : ℝ) := by exact_mod_cast (show 1 < 2*s+1 by omega)
  have hκ2 : κ < 2 := by
    change Real.rpow 2 (1/((2*s+1 : ℕ):ℝ)) < 2
    calc
      _ < Real.rpow 2 1 := Real.rpow_lt_rpow_of_exponent_lt (by norm_num)
        ((div_lt_one (by positivity)).2 hN)
      _ = 2 := Real.rpow_one 2
  have hκpow : κ^(2*s+1)=2 := by
    simpa [κ, yoshidaRoot, one_div] using
      (Real.rpow_inv_natCast_pow (x := (2:ℝ)) (n := 2*s+1) (by norm_num) (by omega))
  have hd : 0 < 2-κ := sub_pos.mpr hκ2
  have hd0 : 2-κ ≠ 0 := ne_of_gt hd
  have ho : Odd (2*s+1) := ⟨s, by omega⟩
  change 2*(1/(2-κ))+(-κ/(2-κ))=1 ∧
    2*(1/(2-κ))^(2*s+1)+(-κ/(2-κ))^(2*s+1)=0 ∧ -κ/(2-κ)<0
  refine ⟨?_, ?_, div_neg_of_neg_of_pos (neg_neg_of_pos hκ0) hd⟩
  · field_simp
    ring
  · rw [neg_div, ho.neg_pow, div_pow, div_pow, one_pow, hκpow]
    ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.yoshidaCancellation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 显式s≥1，并保留中间系数τ₁<0作为根公式的数学推论。 | [EXTRA] |

[EXTRA] 显式s≥1，并保留中间系数τ₁<0作为根公式的数学推论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开yoshidaRoot及yoshidaCoefficients后，对每个自然数s≥1，令a=1/(2−2^(1/(2s+1)))、b=−2^(1/(2s+1))/(2−2^(1/(2s+1)))，结论同时给2a+b=1、2a^(2s+1)+b^(2s+1)=0和b<0。前两项正是PDF131消项的代数系数条件；第三项是公式的真实推论，未裁掉负步长。[EXTRA] s≥1是原页已写的条件且排除零分母，不是额外限制；b<0合理。此签名表达系数消项条件，实际复合方法升阶由另条RaiseOrder承担，不能由本条宣称实际升阶已成立。Ch03.lean:477–498有证明体而非sorry，但本审计未做编译验证。无[ERRATUM?]。

### 7. 状态与证明位置

self-contained；`MD.Ch03.yoshidaCancellation`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L828)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.3-YoshidaUnique · unnumbered_claim · 印刷p.109 / PDFp.131

### 2. 原文陈述

> Solving simultaneously, there exists a unique real solution

$$
\tau_0=\frac1{2-\kappa},\qquad\tau_1=-\frac\kappa{2-\kappa},\qquad\kappa^{2s+1}=2.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem yoshidaUnique :
  ∀ s : ℕ, 1 ≤ s → ∀ a b : ℝ,
    (2*a+b=1 ∧ 2*a^(2*s+1)+b^(2*s+1)=0) ↔ (a,b)=yoshidaCoefficients s := by
  intro s hs a b
  let κ := yoshidaRoot s
  have hN : 1 < ((2*s+1 : ℕ) : ℝ) := by exact_mod_cast (show 1 < 2*s+1 by omega)
  have hκ2 : κ < 2 := by
    change Real.rpow 2 (1/((2*s+1 : ℕ):ℝ)) < 2
    calc
      _ < Real.rpow 2 1 := Real.rpow_lt_rpow_of_exponent_lt (by norm_num)
        ((div_lt_one (by positivity)).2 hN)
      _ = 2 := Real.rpow_one 2
  have hd0 : 2-κ ≠ 0 := ne_of_gt (sub_pos.mpr hκ2)
  have hκpow : κ^(2*s+1)=2 := by
    simpa [κ, yoshidaRoot, one_div] using
      (Real.rpow_inv_natCast_pow (x := (2:ℝ)) (n := 2*s+1) (by norm_num) (by omega))
  have ho : Odd (2*s+1) := ⟨s, by omega⟩
  constructor
  · rintro ⟨hab, hp⟩
    have heq : (-b)^(2*s+1)=(κ*a)^(2*s+1) := by
      rw [ho.neg_pow, mul_pow, hκpow]
      linarith
    have hrel : -b=κ*a := ho.pow_injective heq
    have ha : a=1/(2-κ) := by
      apply (eq_div_iff hd0).2
      nlinarith
    have hb : b=-κ/(2-κ) := by
      calc
        b = -κ*a := by nlinarith
        _ = -κ/(2-κ) := by rw [ha]; ring
    change (a,b)=(1/(2-κ),-κ/(2-κ))
    exact Prod.ext ha hb
  · intro heq
    change (a,b)=(1/(2-κ),-κ/(2-κ)) at heq
    rcases Prod.mk.inj heq with ⟨rfl,rfl⟩
    exact ⟨(yoshidaCancellation s hs).1, (yoshidaCancellation s hs).2.1⟩
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.yoshidaUnique` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；实际κ定义为Real.rpow的正实根，系数定义如上。量词为∀s≥1 ∀a b∈ℝ；双向等价左侧含两个原方程，右侧强制(a,b)等于唯一指定实数对。因该实数对存在，取定义给定的a,b用反向蕴涵即得到存在性，正向蕴涵给唯一性，未仅陈述至多一个解。所有实数对均被覆盖，没有非负系数限制。奇次幂的单射性与κ^(2s+1)=2保证此语义正确；s≥1来自原页上下文。Ch03.lean:504–537为证明体，无sorry；未据此宣称编译通过。无额外条件或[ERRATUM?]。

### 7. 状态与证明位置

self-contained；`MD.Ch03.yoshidaUnique`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L856)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.3-YoshidaRaiseOrder · unnumbered_claim · 印刷p.109 / PDFp.131

### 2. 原文陈述

> giving us a scheme of order $2s+2$. We can then proceed recursively, as this new order $2s+2$ scheme can be composed similarly to wipe out successive higher order terms.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem yoshidaRaiseOrder :
  ∀ (n s : ℕ) (f : Q n → Q n) (G Φ : ℝ → Q n → Q n) (D B : Set (Q n)) η,
    1 ≤ s → ContDiff ℝ ∞ f → ContDiff ℝ ∞ (fun hz : ℝ × Q n => G hz.1 hz.2) →
    IsOpen D → IsCompact B → B ⊆ D → actualFlow f D Φ η →
    (∀ h z, G (-h) (G h z)=z) → (∀ K : Set (Q n), IsCompact K → K ⊆ D → localOrder G Φ K (2*s)) →
    localOrder (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2) Φ B (2*s+2) ∧
    (∀ K : Set (Q n), IsCompact K → K ⊆ D →
      localOrder (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2) Φ K (2*s+2)) ∧
    (∀ h z, yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2 (-h)
      (yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2 h z)=z) ∧
    ContDiff ℝ ∞ (fun hz : ℝ × Q n ↦
      yoshidaCompose G (yoshidaCoefficients s).1 (yoshidaCoefficients s).2 hz.1 hz.2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.yoshidaRaiseOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 给定光滑场、G在(h,z)全域C∞、开放D与紧B、实际双向局部流、反步对称和局部阶；实际改阶是结论。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 将孤立B上的逐紧集阶改为D内每个紧集的一致阶资格，覆盖移动中间点；结论补新方法在每紧集升阶、光滑及对称，保留递归资格。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |

[EXTRA] 给定光滑场、G在(h,z)全域C∞、开放D与紧B、实际双向局部流、反步对称和局部阶；实际改阶是结论。；[EXTRA] 将孤立B上的逐紧集阶改为D内每个紧集的一致阶资格，覆盖移动中间点；结论补新方法在每紧集升阶、光滑及对称，保留递归资格。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：所有n/s、f、G/Φ、D/B及η均量化，s≥1，f和联合(h,z)↦G\_h(z)全域C∞；D开放、B紧且包含于D；actualFlow提供真实双向时间流；G对所有h/z满足反步互逆。localOrder假设不是只在B上，而在每个D内紧集上一致为2s，且含正负小步，覆盖移动中间点及负Yoshida步长。根κ=2^(1/(2s+1))，a=1/(2−κ)、b=−κ/(2−κ)，三步回文G\_ah∘G\_bh∘G\_ah。结论既在B上也在每个D内紧集上提高到2s+2，同时保留联合C∞及全h/z的反步对称，足够重复迭代；localOrder的幂为r+1，未把局部端点阶误作r。所有[EXTRA]为合理的严格化与递归资格，无把升阶当前提。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

incomplete；`MD.Ch03.yoshidaRaiseOrder`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L897)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.3-Yoshida4 · Example 3.1 / (3.8) · 印刷p.109–110 / PDFp.131–132

### 2. 原文陈述

> Example 3.1 Consider using velocity Verlet as the base second-order method to build a Yoshida fourth-order method from. As the scheme is second-order, we have $s=1$, and hence

$$
\tau_0=\frac1{2-\sqrt[3]2},\qquad\tau_1=-\frac{\sqrt[3]2}{2-\sqrt[3]2}.
$$


> The overall scheme is then three iterations of velocity Verlet, using stepsizes $\tau_0h$, $\tau_1h$ and $\tau_0h$ respectively. We write this with subindices $\alpha,\beta$ to indicate the intermediate stages.
> Yoshida fourth-order scheme (velocity Verlet):

$$
\begin{aligned}P_\alpha&:=p-(\tau_0h/2)\nabla U(q),&Q_\alpha&:=q+(\tau_0h)M^{-1}P_\alpha,\\ P_\alpha&:=P_\alpha-(\tau_0h/2)\nabla U(Q_\alpha),&P_\beta&:=P_\alpha-(\tau_1h/2)\nabla U(Q_\alpha),\\ Q_\beta&:=Q_\alpha+(\tau_1h)M^{-1}P_\beta,&P_\beta&:=P_\beta-(\tau_1h/2)\nabla U(Q_\beta),\\ P&:=P_\beta-(\tau_0h/2)\nabla U(Q_\beta),&Q&:=Q_\beta+(\tau_0h)M^{-1}P,\\ P&:=P-(\tau_0h/2)\nabla U(Q).\end{aligned}\tag{3.8}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def yoshida4 {n : ℕ} (m : Fin n → ℝ) (_hm : positiveMass m) (U : Q n → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) : SymplecticCoordinates n → SymplecticCoordinates n :=
  yoshidaCompose (coordinateVerlet m (textbookPotentialForce U)) (yoshidaCoefficients 1).1 (yoshidaCoefficients 1).2 h
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.yoshida4` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | M为固定对角质量；不假设正反步骤的实际无限时域流存在。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 教材算法接口明确正质量与经典可微势；后续结构定理调用使用正式总化辅助组合，证明不新增。 | [EXTRA] |

[EXTRA] M为固定对角质量；不假设正反步骤的实际无限时域流存在。；[EXTRA] 教材算法接口明确正质量与经典可微势；后续结构定理调用使用正式总化辅助组合，证明不新增。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：定义量化n、m、正质量证明、势U及可微证明和任意h，返回完整相空间映射。yoshidaRoot 1是正实立方根2，两个系数即书中τ0/τ1。yoshidaCompose用回文三次coordinateVerlet，实际每次为半kick→全drift→半kick；代入负梯度逐条展开正是Pα/Qα、Pβ/Qβ、P/Q的九次原地赋值，最后返回Q/P。组合由右向左求值不改变τ0、τ1、τ0的执行顺序。正质量及可微资格已由[EXTRA]说明。算法名fourth-order在此是名称，未把本定义冒称为四阶证明，实际升阶义务在第11条。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

self-contained；`MD.Ch03.yoshida4`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L914)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.3-Yoshida4Structure · unnumbered_claim · 印刷p.110 / PDFp.132

### 2. 原文陈述

> Yoshida fourth-order scheme (velocity Verlet):

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem yoshida4Structure :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), ContDiff ℝ 2 U →
    (∀ h, IsTextbookSymplecticMap (MolecularDynamics.Chapter03Review.yoshida4 m U h)) ∧ (∀ h z, MolecularDynamics.Chapter03Review.yoshida4 m U (-h) (MolecularDynamics.Chapter03Review.yoshida4 m U h z)=z) := by
  exact MolecularDynamics.Chapter03Review.yoshida4Structure_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.yoshida4Structure` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | U全域C²；真实kick/drift及三次回文复合。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 依赖小修：原无质量限制的结构定理继续对应正式总化辅助算法；教材受限接口另有正质量/可微资格，原已证结论保留。 | [EXTRA] |

[EXTRA] U全域C²；真实kick/drift及三次回文复合。；[EXTRA] 依赖小修：原无质量限制的结构定理继续对应正式总化辅助算法；教材受限接口另有正质量/可微资格，原已证结论保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：量化n、任意实质量列表m及全域C²的U；结论为所有h的辛映射（C¹且雅可比满足AᵀJA=J），和所有h/z的负步恢复原点。这里显式引用正式库Chapter03Review.yoshida4，不误认成另一个要求hm/hU参数的MD接口。它的体与同一三次Verlet组合一致。C²保证势梯度C¹及对称Hessian，足以使kick辛；diagonal invMass即便m含零仍是实对称线性drift，故这些结构性质在总化辅助算法上不需要正质量。[EXTRA]明确保留总化辅助组合，合理；在正质量教材范围它与第12条的映射相同。没有断言四阶，也未遗漏反步结论。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.yoshida4Structure`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L920)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.3-GeneralSplitting · definition · 印刷p.111 / PDFp.133

### 2. 原文陈述

> We can view the Suzuki-Yoshida methods as one type of general composition scheme [260, 277, 326]:

$$
\mathcal F_h=\exp(\alpha_1h\mathcal L_T)\circ\exp(\beta_1h\mathcal L_U)\circ\exp(\alpha_2h\mathcal L_T)\circ\exp(\beta_2h\mathcal L_U)\circ\cdots\circ\exp(\alpha_kh\mathcal L_T)\circ\exp(\beta_kh\mathcal L_U).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def generalSplitting {E : Type*} (T U : ℝ → E → E) (coeff : List (ℝ × ℝ)) (h : ℝ) : E → E :=
  coeff.foldr (fun ab acc => T (ab.1*h) ∘ U (ab.2*h) ∘ acc) id
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.generalSplitting` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；Ch03\_deps.txt:3597–3598和Ch03.lean对应定义的foldr展开为T(α₁h)∘U(β₁h)∘…∘T(α\_kh)∘U(β\_kh)∘id，空列表给id。Function.comp在状态上的作用从最右端开始，正好保留PDF133展示的复合次序；没有错误地用foldl颠倒因子。E任意、T和U为给定映射族，有限有序实系数列表可含负值；原文形式指数记号在此以给定部分流实例化，定义没有断言任意T/U是实际流，也未擅自加入阶、对称、辛性或系数和条件。参考文献编号不属于数学假设。无[EXTRA]、[ERRATUM?]或sorry命题。

### 7. 状态与证明位置

self-contained；`MD.Ch03.generalSplitting`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L926)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.4-TakahashiPotential · definition · 印刷p.112 / PDFp.134

### 2. 原文陈述

> Recall the Takahashi-Imada method introduced in the last chapter,

$$
\widehat P:=p-(h/2)\nabla\widetilde U(q),\qquad Q:=q+hM^{-1}\widehat P,\qquad P:=\widehat P-(h/2)\nabla\widetilde U(Q),
$$


> with modified potential energy function

$$
\widetilde U(q)=U(q)-\frac{h^2}{24}\nabla U(q)^TM^{-1}\nabla U(q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def takahashiImada {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) :
    SymplecticCoordinates n → SymplecticCoordinates n :=
  coordinateVerlet m (textbookPotentialForce (takahashiPotential m U h)) h
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.takahashiImada` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | M为固定对角质量矩阵，原第1章机械模型。 | [EXTRA] |

[EXTRA] M为固定对角质量矩阵，原第1章机械模型。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；C：任意n、固定对角m、U及步长h，takahashiImada以同一个h构造修正势并调用coordinateVerlet。takahashiPotential精确为U(q)−h²/24∑(grad U(q)_i)²/m\_i；textbookPotentialForce对整个修正势取负梯度，非仅把原U梯度代入。半kick、全drift、半kick的次序及两个求梯度的位置q/Q完整匹配原文。正质量可微机械背景由上下文理解；当前是用总化逆元和fderiv给出的函数定义，未宣称零质量或不可微势也是物理方法或满足阶/结构定理。固定对角质量[EXTRA]合理，定义无额外错误命题。 本审校只读核对任务中给出的声明及项目定义，不编译、不补证明；sorry不作为FAIL理由。

### 7. 状态与证明位置

self-contained；`MD.Ch03.takahashiImada`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L931)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.4-PotentialDoubleBracket · unnumbered_claim · 印刷p.112 / PDFp.134

### 2. 原文陈述

> One might recognize the modification as being proportional to one part of the commutator expansion in the Verlet method, in fact

$$
\nabla U(q)^TM^{-1}\nabla U(q)=\{U,\{U,T\}\}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem potentialDoubleBracket :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ 2 U → ∀ z : Z n,
    (∑ i, grad U z.1 i*invMass m (grad U z.1) i)=
      textbookPoissonBracket (fun x => U (unpack x).1)
        (textbookPoissonBracket (fun x => U (unpack x).1) (fun x => quadraticKinetic m (unpack x).2)) (pack z) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.potentialDoubleBracket` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正对角质量、U全域C²，显式化真实二次Poisson括号的微分资格。 | [EXTRA] |

[EXTRA] 正对角质量、U全域C²，显式化真实二次Poisson括号的微分资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 grad、invMass m v i=(mᵢ)⁻¹vᵢ、quadraticKinetic m p=∑ᵢpᵢ²/mᵢ/2、pack=Sum.elim q p、unpack=(z∘inl,z∘inr)。textbookPoissonBracket F G=DF·textbookHamiltonianVectorField G，后者为J乘坐标偏导，textbookJ=[0 I;−I 0]；故括号为∑ᵢ(F\_qᵢG\_pᵢ−G\_qᵢF\_pᵢ)。内层{U,T}=∑ᵢU\_qᵢpᵢ/mᵢ，外层{U,{U,T}}=∑ᵢU\_qᵢ²/mᵢ，正好等于左式。∀n,m,U，正质量与C²后∀z的量词和对象正确；C²充分保证真实嵌套微分，正质量可放宽至非零但与模型一致，合理。[ERRATUM?]无。声明体含sorry，因此PASS仅指签名语义，不指证明完成。

### 7. 状态与证明位置

incomplete；`MD.Ch03.potentialDoubleBracket`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L937)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.4-TakahashiShadow · definition · 印刷p.112 / PDFp.134

### 2. 原文陈述

> This is certainly not a coincidence. If we replace the potential $U$ by $\widetilde U$ in the Verlet expansion, we have

$$
\begin{aligned}\widetilde H_h&=T+\widetilde U+\frac{h^2}{12}\left(\{T,\{T,\widetilde U\}\}-\frac12\{\widetilde U,\{\widetilde U,T\}\}\right)+O(h^4)\\ &=T+U-\frac{h^2}{24}\{U,\{U,T\}\}+\frac{h^2}{12}\left(\{T,\{T,\widetilde U\}\}-\frac12\{\widetilde U,\{\widetilde U,T\}\}\right)+O(h^4)\\ &=H+\frac{h^2}{12}\left(\{T,\{T,\widetilde U\}\}-\{\widetilde U,\{\widetilde U,T\}\}\right)+O(h^4)\\ &=H+\frac{h^2}{12}\left(p^TM^{-1}U''M^{-1}p-\nabla U^TM^{-1}\nabla U\right)+O(h^4).\end{aligned}
$$



### 3. 原文证明

原书无独立完整证明。
原书同段推导完整存于statement\_latex；有限函数定义不证明该推导或实际余项。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def takahashiShadow2 {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : ℝ :=
  mechanicalEnergy m U z+h^2/12*((shadowTerms m U z).1-(shadowTerms m U z).2.1)

theorem takahashiShadow2_matching (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ)
    (_hm : positiveMass m) (_hU : ContDiff ℝ ∞ U) (B : Set (SymplecticCoordinates n))
    (_hB : IsCompact B) :
    matchesHamiltonian (fun h z ↦ takahashiShadow2 m U h (unpack z))
      (takahashiImada m U) B 4 ∧
    (∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
      |verletModifiedH (fun x ↦ quadraticKinetic m (unpack x).2)
        (fun x ↦ takahashiPotential m U h (unpack x).1) h z-
        takahashiShadow2 m U h (unpack z)| ≤ C*h^4) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.takahashiShadow2`；`MD.Ch03.takahashiShadow2_matching` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留有限函数并补修正势代入原Verlet影子多项式后的O(h⁴)差界、真实TI步的Hamiltonian匹配（端点O(h⁵)）；正质量、C∞、紧集为显式充分资格，Poisson到梯度联系保留相邻PotentialDoubleBracket。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |

[EXTRA] [EXTRA] 保留有限函数并补修正势代入原Verlet影子多项式后的O(h⁴)差界、真实TI步的Hamiltonian匹配（端点O(h⁵)）；正质量、C∞、紧集为显式充分资格，Poisson到梯度联系保留相邻PotentialDoubleBracket。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；有限函数的二次项为(1/12)(pᵀM⁻¹U″M⁻¹p−∇UᵀM⁻¹∇U)，与原页末式一致。positiveMass、全域C∞及紧B足以给出一致局部流和四阶截断影子Hamiltonian的端点O(h⁵)匹配；matchesHamiltonian的p=4确为h^(4+1)，只要求正小步长。第二合取是在对称小邻域上的势替换多项式差O(h⁴)，不声称无限级数收敛。shadowTerms、invMass、grad、unpack、J及kick/drift的对象和符号相符；无额外能量守恒假设。

### 7. 状态与证明位置

incomplete；`MD.Ch03.takahashiShadow2`：定义；`MD.Ch03.takahashiShadow2_matching`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L947)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.4-TakahashiProcessor · (3.9) · 印刷p.113 / PDFp.135

### 2. 原文陈述

> Introducing coordinate transformations

$$
\widetilde q=q-\frac{h^2}{12}M^{-1}\nabla U(q),\qquad\widetilde p=p+\frac{h^2}{12}U''(q)M^{-1}p,\tag{3.9}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def takahashiProcessor {n : ℕ} (m : Fin n → ℝ) (U : Q n → ℝ) (h : ℝ) (z : Z n) : Z n :=
  (z.1-(h^2/12) • invMass m (grad U z.1), z.2+(h^2/12) • hessianAction U z.1 (invMass m z.2))
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.takahashiProcessor` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Z n=(Fin n→ℝ)×(Fin n→ℝ)、grad 的坐标偏导、invMass m v i=(mᵢ)⁻¹vᵢ及hessianAction U q v=D(grad U)(q)v；向量加减和实数标量乘逐分量作用。输出第一分量是q−h²/12 M⁻¹grad U(q)，第二分量是p+h²/12 U''(q)M⁻¹p，与PDF135式(3.9)一致，尤其矩阵作用次序正确。此定义不声称全局可逆或辛性；没有额外假设、没有sorry。一般不光滑U的全定义导数延拓不影响其在教材光滑语境下的定义语义。

### 7. 状态与证明位置

self-contained；`MD.Ch03.takahashiProcessor`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L962)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.4-ProcessorEnergyPrinted · unnumbered_claim · 印刷p.113 / PDFp.135

### 2. 原文陈述

> and inserting these into $H$ yields, after expanding in a Taylor series:

$$
\begin{aligned}H(\widetilde q,\widetilde p)&=T+\frac{h^2}{12}\left(p^TM^{-1}U''M^{-1}p-\nabla U^TM^{-1}\nabla U\right)+O(h^4)\\ &=\widetilde H_h(q,p)+O(h^4).\end{aligned}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem processorEnergyPrinted :
    ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (Z n)),
      positiveMass m → ContDiff ℝ 4 U → IsCompact B →
      ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
        (|mechanicalEnergy m U (takahashiProcessor m U h z) -
          (quadraticKinetic m z.2+h^2/12*((shadowTerms m U z).1-(shadowTerms m U z).2.1))|
          ≤ C*h^4) ∧
        (|mechanicalEnergy m U (takahashiProcessor m U h z)-takahashiShadow2 m U h z|
          ≤ C*h^4) := by
  sorry



/-- 修正版，对应原文 MD-3.3.4-ProcessorEnergyPrinted。改动：首界补回遗漏势能U(q)，把T改成H；其余统一余项资格和第二界不变。 -/
```

独立修正版：

```lean
theorem processorEnergyPrinted_corrected :
    ∀ (n : ℕ) (m : Fin n → ℝ) (U : Q n → ℝ) (B : Set (Z n)),
      positiveMass m → ContDiff ℝ 4 U → IsCompact B →
      ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo (-δ) δ, ∀ z ∈ B,
        (|mechanicalEnergy m U (takahashiProcessor m U h z) -
          (mechanicalEnergy m U z+h^2/12*((shadowTerms m U z).1-(shadowTerms m U z).2.1))|
          ≤ C*h^4) ∧
        (|mechanicalEnergy m U (takahashiProcessor m U h z)-takahashiShadow2 m U h z|
          ≤ C*h^4) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.processorEnergyPrinted`；`MD.Ch03.processorEnergyPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正对角质量、U全域C⁴、紧初值集B；展示O(h⁴)按小h统一实际余项解释。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 首界补回遗漏势能U(q)，把T改成H；其余统一余项资格和第二界不变。 | [EXTRA] |

[EXTRA] 正对角质量、U全域C⁴、紧初值集B；展示O(h⁴)按小h统一实际余项解释。；[ERRATUM?] 首界补回遗漏势能U(q)，把T改成H；其余统一余项资格和第二界不变。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 mechanicalEnergy=T+U、quadraticKinetic=T、takahashiProcessor 为式(3.9)，shadowTerms 前两项分别是pᵀM⁻¹U''M⁻¹p与grad UᵀM⁻¹grad U，takahashiShadow2=H+h²/12(A−B)。签名把原文两行都转成同一C,δ下对紧集B一致的绝对余项界，∀n,m,U,B后存在C,δ再∀h,z的量词适合这种局部O解释；C⁴、正对角质量、紧集是合理且充分但非最弱的附加条件。然而第一界忠实照抄了原书错误的T，导致结论在h=0即要求|U(q)|≤0，而其假设没有U|_B=0。第二界没有这个遗漏且在所加条件下合理。[ERRATUM?]已被明确反例确认成立；不能因逐字忠实就把矛盾签名记为PASS。声明含sorry，此失败独立于证明状态。

### 7. 状态与证明位置

incomplete；`MD.Ch03.processorEnergyPrinted`：未证（原书疑误不证）；`MD.Ch03.processorEnergyPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L969)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.4-TakahashiEffectiveOrder · unnumbered_claim · 印刷p.113 / PDFp.135

### 2. 原文陈述

> Since $\widetilde H_h$ is assumed to be constant along the numerical solution, the coordinate transformations have the result of giving an effective order of four for the energy. It turns out that the Takahashi-Imada method is, more generally, an effective 4th order scheme, i.e. for arbitrary quantities, not just the energy [166].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem takahashiEffectiveOrder :
    ∀ n (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ ⊤ U →
      ∃ χ : ℝ → Z n ≃ₜ Z n, ∀ (γ : ℝ → Z n) τ, 0 < τ →
        solution (mechanicalField m (fun q => -grad U q)) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
        ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
          oneStepMaxError (fun h => textbookProcessedMethod χ
            (fun k => verlet m (fun q => -grad (takahashiPotential m U k) q) k) h)
            (τ/ν) γ ν ≤ C*(τ/ν)^4 := by
  sorry



/-- 修正版，对应原文 MD-3.3.4-TakahashiEffectiveOrder。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem takahashiEffectiveOrder_corrected :
    ∀ n (m : Fin n → ℝ) (U : Q n → ℝ), positiveMass m → ContDiff ℝ ∞ U →
      ∃ χ : ℝ → Z n ≃ₜ Z n, ∀ (γ : ℝ → Z n) τ, 0 < τ →
        solution (mechanicalField m (fun q => -grad U q)) γ 0 τ → ContinuousOn γ (Icc 0 τ) →
        ∃ C > 0, ∃ ν₀ : ℕ, 0 < ν₀ ∧ ∀ ν ≥ ν₀,
          oneStepMaxError (fun h => textbookProcessedMethod χ
            (fun k => verlet m (fun q => -grad (takahashiPotential m U k) q) k) h)
            (τ/ν) γ ν ≤ C*(τ/ν)^4 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.takahashiEffectiveOrder`；`MD.Ch03.takahashiEffectiveOrder_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正对角质量、U全域C∞、实际有限时间解连续；处理器χ要求全局homeomorphism，强于原文局部坐标展开。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 正对角质量、U全域C∞、实际有限时间解连续；处理器χ要求全局homeomorphism，强于原文局部坐标展开。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；所有相关定义均已找到并展开：solution 要求γ在[0,τ]每点满足实际HasDerivWithinAt；mechanicalField(m,F)(q,p)=(M⁻¹p,F(q))；verlet 的q新值为q+hM⁻¹p+h²/2 M⁻¹F(q)，p新值为p+h/2(F(q)+F(q新))，此处F=−grad(takahashiPotential m U h)。textbookProcessedMethod χ B h=(χ h)⁻¹∘B\_h∘χ h，oneStepIterate=(G\_h)^[k]，oneStepMaxError=max_{0≤k≤ν}‖G\_h^[k](γ(0))−γ(kh)‖。所以它确实控制有限时间的全部网格轨迹误差，不只是能量或一步误差。量词∃χ在∀γ,τ之前要求同一族全空间homeomorphism服务所有轨迹，并且χ完全没有近恒等、h光滑性、式(3.9)的二阶系数或局部作用域要求。PDF134–135所说的是给定坐标变换带来的有效阶；该签名无法识别那个处理器，并额外要求全空间双向连续的精确逆。全局homeomorphism是存在结论的强化，并非一个已给出的额外前提，不能仅标[EXTRA]就证明合理。正质量、全域C∞、连续有限时间解是合理的充分正则化；全域正则性比局部需要强。给定这些确切缺失，判FAIL，无须以定义缺失或导师判断为由判NEEDS\_HUMAN。χ⁻¹∘G∘χ本身不是方向错误：若P是原文从原坐标到带波浪号坐标的后处理，则应取χ=P⁻¹，得到P∘G∘P⁻¹。原文关于能量的解释显式以影子能量沿数值解恒定为假定，该签名也未单列这项条件式能量结论。声明含sorry；未声称已否证存在任意全局χ的四阶定理。

### 7. 状态与证明位置

incomplete；`MD.Ch03.takahashiEffectiveOrder`：未证（原书疑误不证）；`MD.Ch03.takahashiEffectiveOrder_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1002)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-ModifiedField · definition · 印刷p.113 / PDFp.135

### 2. 原文陈述

> Assume a smooth differential equation system

$$
\frac{\mathrm d\boldsymbol z}{\mathrm dt}=f(\boldsymbol z)
$$


> with flow map $\mathcal F_t$, and a one-step method $\mathcal G_h$. We obtain, typically by matching of terms from Taylor expansion, a “modified differential equation” as a series expansion

$$
\frac{\mathrm d\boldsymbol z}{\mathrm dt}=\widetilde f_h(\boldsymbol z)=f(\boldsymbol z)+h^rf_r(\boldsymbol z)+h^{r+1}f_{r+1}(\boldsymbol z)+\cdots,
$$


> where $r$ is the classical order of accuracy of the method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def formalField {n : ℕ} (f : Q n → Q n) (fj : ℕ → Q n → Q n) (r : ℕ)
    (z : Q n) (i : Fin n) : PowerSeries ℝ :=
  PowerSeries.mk (fun j => if j=0 then f z i else if r ≤ j then fj j z i else 0)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.formalField` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开 Q n=Fin n→ℝ；formalField 的0次系数为f，1≤j<r为0，j≥r为fj j，逐坐标组成形式向量场。context限定r≥1时准确；不宣称匹配存在性或级数收敛。无sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch03.formalField`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1030)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-LeadingModifiedField · unnumbered_claim · 印刷p.113 / PDFp.135

### 2. 原文陈述

> In fact, it is straightforward to show that if numerical method satisfies

$$
\mathcal G_h(\boldsymbol z)-\mathcal F_h(\boldsymbol z)=h^{r+1}\Gamma_{r+1}(\boldsymbol z)+O(h^{r+2}),
$$


> i.e. $h^{r+1}\Gamma_{r+1}$ is the leading term in the local error expansion, then we have

$$
f_r(\boldsymbol z)=\Gamma_{r+1}(\boldsymbol z).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem leadingModifiedField :
  ∀ (n r : ℕ) (f : Q n → Q n) (G Φ : ℝ → Q n → Q n) (D B : Set (Q n)) η,
    0 < r → ContDiff ℝ ∞ f → ContDiff ℝ ∞ (fun hz : ℝ × Q n => G hz.1 hz.2) →
    IsOpen D → IsCompact B → B ⊆ D → actualFlow f D Φ η → localOrder G Φ B r →
    ∃ fr : Q n → Q n, ContDiffOn ℝ ∞ fr D ∧
      (∀ z ∈ B, Tendsto (fun h => (h^(r+1))⁻¹ • (G h z-Φ h z)) (𝓝[≠] 0) (𝓝 (fr z))) ∧
      ∃ Γ : ℝ → Q n → ℝ → Q n, ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ∀ z ∈ B,
        Γ h z 0=z ∧ solution (fun x => f x+h^r • fr x) (Γ h z) 0 h ∧
          ‖G h z-Γ h z h‖ ≤ C*h^(r+2) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.leadingModifiedField` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | r>0、全域C∞的f及(h,z)↦G\_h、开放D与紧B及真实双向局部流；局部r阶条件。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |

[EXTRA] r>0、全域C∞的f及(h,z)↦G\_h、开放D与紧B及真实双向局部流；局部r阶条件。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量词覆盖任意有限维n、r>0、全域C∞的f及联合C∞的G，开放D、紧B⊆D和真实双向流。localOrder在正负小步长统一给r+1阶界；Taylor系数给出D上光滑fr，其在B上的值恰为h^(−r−1)(G−Φ)的双侧穿孔极限。结论另构造f+h^r fr的真实曲线并给一致O(h^(r+2))端点差，未以修改流匹配为前提。原文的Γ系数经极限表达，无符号或阶数倒置。

### 7. 状态与证明位置

incomplete；`MD.Ch03.leadingModifiedField`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1037)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-TruncatedHamiltonian · (3.11) · 印刷p.114 / PDFp.136

### 2. 原文陈述

> Define

$$
\bar H_k\stackrel{\mathrm{def}}=H+h^rH_r+h^{r+1}H_{r+1}+\cdots+h^kH_k.\tag{3.11}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def truncatedHamiltonian (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (z : E) : ℝ :=
  H z + ∑ j ∈ Finset.Icc r k, h ^ j * Hj j z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.truncatedHamiltonian` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意H、Hj、自然数r,k、实h和状态z的定义为H加闭整数区间Icc r k上的有限和，端点均包含，幂为h^j。对原文r≤k完全一致；r>k时空和仅是自然扩展，不影响原定义。未假设无穷级数收敛。

### 7. 状态与证明位置

self-contained；`MD.Ch03.truncatedHamiltonian`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1049)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-TruncationSmooth · unnumbered_claim · 印刷p.114 / PDFp.136

### 2. 原文陈述

> Suppose the Hamiltonian $H$ and modified Hamiltonian $\bar H_k$ are smooth functions globally defined on a convex, compact subset $\mathcal B$ of $\mathbb R^{2N_c}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem truncationSmooth (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (D : Set E) (hH : ContDiffOn ℝ ∞ H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ ∞ (Hj j) D) :
    ContDiffOn ℝ ∞ (textbookTruncatedHamiltonian H Hj r k h) D := by
  sorry

theorem truncationSmooth_C1 (H : E → ℝ) (Hj : ℕ → E → ℝ)
    (r k : ℕ) (h : ℝ) (D : Set E) (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ContDiffOn ℝ 1 (textbookTruncatedHamiltonian H Hj r k h) D := by
  apply MolecularDynamics.contDiffOn_textbookTruncatedHamiltonian <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.truncationSmooth`；`MD.Ch03.truncationSmooth_C1` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 系数在D上C∞，主结论C∞暂sorry；原C¹结论的既有证明作为独立辅助重查。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞主结论暂sorry，原C¹辅助已证；纠正旧元数据对证明能力的过度描述。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |

[EXTRA] 系数在D上C∞，主结论C∞暂sorry；原C¹结论的既有证明作为独立辅助重查。；[EXTRA] C∞主结论暂sorry，原C¹辅助已证；纠正旧元数据对证明能力的过度描述。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；主声明由H及实际有限索引r≤j≤k的系数在D上C∞推出有限截断在D上C∞，对任意实h成立；独立C¹辅助只要求同阶C¹并得到C¹，不冒充C∞证明。D无需开放即可用ContDiffOn封闭性。它是摘录假设的有限和光滑性辅助，非声称原书在此证明了全部定理假设。sorry仅为证明缺口，本任务不据此判FAIL。

### 7. 状态与证明位置

incomplete；`MD.Ch03.truncationSmooth`：未证（缺大型理论）；`MD.Ch03.truncationSmooth_C1`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1058)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-Thm3.1 · Theorem 3.1 · 印刷p.114–116 / PDFp.136–138

### 2. 原文陈述

> Theorem 3.1. Suppose the Hamiltonian $H$ and modified Hamiltonian $\bar H_k$ are smooth functions globally defined on a convex, compact subset $\mathcal B$ of $\mathbb R^{2N_c}$ and suppose that the exact solution and numerical approximations (for $h$ sufficiently small) are confined to $\mathcal B$. Then, we have asymptotically for $h\to0$ that

$$
H(\boldsymbol z_n)=H(\boldsymbol z_0)+O(h^r),
$$


> for $n=0,1,\ldots,\nu$ where $\tau=\nu h=O(h^{-k+r})$.

### 3. 原文证明

> Proof First observe that due to smoothness and the assumptions on $\mathcal B$, we have a global Lipschitz constant

$$
|H(\boldsymbol u)-H(\boldsymbol v)|< L\|\boldsymbol u-\boldsymbol v\|
$$


> for all $\boldsymbol u,\boldsymbol v\in\mathcal B$.
> Denote by $\mathcal F_h^{(k)}$ the flow map of the truncated Hamiltonian expansion $\bar H_k$,

$$
\mathcal F_h^{(k)}\stackrel{\mathrm{def}}=\exp(h\mathcal L_{\bar H_k}).
$$


> By construction, we have

$$
\boldsymbol z_{n+1}=\mathcal F_h^{(k)}(\boldsymbol z_n)+\boldsymbol\eta_n
$$


> where $\|\boldsymbol\eta_n\|\le Ch^{k+1}$.
> Since $\mathcal F_h^{(k)}$ preserves its Hamiltonian (3.11), we have

$$
\bar H_k(\mathcal F_h^{(k)}(\boldsymbol z_n))=\widetilde H_k(\boldsymbol z_n).
$$


> Now

$$
\begin{aligned}\bar H_k(\boldsymbol z_\nu)-\bar H_k(\boldsymbol z_0) &=\sum_{n=0}^{\nu-1}\bar H_k(\boldsymbol z_{n+1})-\bar H_k(\boldsymbol z_n)\\ &=\sum_{n=0}^{\nu-1}\bar H_k(\boldsymbol z_{n+1})-\widetilde H_k(\mathcal F_h^{(k)}(\boldsymbol z_n))\\ &=\sum_{n=0}^{\nu-1}\bar H_k(\mathcal F_h^{(k)}(\boldsymbol z_n)+\boldsymbol\eta_n)-\bar H_k(\mathcal F_h^{(k)}(\boldsymbol z_n)).\end{aligned}
$$


> Hence

$$
|\bar H_k(\boldsymbol z_\nu)-\bar H_k(\boldsymbol z_0)|\le L\sum_{n=0}^{\nu-1}\|\boldsymbol\eta_n\|\le L\nu h^{k+1}.
$$


> We have $\nu=\tau/h$, thus

$$
|\bar H_k(\boldsymbol z_\nu)-\bar H_k(\boldsymbol z_0)|\le L\tau h^k.
$$


> Next observe that

$$
H=\bar H_k-h^rH_{(r)}-h^{r+1}H_{(r+1)}-\cdots-h^kH_{(k)}=\bar H_k+O(h^r).
$$


> Therefore

$$
|H(\boldsymbol z_\nu)-H(\boldsymbol z_0)|\le L\nu h^{k+1}+O(h^r),
$$


> so that, as long as $\nu\le C_2h^{-k+r-1}$, we have

$$
|H(\boldsymbol z_\nu)-H(\boldsymbol z_0)|\le O(h^r).\quad\square
$$


完整原书证明按PDF136–138跨页拼接；保留bar/tilde混用、L沿用及缺陷常数C省略，不静默修订原书。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem theorem31 (n r k : ℕ)
    (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (_hr : 0 < r) (_hrk : r ≤ k) (_hD : IsOpen D) (_hconvD : Convex ℝ D)
    (_hB : IsCompact B) (_hconvB : Convex ℝ B) (_hBD : B ⊆ D)
    (_hH : ContDiffOn ℝ ∞ H D) (_hHj : ∀ j, ContDiffOn ℝ ∞ (Hj j) D)
    (_hmatching : finiteMatching H Hj r k D B G) :
    ∀ T > 0, ∃ M > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ∀ z₀ ∈ B, ∀ ν : ℕ,
      (∀ i ≤ ν, oneStepIterate G h z₀ i ∈ B) →
      (ν:ℝ)*h*h^(k-r) ≤ T →
      ‖H (oneStepIterate G h z₀ ν)-H z₀‖ ≤ M*h^r := by
  sorry



/-- 修正版，对应原文 MD-3.4-Thm3.1。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem theorem31_corrected (n r k : ℕ)
    (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (D B : Set (SymplecticCoordinates n)) (G : ℝ → SymplecticCoordinates n → SymplecticCoordinates n)
    (_hr : 0 < r) (_hrk : r ≤ k) (_hD : IsOpen D) (_hconvD : Convex ℝ D)
    (_hB : IsCompact B) (_hconvB : Convex ℝ B) (_hBD : B ⊆ D)
    (_hH : ContDiffOn ℝ ∞ H D) (_hHj : ∀ j, ContDiffOn ℝ ∞ (Hj j) D)
    (_hmatching : finiteMatching H Hj r k D B G) :
    ∀ T > 0, ∃ M > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ∀ z₀ ∈ B, ∀ ν : ℕ,
      (∀ i ≤ ν, oneStepIterate G h z₀ i ∈ B) →
      (ν:ℝ)*h*h^(k-r) ≤ T →
      ‖H (oneStepIterate G h z₀ ν)-H z₀‖ ≤ M*h^r := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | Theorem3.1中给定有限截断匹配后的能量估计；构造Hj及全截断存在性由MD-3.4-FiniteMatchingConstruction、MD-3.4-ArbitraryFiniteTruncation覆盖，原文保留。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.theorem31`；`MD.Ch03.theorem31_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | r>0,k≥r；开放凸D、紧凸B⊆D，H和Hj在D上C∞；给定相邻构造条目产出的真实有限匹配。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条是给定已构造Hj及finiteMatching后的能量定理；系数存在性与匹配构造明确由FiniteMatchingConstruction及ArbitraryFiniteTruncation承担，数值轨道约束不变。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] r>0,k≥r；开放凸D、紧凸B⊆D，H和Hj在D上C∞；给定相邻构造条目产出的真实有限匹配。；[EXTRA] 本条是给定已构造Hj及finiteMatching后的能量定理；系数存在性与匹配构造明确由FiniteMatchingConstruction及ArbitraryFiniteTruncation承担，数值轨道约束不变。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；Lean中n,r,k、实Hamiltonian及系数、开放凸D、紧凸B⊆D、r>0、r≤k和C∞条件均显式。finiteMatching给真实截断ODE、留D及统一A h^(k+1)端点缺陷；它不是能量结论。量词∀T>0后取M,δ，与ν及z₀无关；νh·h^(k−r)≤T正是时间O(h^(−k+r))。数值轨道直到ν留B足够，截断短轨可在B的紧邻域控制，无须全部留B。给定匹配后的能量签名数学上合理，但原书证明有记号及严格不等号疑误，须人工确认其解释；构造存在性不由本声明证明。

### 7. 状态与证明位置

incomplete；`MD.Ch03.theorem31`：未证（原书疑误不证）；`MD.Ch03.theorem31_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1079)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-CompactLipschitz · unnumbered_claim · 印刷p.114 / PDFp.136

### 2. 原文陈述

> Proof First observe that due to smoothness and the assumptions on $\mathcal B$, we have a global Lipschitz constant

$$
|H(\boldsymbol u)-H(\boldsymbol v)|\le L\|\boldsymbol u-\boldsymbol v\|
$$


> for all $\boldsymbol u,\boldsymbol v\in\mathcal B$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem compactLipschitz (D B : Set E) (hD : IsOpen D)
    (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (H : E → ℝ) (hH : ContDiffOn ℝ 1 H D) :
    ∃ L : ℝ, 0 < L ∧ ∀ u ∈ B, ∀ v ∈ B, ‖H v - H u‖ ≤ L * ‖v - u‖ := by
  apply MolecularDynamics.exists_compact_C1_lipschitz_constant <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.compactLipschitz` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 显式开放环境D及B⊆D、H在D为C¹；L由真实导数紧集界推出，未作假设。 | [EXTRA] |

[EXTRA] 显式开放环境D及B⊆D、H在D为C¹；L由真实导数紧集界推出，未作假设。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；D开放、B紧凸且包含于D、H在D为C¹；结论给真实存在的正L及B内任意u,v的统一差界。实数范数为绝对值，交换u,v不影响。原文smooth在紧集邻域的标准含义蕴含此C¹条件；[EXTRA]开放邻域是合理正则性解释，C¹已足够，L>0不限制Lipschitz结论。E的泛化合理；库证明无sorry。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.compactLipschitz`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1114)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-TruncatedFlow · definition · 印刷p.115 / PDFp.137

### 2. 原文陈述

> Denote by $\mathcal F_h^{(k)}$ the flow map of the truncated Hamiltonian expansion $\bar H_k$,

$$
\mathcal F_h^{(k)}\stackrel{\mathrm{def}}=\exp(h\mathcal L_{\bar H_k}).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def truncatedFlow {n : ℕ} (H : SymplecticCoordinates n → ℝ) (Hj : ℕ → SymplecticCoordinates n → ℝ)
    (r k : ℕ) (h : ℝ) (z : SymplecticCoordinates n) (γ : ℝ → SymplecticCoordinates n) : Prop :=
  γ 0=z ∧ solution (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)) γ 0 h
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.truncatedFlow` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对象是实际轨迹关系γ而非形式指数：γ0=z并在闭区间Icc 0 h满足J∇(H+Σh^j Hj)的ODE；代入端点γh即原文流的一步。它不声称解已存在或唯一，也不声称对任意负h构成反向流；h<0时Icc为空，而原文该段及后续匹配仅用正小步长，需按这一用途解释。

### 7. 状态与证明位置

self-contained；`MD.Ch03.truncatedFlow`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1121)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-FiniteMatchingConstruction · unnumbered_claim · 印刷p.115 / PDFp.137

### 2. 原文陈述

> By construction, we have

$$
\boldsymbol z_{n+1}=\mathcal F_h^{(k)}(\boldsymbol z_n)+\boldsymbol\eta_n
$$


> where $\|\boldsymbol\eta_n\|\le Ch^{k+1}$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem finiteMatchingConstruction :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ∞ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.finiteMatchingConstruction` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | smoothSymplecticData与原书构造上下文相同；保留任意k的真实finiteMatching为结论，不当作前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本声明的smoothSymplecticData现解析到MD.Ch03本地C∞定义（在MD-3-ModifiedConstruction同组完整列出）；H、联合G及Hj统一scoped ∞，其它资格和∃Hj后∀k顺序不变。 | [EXTRA] |

[EXTRA] smoothSymplecticData与原书构造上下文相同；保留任意k的真实finiteMatching为结论，不当作前提。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[EXTRA] 本声明的smoothSymplecticData现解析到MD.Ch03本地C∞定义（在MD-3-ModifiedConstruction同组完整列出）；H、联合G及Hj统一scoped ∞，其它资格和∃Hj后∀k顺序不变。

### 6. 审计结论

本轮修复：本声明的smoothSymplecticData现解析到MD.Ch03本地C∞定义（在MD-3-ModifiedConstruction同组完整列出）；H、联合G及Hj统一scoped ∞，其它资格和∃Hj后∀k顺序不变。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；结论量词∃同一Hj族，∀k≥r给真实finiteMatching，确实保留构造而未预设匹配；finiteMatching包含γ0=z、真实ODE、留D和统一端点误差。但实际smoothSymplecticData在H及联合G的ContDiffOn位置仍使用裸⊤，与[EXTRA]声称恢复scoped ∞直接矛盾。在任务指定的库语义下这是Cω前提，严格加强原书的smooth，不能标为C∞版本。开放凸D和紧凸B等其余域条件、辛Jacobian及局部阶数与所述充分条件相容。

### 7. 状态与证明位置

incomplete；`MD.Ch03.finiteMatchingConstruction`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1129)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-TruncatedConservation · unnumbered_claim · 印刷p.115 / PDFp.137

### 2. 原文陈述

> Since $\mathcal F_h^{(k)}$ preserves its Hamiltonian (3.11), we have

$$
\bar H_k(\mathcal F_h^{(k)}(\boldsymbol z_n))=\widetilde H_k(\boldsymbol z_n).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem truncatedConservation (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0) := by
  apply MolecularDynamics.textbookHamiltonian_energy_const_on_Icc <;> assumption



/-- 修正版，对应原文 MD-3.4-TruncatedConservation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem truncatedConservation_corrected (H : SymplecticCoordinates Nc → ℝ)
    (γ : ℝ → SymplecticCoordinates Nc) (τ : ℝ)
    (hH : ∀ t ∈ Icc 0 τ, DifferentiableAt ℝ H (γ t))
    (hγ : ∀ t ∈ Icc 0 τ,
      HasDerivWithinAt γ (textbookHamiltonianVectorField H (γ t)) (Icc 0 τ) t) :
    ∀ t ∈ Icc 0 τ, H (γ t) = H (γ 0) := by
  apply MolecularDynamics.textbookHamiltonian_energy_const_on_Icc <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.truncatedConservation`；`MD.Ch03.truncatedConservation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 沿γ对K的可微性与真实ODE在闭区间明示，包含端点；构造γ属于另项。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 沿γ对K的可微性与真实ODE在闭区间明示，包含端点；构造γ属于另项。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；对任意H、曲线γ及实τ，沿Icc 0 τ要求H在γt可微以及实际Hamiltonian ODE的within导数；结论覆盖所有该区间t，包括端点。由dH(J∇H)=0得常值；τ<0时结论空真，τ=0为自反等式。不预设守恒，取H为截断K后得到一步守恒。签名正确，但原书等式右边印为tilde，须确认与bar指同一函数。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.truncatedConservation`：已证；`MD.Ch03.truncatedConservation_corrected`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1140)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-EnergyTelescoping · unnumbered_claim · 印刷p.115 / PDFp.137

### 2. 原文陈述

> Now

$$
\begin{aligned}\bar H_k(\boldsymbol z_\nu)-\bar H_k(\boldsymbol z_0)&=\sum_{n=0}^{\nu-1}\bar H_k(\boldsymbol z_{n+1})-\bar H_k(\boldsymbol z_n)\\ &=\sum_{n=0}^{\nu-1}\bar H_k(\boldsymbol z_{n+1})-\widetilde H_k(\mathcal F_h^{(k)}(\boldsymbol z_n))\\ &=\sum_{n=0}^{\nu-1}\bar H_k(\mathcal F_h^{(k)}(\boldsymbol z_n)+\boldsymbol\eta_n)-\bar H_k(\mathcal F_h^{(k)}(\boldsymbol z_n)).\end{aligned}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem energyTelescoping {E : Type*} (K : E → ℝ)
    (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    ∑ i ∈ Finset.range n, (K (oneStepIterate G h z₀ (i + 1)) -
      K (oneStepIterate G h z₀ i)) = K (oneStepIterate G h z₀ n) - K z₀ := by
  apply MolecularDynamics.oneStep_energy_telescoping <;> assumption

theorem energyTelescoping_complete (K : E → ℝ) (G : ℝ → E → E)
    (F : E → E) (h : ℝ) (z₀ : E) (n : ℕ)
    (_hconserve : ∀ i < n, K (F (oneStepIterate G h z₀ i))=K (oneStepIterate G h z₀ i)) :
    let z := oneStepIterate G h z₀
    let η := fun i ↦ z (i+1)-F (z i)
    K (z n)-K z₀ = ∑ i ∈ Finset.range n, (K (z (i+1))-K (z i)) ∧
    (∑ i ∈ Finset.range n, (K (z (i+1))-K (z i))) =
      ∑ i ∈ Finset.range n, (K (z (i+1))-K (F (z i))) ∧
    (∑ i ∈ Finset.range n, (K (z (i+1))-K (F (z i)))) =
      ∑ i ∈ Finset.range n, (K (F (z i)+η i)-K (F (z i))) := by
  sorry



/-- 修正版，对应原文 MD-3.4-EnergyTelescoping。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem energyTelescoping_corrected {E : Type*} (K : E → ℝ)
    (G : ℝ → E → E) (h : ℝ) (z₀ : E) (n : ℕ) :
    ∑ i ∈ Finset.range n, (K (oneStepIterate G h z₀ (i + 1)) -
      K (oneStepIterate G h z₀ i)) = K (oneStepIterate G h z₀ n) - K z₀ := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.energyTelescoping`；`MD.Ch03.energyTelescoping_complete`；`MD.Ch03.energyTelescoping_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留已证首行望远镜恒等式；补给定守恒截断步F、真实差η=数值步−F的完整三行等式，不以待证能量差为前提。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA] 保留已证首行望远镜恒等式；补给定守恒截断步F、真实差η=数值步−F的完整三行等式，不以待证能量差为前提。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；首声明是任意类型E上实际G迭代的有限实数差望远镜恒等式。complete在带减法/加法的状态空间中用ηi=z(i+1)−F(zi)，在明确的一步守恒前提下给三段等式，n=0亦成立；该前提由独立守恒条目供应，不循环假定总能量差。统一K是合理的记号澄清，但不是原印bar/tilde混用本身的证明。

### 7. 状态与证明位置

incomplete；`MD.Ch03.energyTelescoping`：已证；`MD.Ch03.energyTelescoping_complete`：未证（原书疑误不证）；`MD.Ch03.energyTelescoping_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1162)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-UniformTruncatedLipschitz · unnumbered_claim · 印刷p.115 / PDFp.137

### 2. 原文陈述

> Hence

$$
|\bar H_k(\boldsymbol z_\nu)-\bar H_k(\boldsymbol z_0)|\le L\sum_{n=0}^{\nu-1}\|\boldsymbol\eta_n\|\le L\nu h^{k+1}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem uniformTruncatedLipschitz
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (D B : Set E) (hD : IsOpen D)
    (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ∃ L : ℝ, 0 < L ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ u ∈ B, ∀ v ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h v -
        textbookTruncatedHamiltonian H Hj r k h u‖ ≤ L * ‖v - u‖ := by
  apply MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_lipschitz <;> assumption

theorem uniformTruncatedLipschitz_chain (K : E → ℝ) (G : ℝ → E → E)
    (F : E → E) (h L A : ℝ) (k n : ℕ) (z₀ : E)
    (_hh : 0 ≤ h) (_hL : 0 ≤ L) (_hA : 0 ≤ A)
    (_hconserve : ∀ i < n, K (F (oneStepIterate G h z₀ i))=K (oneStepIterate G h z₀ i))
    (_hlip : ∀ i < n,
      |K (oneStepIterate G h z₀ (i+1))-K (F (oneStepIterate G h z₀ i))| ≤
        L*‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖)
    (_hdefect : ∀ i < n, ‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖ ≤ A*h^(k+1)) :
    |K (oneStepIterate G h z₀ n)-K z₀| ≤
      L*∑ i ∈ Finset.range n, ‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖ ∧
    (L*∑ i ∈ Finset.range n, ‖oneStepIterate G h z₀ (i+1)-F (oneStepIterate G h z₀ i)‖) ≤
      L*A*(n:ℝ)*h^(k+1) := by
  sorry



/-- 修正版，对应原文 MD-3.4-UniformTruncatedLipschitz。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem uniformTruncatedLipschitz_corrected
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (D B : Set E) (hD : IsOpen D)
    (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D)
    (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D) :
    ∃ L : ℝ, 0 < L ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ u ∈ B, ∀ v ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h v -
        textbookTruncatedHamiltonian H Hj r k h u‖ ≤ L * ‖v - u‖ := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.uniformTruncatedLipschitz`；`MD.Ch03.uniformTruncatedLipschitz_chain`；`MD.Ch03.uniformTruncatedLipschitz_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 开放D、紧凸B⊆D及H和有限H\_j在D C¹；0≤h≤1；L由有限系数导数界推出。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留统一截断Lipschitz定理，补原完整能量差≤LΣ‖η‖≤LAνh^(k+1)链；A为原文缺陷常数重命名，F为所给守恒截断一步。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 开放D、紧凸B⊆D及H和有限H\_j在D C¹；0≤h≤1；L由有限系数导数界推出。；[EXTRA] 保留统一截断Lipschitz定理，补原完整能量差≤LΣ‖η‖≤LAνh^(k+1)链；A为原文缺陷常数重命名，F为所给守恒截断一步。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；第一声明由紧凸B⊆开放D、H及有限Hj的C¹得到单个正L，对所有0≤h≤1及u,v∈B同时成立。chain显式要求非负h,L,A、各步守恒、实际端点Lipschitz界和缺陷≤A h^(k+1)，结论完整保留LΣ缺陷≤LA n h^(k+1)，零步亦成立。这些是合理拆分资格，不把总能量结论作为假设；原页省略C及沿用H的L仍需人工解释。

### 7. 状态与证明位置

incomplete；`MD.Ch03.uniformTruncatedLipschitz`：已证；`MD.Ch03.uniformTruncatedLipschitz_chain`：未证（原书疑误不证）；`MD.Ch03.uniformTruncatedLipschitz_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1197)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-TruncationRemainder · unnumbered_claim · 印刷p.115 / PDFp.137

### 2. 原文陈述

> Next observe that

$$
H=\bar H_k-h^rH_{(r)}-h^{r+1}H_{(r+1)}-\cdots-h^kH_{(k)}=\bar H_k+O(h^r).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem truncationRemainder
    (H : E → ℝ) (Hj : ℕ → E → ℝ) (r k : ℕ) (B : Set E) (hB : IsCompact B)
    (hHj : ∀ j ∈ Finset.Icc r k, ContinuousOn (Hj j) B) :
    ∃ C : ℝ, 0 < C ∧ ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B,
      ‖textbookTruncatedHamiltonian H Hj r k h z - H z‖ ≤ C * h ^ r := by
  apply MolecularDynamics.exists_uniform_textbookTruncatedHamiltonian_remainder <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.truncationRemainder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 各有限系数在紧B连续；0≤h≤1；统一正C由紧性推出，未供应所需余项界。 | [EXTRA] |

[EXTRA] 各有限系数在紧B连续；0≤h≤1；统一正C由紧性推出，未供应所需余项界。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；只对有限索引要求系数在紧B连续，不需H连续，因为截断减H恰好消去H。取统一正C，对0≤h≤1所有z∈B给范数差≤C h^r；j≥r保证h^j≤h^r，包括r=0、h=0和空索引区间。与原文有限代数等式所导出的O(h^r)一致；此条用差界表达，不冒充无限级数余项。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.truncationRemainder`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1240)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-PhysicalEnergyDrift · unnumbered_claim · 印刷p.115 / PDFp.137

### 2. 原文陈述

> Therefore

$$
|H(\boldsymbol z_\nu)-H(\boldsymbol z_0)|\le L\nu h^{k+1}+O(h^r),
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem physicalEnergyDrift
    (H : SymplecticCoordinates Nc → ℝ) (Hj : ℕ → SymplecticCoordinates Nc → ℝ)
    (r k : ℕ) (D B : Set (SymplecticCoordinates Nc))
    (hD : IsOpen D) (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D) (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D)
    (G : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (γ : ℝ → SymplecticCoordinates Nc → ℝ → SymplecticCoordinates Nc)
    (hγ₀ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, γ h z 0 = z)
    (hγB : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h, γ h z t ∈ B)
    (hγ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h,
      HasDerivWithinAt (γ h z)
        (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)
          (γ h z t)) (Icc 0 h) t) :
    ∃ C : ℝ, 0 < C ∧ ∃ L : ℝ, 0 < L ∧
      ∀ h ∈ Icc (0 : ℝ) 1, ∀ z₀, ∀ n : ℕ,
        (∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) →
        ‖H (oneStepIterate G h z₀ n) - H z₀‖ ≤ 2 * C * h ^ r +
          L * ∑ i ∈ Finset.range n, ‖G h (oneStepIterate G h z₀ i) -
            γ h (oneStepIterate G h z₀ i) h‖ := by
  apply MolecularDynamics.textbook_energy_drift_le_actual_defects <;> assumption

theorem physicalEnergyDrift_complete
    (H : SymplecticCoordinates Nc → ℝ) (Hj : ℕ → SymplecticCoordinates Nc → ℝ)
    (r k : ℕ) (D B : Set (SymplecticCoordinates Nc))
    (hD : IsOpen D) (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D) (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D)
    (G : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (γ : ℝ → SymplecticCoordinates Nc → ℝ → SymplecticCoordinates Nc)
    (hγ₀ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, γ h z 0 = z)
    (hγB : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h, γ h z t ∈ B)
    (hγ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h,
      HasDerivWithinAt (γ h z)
        (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)
          (γ h z t)) (Icc 0 h) t)
    (A : ℝ) (_hA : 0 ≤ A)
    (_hdefect : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ‖G h z-γ h z h‖ ≤ A*h^(k+1)) :
    ∃ C : ℝ, 0 < C ∧ ∃ L : ℝ, 0 < L ∧
      ∀ h ∈ Icc (0 : ℝ) 1, ∀ z₀, ∀ n : ℕ,
        (∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) →
        ‖H (oneStepIterate G h z₀ n) - H z₀‖ ≤ 2 * C * h ^ r +
          L*A*(n:ℝ)*h^(k+1) := by
  sorry



/-- 修正版，对应原文 MD-3.4-PhysicalEnergyDrift。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem physicalEnergyDrift_corrected
    (H : SymplecticCoordinates Nc → ℝ) (Hj : ℕ → SymplecticCoordinates Nc → ℝ)
    (r k : ℕ) (D B : Set (SymplecticCoordinates Nc))
    (hD : IsOpen D) (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D) (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D)
    (G : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (γ : ℝ → SymplecticCoordinates Nc → ℝ → SymplecticCoordinates Nc)
    (hγ₀ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, γ h z 0 = z)
    (hγB : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h, γ h z t ∈ B)
    (hγ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h,
      HasDerivWithinAt (γ h z)
        (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)
          (γ h z t)) (Icc 0 h) t) :
    ∃ C : ℝ, 0 < C ∧ ∃ L : ℝ, 0 < L ∧
      ∀ h ∈ Icc (0 : ℝ) 1, ∀ z₀, ∀ n : ℕ,
        (∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) →
        ‖H (oneStepIterate G h z₀ n) - H z₀‖ ≤ 2 * C * h ^ r +
          L * ∑ i ∈ Finset.range n, ‖G h (oneStepIterate G h z₀ i) -
            γ h (oneStepIterate G h z₀ i) h‖ := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.physicalEnergyDrift`；`MD.Ch03.physicalEnergyDrift_complete`；`MD.Ch03.physicalEnergyDrift_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 开放D、紧凸B⊆D及有限C¹系数；给定真实截断ODE族γ及其留B、γ(h,z,0)=z，未假设γ的能量守恒或误差界。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留已证实际缺陷和界，新增实际截断流的统一一步匹配误差资格与完整2Ch^r+LAνh^(k+1)结论；不是以能量结论为假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 开放D、紧凸B⊆D及有限C¹系数；给定真实截断ODE族γ及其留B、γ(h,z,0)=z，未假设γ的能量守恒或误差界。；[EXTRA] 保留已证实际缺陷和界，新增实际截断流的统一一步匹配误差资格与完整2Ch^r+LAνh^(k+1)结论；不是以能量结论为假设。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：PASS；首声明明确真实截断ODE族γ、初值、所有0≤h≤1短轨留B和有限C¹系数；推得两端余项2C h^r及L乘实际缺陷和。complete另加非负统一A及一步误差≤A h^(k+1)，结论为2C h^r+LA n h^(k+1)，量词C,L先于h,z₀,n，数值轨道直到n留B。未假设能量守恒，h=0也相容。这是原文漂移式的合理显式常数版；原页L的来源及吸收常数需要与前条一起澄清。

### 7. 状态与证明位置

incomplete；`MD.Ch03.physicalEnergyDrift`：已证；`MD.Ch03.physicalEnergyDrift_complete`：未证（原书疑误不证）；`MD.Ch03.physicalEnergyDrift_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1251)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-PolynomialEnergyRate · unnumbered_claim · 印刷p.116 / PDFp.138

### 2. 原文陈述

> so that, as long as $\nu\le C_2h^{-k+r-1}$, we have

$$
|H(\boldsymbol z_\nu)-H(\boldsymbol z_0)|\le O(h^r).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem polynomialEnergyRate
    (H : SymplecticCoordinates Nc → ℝ) (Hj : ℕ → SymplecticCoordinates Nc → ℝ)
    (r k : ℕ) (hrk : r ≤ k) (D B : Set (SymplecticCoordinates Nc))
    (hD : IsOpen D) (hB : IsCompact B) (hconv : Convex ℝ B) (hBD : B ⊆ D)
    (hH : ContDiffOn ℝ 1 H D) (hHj : ∀ j ∈ Finset.Icc r k, ContDiffOn ℝ 1 (Hj j) D)
    (G : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (γ : ℝ → SymplecticCoordinates Nc → ℝ → SymplecticCoordinates Nc)
    (hγ₀ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, γ h z 0 = z)
    (hγB : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h, γ h z t ∈ B)
    (hγ : ∀ h ∈ Icc (0 : ℝ) 1, ∀ z ∈ B, ∀ t ∈ Icc 0 h,
      HasDerivWithinAt (γ h z)
        (textbookHamiltonianVectorField (textbookTruncatedHamiltonian H Hj r k h)
          (γ h z t)) (Icc 0 h) t)
    (A T : ℝ) (hA : 0 ≤ A) (hT : 0 ≤ T)
    (hdefect : ∀ h ∈ Ioc (0 : ℝ) 1, ∀ z ∈ B, ‖G h z - γ h z h‖ ≤ A * h ^ (k + 1)) :
    ∃ M : ℝ, 0 < M ∧ ∀ h ∈ Ioc (0 : ℝ) 1, ∀ z₀, ∀ n : ℕ,
      (∀ i ≤ n, oneStepIterate G h z₀ i ∈ B) →
      (n : ℝ) * h * h ^ (k - r) ≤ T →
      ‖H (oneStepIterate G h z₀ n) - H z₀‖ ≤ M * h ^ r := by
  exact MolecularDynamics.textbook_energy_drift_rate_of_flow_defect
    H Hj r k hrk D B hD hB hconv hBD hH hHj G γ hγ₀ hγB hγ A T hA hT hdefect
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.polynomialEnergyRate` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]hdefect是假设明确给出的实际一步O(h^(k+1))端点界，源自原书“By construction”尚未形式化的先验；不是本条能量结论。 | [EXTRA] |
| 技术资格或版本解释 | D/B及C¹、实际截断ODE留B、r≤k、A,T≥0、0<h≤1、数值轨道留B；长时间条件νhh^(k−r)≤T。 | [EXTRA] |

[EXTRA] [EXTRA]hdefect是假设明确给出的实际一步O(h^(k+1))端点界，源自原书“By construction”尚未形式化的先验；不是本条能量结论。；D/B及C¹、实际截断ODE留B、r≤k、A,T≥0、0<h≤1、数值轨道留B；长时间条件νhh^(k−r)≤T。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；定义已展开：SymplecticCoordinates n=(Fin n ⊕ Fin n)→ℝ；textbookJ=[[0,I],[-I,0]]；textbookHamiltonianVectorField K z=J·((fderiv ℝ K z)(Pi.single i 1))_i；oneStepIterate G h z₀ i=(G h)^[i] z₀；textbookTruncatedHamiltonian H Hj r k h z=H z+Σ_{j∈Icc r k}h^j Hj j z。PASS（附件明确限定的条件推论）。hdefect是G h z与真实截断ODE端点γ h z h之间的统一O(h^(k+1))界，未假设能量结论；它对应原页By construction，作为条件推论的EXTRA合理，但不能替代未完成的匹配构造。0<h≤1与r≤k使n h h^(k−r)≤T等价于n≤T h^(−k+r−1)；取T=C₂。∃M先于h,z₀,n给出统一O(h^r)，包括n=0。轨道留B、开放邻域和C¹正则为原紧域/光滑条件的明示；M可依赖k,A,T。Ch03.lean:752-773无sorry，整体Theorem 3.1未因此完成。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.polynomialEnergyRate`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1325)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-StepCountPower · unnumbered_claim · 印刷p.116 / PDFp.138

### 2. 原文陈述

> so that, as long as $\nu\le C_2h^{-k+r-1}$, we have

$$
|H(\boldsymbol z_\nu)-H(\boldsymbol z_0)|\le O(h^r).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem stepCountPower (r k n : ℕ) (hrk : r ≤ k) (h : ℝ) :
    (n : ℝ) * h ^ (k + 1) = ((n : ℝ) * h * h ^ (k - r)) * h ^ r := by
  apply MolecularDynamics.energy_step_count_power_factor <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 仅步数/步长幂次分解代数辅助；本条所引原句能量O(h^r)由MD-3.4-PolynomialEnergyRate承担。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.stepCountPower` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 自然数r≤k使k−r没有截断损失；不将此代数辅助冒充完整能量定理。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条仅承担步数幂次代数辅助；原句的完整能量率由MD-3.4-PolynomialEnergyRate承担，原文不删并显式跨条映射。 | [EXTRA] |

[EXTRA] 自然数r≤k使k−r没有截断损失；不将此代数辅助冒充完整能量定理。；[EXTRA] 本条仅承担步数幂次代数辅助；原句的完整能量率由MD-3.4-PolynomialEnergyRate承担，原文不删并显式跨条映射。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量词为自然数r,k,n、r≤k及任意实h，结论n h^(k+1)=(n h h^(k−r))h^r。自然数减法因r≤k而正确，h=0及负h也成立。它仅是精确幂次辅助；JSON已明确原句完整能量率另映射PolynomialEnergyRate。本批未提供该外条声明，不能据此认定该外条已审校或完整能量率已形式证明。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.stepCountPower`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1350)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-ArbitraryFiniteTruncation · unnumbered_claim · 印刷p.116 / PDFp.138

### 2. 原文陈述

> If the differential equations are infinitely differentiable, we may take the truncation index $k$ as large as we like, but the constants appearing in the above theorem will depend on the truncation index in a complicated way.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem arbitraryFiniteTruncation :
  ∀ (n r : ℕ) (H : SymplecticCoordinates n → ℝ) (D B : Set (SymplecticCoordinates n))
    (G Φ : ℝ → SymplecticCoordinates n → SymplecticCoordinates n),
    smoothSymplecticData H D B G Φ r →
    ∃ Hj : ℕ → SymplecticCoordinates n → ℝ, (∀ j, ContDiffOn ℝ ∞ (Hj j) D) ∧
      ∀ k ≥ r, finiteMatching H Hj r k D B G := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.arbitraryFiniteTruncation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | smoothSymplecticData保持全部Hamiltonian/近恒等辛/compact条件；完整∀k匹配作为结论，没有把它当作前提。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本声明的smoothSymplecticData现解析到MD.Ch03本地C∞定义（在MD-3-ModifiedConstruction同组完整列出）；H、联合G及Hj统一scoped ∞，其它资格和∃Hj后∀k顺序不变。 | [EXTRA] |

[EXTRA] smoothSymplecticData保持全部Hamiltonian/近恒等辛/compact条件；完整∀k匹配作为结论，没有把它当作前提。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[EXTRA] 本声明的smoothSymplecticData现解析到MD.Ch03本地C∞定义（在MD-3-ModifiedConstruction同组完整列出）；H、联合G及Hj统一scoped ∞，其它资格和∃Hj后∀k顺序不变。

### 6. 审计结论

本轮修复：本声明的smoothSymplecticData现解析到MD.Ch03本地C∞定义（在MD-3-ModifiedConstruction同组完整列出）；H、联合G及Hj统一scoped ∞，其它资格和∃Hj后∀k顺序不变。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；n,r,H,D,B,G,Φ的对象及Hamiltonian向量场、辛Jacobian、真实局部流、紧集、凸域和局部阶均已展开核对。结论先选统一的Hj序列，再对所有k≥r给出finiteMatching；δ、A和Γ位于每个finiteMatching的存在量词内，允许依赖k，且保留全z∈B及0<h<δ的实际截断流和端点误差。问题在于smoothSymplecticData仍有两处ContDiffOn ℝ ⊤：H和联合映射(h,z)↦G h z。按指定Mathlib含义这是Cω，而结论Hj的∞才是C∞；[EXTRA]称前提和输出均已恢复∞与本次实际摘录不符。当前声明至多覆盖解析输入的子情形，未忠实覆盖原句任意C∞输入。FAIL来自前提范围及修复标注不符，非sorry，也不表示解析子情形已被反驳。

### 7. 状态与证明位置

incomplete；`MD.Ch03.arbitraryFiniteTruncation`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1358)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-AnalyticDefect · unnumbered_claim · 印刷p.116 / PDFp.138

### 2. 原文陈述

> It is possible to prove (see discussions in [164, 227] for more detail), that for many standard classes of numerical methods, there are real, positive constants $C,D$ such that

$$
\|\mathcal G_h(\zeta)-\mathcal F_h^{(k)}(\zeta)\|\le Ch[D(k+1)h]^{k+1},
$$


> giving a precise bound on the magnitude of the difference between the time $h$ evolution under the truncated perturbed Hamiltonian and the numerical method.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1370)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-OptimalTruncation · unnumbered_claim · 印刷p.116 / PDFp.138

### 2. 原文陈述

> If $h$ is small, then for $k$ sufficiently small the quantity in brackets is less than one and the difference from the truncated approximation decreases in magnitude with increasing $k$. As soon as $k$ satisfies

$$
k+1>\frac1{Dh}
$$


> the power grows monotonically without bound. We can minimize the difference between $\mathcal G_h$ and $\mathcal F_h^{(k)}$ by choosing

$$
k=\frac1{Dh\mathrm e}-1,
$$


> in which case,

$$
\|\mathcal G_h(\zeta)-\mathcal F_h^{(k)}(\zeta)\|<\widetilde C h\mathrm e^{-1/(\gamma h)},\qquad\gamma=\frac1{D\mathrm e}.
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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1417)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-ExponentialFlat · unnumbered_claim · 印刷p.116 / PDFp.138

### 2. 原文陈述

> This bound tends to zero extremely rapidly (more rapidly than any power of $h$) as $h\to0$.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1438)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-ScalarVerletShadow4 · definition · 印刷p.117 / PDFp.139

### 2. 原文陈述

> The modified energy for the Verlet method for a single degree of freedom system with energy $H=p^2/2+U(q)$ is

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1458)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-CommutingEnergy · unnumbered_claim · 印刷p.117 / PDFp.139

### 2. 原文陈述

> Suppose that, somehow, $H$ were exactly conserved along the numerical solution, so

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1499)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-CommutingEnergySymmetry · unnumbered_claim · 印刷p.118 / PDFp.140

### 2. 原文陈述

> Since $\{g_1,g_2\}=-\{g_2,g_1\}$, we have

$$
\{\widetilde H_h,H\}=0.
$$


> This would imply that $\widetilde H_h$ is actually, itself, a first integral of the molecular system.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1522)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1553)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1576)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1591)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-LinearEulerIntegral · unnumbered_claim · 印刷p.123 / PDFp.145

### 2. 原文陈述

> Generalizing this slightly, we could imagine a system of ODEs of the form

$$
\dot{\boldsymbol z}=\boldsymbol f(\boldsymbol z),
$$


> such that, for some vector $\boldsymbol b$,

$$
\boldsymbol b\cdot \boldsymbol f(\boldsymbol z)\equiv0,
$$


> then $I(\boldsymbol z)=\boldsymbol b\cdot\boldsymbol z$ is a first integral. It is straightforward to see that Euler's method conserves such a linear first integral exactly, as is true of many other popular numerical methods.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1597)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1611)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-VerletOscillatorEnergy · unnumbered_claim · 印刷p.123 / PDFp.145

### 2. 原文陈述

> In the case of Euler's method applied to the harmonic oscillator, the error in energy grows with time and without bound. In the case of Störmer-Verlet, the energy fluctuates but remains bounded for all time and at its worst is of size proportional to $h^2$, a numerical observation that is supported by the existence of the modified Hamiltonian.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1620)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-MomentumProjection · definition · 印刷p.123 / PDFp.145

### 2. 原文陈述

> We start by taking a timestep with any arbitrary (nonconserving) numerical method, say to an intermediate phase point $\overline{\boldsymbol Q},\overline{\boldsymbol P}$, then we “fix it up” by scaling the momentum by an adjustment factor, defining

$$
\boldsymbol Q=\overline{\boldsymbol Q},\qquad\boldsymbol P=\gamma\overline{\boldsymbol P},
$$


> selecting $\gamma$ so that the energy in the result is a prescribed value $E$.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1756)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1759)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-ProjectionFactor · (3.13) · 印刷p.124 / PDFp.146

### 2. 原文陈述

> and, since $\overline{\boldsymbol Q}$ is known, this gives

$$
\gamma=\left(\frac{E-\overline U}{\overline K}\right)^{1/2},\tag{3.13}
$$


> where $\overline U=U(\overline{\boldsymbol Q})$ and $\overline K=\overline{\boldsymbol P}^{T}\boldsymbol M^{-1}\overline{\boldsymbol P}/2$ are the potential and kinetic energies after a step of the original non-conserving scheme.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1762)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-ProjectionEnergy · unnumbered_claim · 印刷p.124 / PDFp.146

### 2. 原文陈述

> We also must assume that $E-\overline U\ge0$, which, for a large system, seems the likely situation, since we may suppose $\overline K+\overline U=\overline E\approx E$, thus $E-\overline U\approx\overline K\ge0$. Thus we assume a system with many degrees of freedom so that all the conditions for the method to be well defined are satisfied.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1766)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-KineticZero · unnumbered_claim · 印刷p.124 / PDFp.146

### 2. 原文陈述

> If, in the harmonic oscillator, $\overline p_{n+1}$ happens to vanish, then $\gamma$ is not defined. We could work around this obstacle by assuming a large number of degrees of freedom, in which case $\overline K$ is only zero if all the momenta simultaneously vanish and this situation is, in a realistic model of a molecule, extremely unlikely.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1772)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-EnergyProjectionRelation · definition · 印刷p.124 / PDFp.146

### 2. 原文陈述

> There are many alternative projection methods which we could use for this purpose, which might alter both the positions and momenta. Modifying the positions means that we will somehow need to solve the equation

$$
H(Q,P)=E,
$$


> where $Q$ depends on a parameter or parameters (typically a Lagrange multiplier that is used to maintain the constraint).

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1777)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1781)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.5-LinearContinuousIntegral · unnumbered_claim · 印刷p.123 / PDFp.145

### 2. 原文陈述

> Generalizing this slightly, we could imagine a system of ODEs of the form

$$
\dot{\boldsymbol z}=f(\boldsymbol z),
$$


> such that, for some vector $\boldsymbol b$,

$$
\boldsymbol b\cdot f(\boldsymbol z)\equiv0,
$$


> then $I(\boldsymbol z)=\boldsymbol b\cdot\boldsymbol z$ is a first integral.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1792)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6-HamiltonianFlowStructures · unnumbered_claim · 印刷p.127–128 / PDFp.149–150

### 2. 原文陈述

> The flow of a Hamiltonian system of the form $H=p^TM^{-1}p/2+U(q)$ will preserve all of the following:
> 1. The symplectic two-form $\mathrm dq\wedge\mathrm dp$.
> 2. The Hamiltonian (i.e., the energy) $H$.
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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1808)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1824)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-LinearInvolution · definition · 印刷p.128 / PDFp.150

### 2. 原文陈述

> By an involution we mean a linear mapping $\boldsymbol z\mapsto R\boldsymbol z$ where $R^2=I$, i.e. $R$ is its own inverse.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1837)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-ReversedFieldPrinted · definition · 印刷p.128 / PDFp.150

### 2. 原文陈述

> Given the involution $R$ we define the time reversal of the vector field $f$ with respect to $R$ by

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1841)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-MomentumReversal · definition · 印刷p.128 / PDFp.150

### 2. 原文陈述

> Let $H(q,p)=p^TM^{-1}p/2+U(q)$ be the Hamiltonian for a system of $N_c$ configuration variables. Define the $2N_c\times2N_c$ matrix $R$ by

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1845)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1850)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-ReversedTrajectoryPrinted · unnumbered_claim · 印刷p.129 / PDFp.151

### 2. 原文陈述

> For the system $\mathrm dz/\mathrm dt=f(\boldsymbol z)$, a coordinate transformation $\boldsymbol z\mapsto\widetilde{\boldsymbol z}=R\boldsymbol z$ results in

$$
\frac{\mathrm d\widetilde{\boldsymbol z}}{\mathrm dt}=R\frac{\mathrm d\boldsymbol z}{\mathrm dt}=Rf(R^{-1}\widetilde{\boldsymbol z})=Rf(R\widetilde{\boldsymbol z}),
$$


> since $R^{-1}=R$. A change of time $t\mapsto\tau=-t$ results in

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1864)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-ReversedTrajectory · unnumbered_claim · 印刷p.129 / PDFp.151

### 2. 原文陈述

> In other words, for a reversible vector field, the coordinate transformation $\boldsymbol z\mapsto R\boldsymbol z$ is equivalent to the change of time $t\mapsto-t$.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1900)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-FlowReversal · unnumbered_claim · 印刷p.129 / PDFp.151

### 2. 原文陈述

> From this we see that if we start from a point $z_0$ and integrate forward in time (i.e apply $\mathcal F_t$) then apply the involution $R$, we get the exact same result as if we start from $\widetilde z(0)=Rz_0$ and integrate backward in time (i.e apply $\mathcal F_{-t}$). In sum, since $z_0$ is an arbitrary point,

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1924)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-FlowReversalIdentity · (3.14) · 印刷p.129 / PDFp.151

### 2. 原文陈述

> For the flow map, $\mathcal F_{-t}=\mathcal F_t^{-1}$ so we can recast the identity as

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1948)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1970)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-SymmetricMethod · definition · 印刷p.130 / PDFp.152

### 2. 原文陈述

> Recall from the previous chapter that a numerical method $\mathcal G_h$ was said to be symmetric if it satisfied

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1973)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-AffineInvariant · Definition 3.1 · 印刷p.130 / PDFp.152

### 2. 原文陈述

> Definition 3.1 (Affine Invariance) Let

$$
\frac{\mathrm d\boldsymbol z}{\mathrm dt}=f(\boldsymbol z)\tag{3.16}
$$


> be a given ordinary differential equation. The transformation $\widetilde{\boldsymbol z}=A\boldsymbol z$, where $A$ is a non-singular square matrix, results in the modified differential equation

$$
\frac{\mathrm d\boldsymbol z}{\mathrm dt}=Af(A^{-1}\widetilde{\boldsymbol z}).\tag{3.17}
$$


> Let $z_0,z_1,\ldots$ be a sequence of points obtained by application of the numerical method $\mathcal G_h$ to (3.16). If the same method, when applied to (3.17) produces the set of points $Az_0,Az_1,\ldots$, then we say that the numerical method is invariant with respect to the transformation $\widetilde{\boldsymbol z}=Az$. An affine invariant method is one which is invariant under any such transformation.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1978)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.2-SymmetricAffineReversible · unnumbered_claim · 印刷p.130 / PDFp.152

### 2. 原文陈述

> If a differential equation is time-reversible with respect to the involution $R$, and we apply a method which is affine invariant and symmetric, then the method will be time-reversible (3.15).

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L1992)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2018)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2039)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2063)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2131)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2139)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2144)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.3-HamiltonianSpectrum · unnumbered_claim · 印刷p.131 / PDFp.153

### 2. 原文陈述

> For example, consider a linear Hamiltonian system $\mathrm dz/\mathrm dt=JAz$, with $A$ a symmetric matrix. If $\lambda$ is an eigenvalue of $JA$ then $JAu=\lambda u$ for some eigenvector $u\ne0$. Because the matrix $JA$ is real, we know that $\overline\lambda$ will also be an eigenvalue. At the same time, we know that since $\lambda$ is an eigenvalue of $JA$ it is also an eigenvalue of its transpose $(JA)^T=A^TJ^T=-AJ$, thus

$$
-AJu=\lambda u
$$


> multiplying by $J$ and setting $v=Ju$ we have

$$
-JAv=\lambda v
$$


> implying that $-\lambda$ (and hence also $-\overline\lambda$) is an eigenvalue of $JA$. Real eigenvalues of $JA$ are paired with their negatives. If the imaginary part is nonzero, the eigenvalues occur in quadruplets $\{\pm\lambda,\pm\overline\lambda\}$.

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
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2157)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.3-SymplecticSpectrum · unnumbered_claim · 印刷p.131 / PDFp.153

### 2. 原文陈述

> The flow map is

$$
\mathcal F_t(z)=\mathrm e^{tJA}z
$$


> and the exponential matrix will inherit a related structure within the spectrum: $\lambda$ an eigenvalue of $\exp(tJA)$ implies that $\overline\lambda$, $1/\lambda$ and $1/\overline\lambda$ are all eigenvalues of $\exp(tJA)$. This eigenvalue structure is generic for linear symplectic maps in general.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symplecticSpectrum :
  ∀ (n : ℕ) (A : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℝ),
    A.transpose*textbookJ n*A=textbookJ n → ∀ ζ, complexEigenvalue A ζ →
      ζ ≠ 0 ∧ complexEigenvalue A ζ⁻¹ ∧ complexEigenvalue A (star ζ) := by
  sorry

theorem symplecticSpectrum_linearHamiltonian (n : ℕ)
    (K : Matrix (Fin n ⊕ Fin n) (Fin n ⊕ Fin n) ℝ) (_hK : K.IsSymm) :
    let A := textbookJ n*K
    let Φ := fun t : ℝ ↦ NormedSpace.exp (t • A)
    (∀ z, Φ 0 *ᵥ z=z) ∧
    (∀ t z, HasDerivAt (fun s ↦ Φ s *ᵥ z) (A *ᵥ (Φ t *ᵥ z)) t) ∧
    (∀ ζ, complexEigenvalue A ζ → complexEigenvalue A (-ζ) ∧
      complexEigenvalue A (star ζ) ∧ complexEigenvalue A (-star ζ)) ∧
    (∀ t, (Φ t)ᵀ*textbookJ n*Φ t=textbookJ n) ∧
    (∀ t ζ, complexEigenvalue (Φ t) ζ →
      ζ ≠ 0 ∧ complexEigenvalue (Φ t) ζ⁻¹ ∧ complexEigenvalue (Φ t) (star ζ)) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.symplecticSpectrum`；`MD.Ch03.symplecticSpectrum_linearHamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留一般辛矩阵谱结论；补对称K的实际线性Hamiltonian流exp(tJK)、ODE、辛矩阵及对应倒数/共轭谱实例。 | [EXTRA] |

[EXTRA] [EXTRA] 保留一般辛矩阵谱结论；补对称K的实际线性Hamiltonian流exp(tJK)、ODE、辛矩阵及对应倒数/共轭谱实例。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；一般声明量化所有实2n阶辛矩阵和其复特征值，以非零复特征向量定义特征值，结论ζ≠0、倒数及共轭谱正确；再对共轭特征值使用同一定理即得倒数共轭，不是漏掉第四个谱点。零维无特征值，量词无问题。linearHamiltonian补充对所有实对称K，令A=JK，Φ(t)=exp(tA)，给出初值恒等、每个t,z的完整ODE、生成元正负共轭谱、指数矩阵辛性及其倒数共轭谱；实指数、乘法次序、t全实均正确。旧context声称指数流未表达，已与当前全部声明不符；[EXTRA]所称补充实际已经存在。

### 7. 状态与证明位置

incomplete；`MD.Ch03.symplecticSpectrum`：未证（缺大型理论）；`MD.Ch03.symplecticSpectrum_linearHamiltonian`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2165)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.3-ReversibleSpectrum · unnumbered_claim · 印刷p.131 / PDFp.153

### 2. 原文陈述

> Suppose now we have a linear time-reversible map $\phi(z)=Tz$, then

$$
T^{-1}=RTR.
$$


> Given an eigenvalue, eigenvector pair $(\lambda,u)$ of $T$, let $u=Rv$, so that $Ru=R^2v=v$, then

$$
T^{-1}v=RTRv=RTu=\lambda Ru=\lambda v.
$$


> Thus $\lambda$ is an eigenvalue of $T^{-1}$ which, in turn, implies that $1/\lambda$ is an eigenvalue of $T$. The matrix being real implies that the conjugates of $\lambda$ and $1/\lambda$ are also eigenvalues, thus we have the same eigenvalue quadruplets as for a linear symplectic map.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem reversibleSpectrum :
  ∀ (n : ℕ) (A R : Matrix (Fin n) (Fin n) ℝ), IsUnit A.det → R*R=1 →
    A⁻¹=R*A*R → ∀ ζ, complexEigenvalue A ζ →
      ζ ≠ 0 ∧ complexEigenvalue A ζ⁻¹ ∧ complexEigenvalue A (star ζ) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.reversibleSpectrum` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | T可逆、R²=I明确；真实complexEigenvalue，非零性作为结论。 | [EXTRA] |

[EXTRA] T可逆、R²=I明确；真实complexEigenvalue，非零性作为结论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；complexEigenvalue 展开为实矩阵复化后的非零特征向量方程。IsUnit A.det 明确真实矩阵可逆；R*R=1 明确反转 involution；A⁻¹=R*A*R 是原式。两项 [EXTRA]是原文使用逆矩阵和 R²v=v 所隐含的必要资格，合理。ζ≠0 为结论而非假设；倒数和共轭结论准确，逆共轭由重复应用全称定理得到。维数 n 无须偶数。Ch03.lean 含 sorry，签名判断不依赖完成证明。

### 7. 状态与证明位置

incomplete；`MD.Ch03.reversibleSpectrum`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2186)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.3-ConjugateIterates · unnumbered_claim · 印刷p.131–132 / PDFp.153–154

### 2. 原文陈述

> Recall that a pair of maps $\Phi$ and $\Psi$ are said to be conjugate if there is a homomorphism $\chi$ such that

$$
\Phi=\chi^{-1}\Psi\chi.
$$


> In such a case the iterates of the two maps will also be conjugate

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem conjugateIterates {α : Type*} (χ : α ≃ α) (A B : α → α)
    (_hA : A = χ.symm ∘ B ∘ χ) (n : ℕ) :
    A^[n] = χ.symm ∘ (B^[n]) ∘ χ := by
  sorry

theorem conjugateIterates_homeomorph (χ : E ≃ₜ E) (A B : E → E)
    (hA : A = textbookConjugateMap χ B) (n : ℕ) :
    A^[n] = textbookConjugateMap χ (B^[n]) := by
  apply MolecularDynamics.textbook_conjugate_iterates <;> assumption



/-- 修正版，对应原文 MD-3.6.3-ConjugateIterates。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem conjugateIterates_corrected {α : Type*} (χ : α ≃ α) (A B : α → α)
    (_hA : A = χ.symm ∘ B ∘ χ) (n : ℕ) :
    A^[n] = χ.symm ∘ (B^[n]) ∘ χ := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.conjugateIterates`；`MD.Ch03.conjugateIterates_homeomorph`；`MD.Ch03.conjugateIterates_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | χ明确为equivalence，以使原文χ⁻¹有定义；原文homomorphism的用词待审。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 纯迭代恒等式推广到任意类型及真实Equiv，不附拓扑/范数；原Homeomorph已证版本保留辅助，用于拓扑轨道结论。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] χ明确为equivalence，以使原文χ⁻¹有定义；原文homomorphism的用词待审。；[EXTRA] 纯迭代恒等式推广到任意类型及真实Equiv，不附拓扑/范数；原Homeomorph已证版本保留辅助，用于拓扑轨道结论。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；主声明已为任意类型α、任意可逆Equiv χ及A,B，假设A=χ⁻¹∘B∘χ，对所有自然数n给出完整共轭迭代恒等式，包含n=0；没有拓扑或范数前提。homeomorph辅助版同样正确，额外连续性仅属于辅助版本。原页确实写homomorphism并随后使用χ⁻¹；一般同态不保证可逆，原书用词须人工处理，Equiv是合理显式修复。context仍把主签名说成实赋范空间和Homeomorph，已经过时。

### 7. 状态与证明位置

incomplete；`MD.Ch03.conjugateIterates`：未证（原书疑误不证）；`MD.Ch03.conjugateIterates_homeomorph`：已证；`MD.Ch03.conjugateIterates_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2197)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.1-MechanicalReversalCorrect · unnumbered_claim · 印刷p.128 / PDFp.150

### 2. 原文陈述

> Therefore the molecular dynamics Hamiltonian system is time-reversible.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem mechanicalReversalCorrect :
  ∀ (n : ℕ) (m : Fin n → ℝ) (F : Q n → Q n) z,
    mechanicalField m F (momentumReversal z)=-momentumReversal (mechanicalField m F z) := by
  exact MolecularDynamics.Chapter03Review.mechanicalReversal_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.mechanicalReversalCorrect` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 独立正确机械R反转结论；原印展示式亦正确，原先错误标记撤销。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 原已证独立机械反转结论保留；更正旧注释：原书展示式正确，先前原书错误判断已撤销。 | [EXTRA] |

[EXTRA] 独立正确机械R反转结论；原印展示式亦正确，原先错误标记撤销。；[EXTRA] 原已证独立机械反转结论保留；更正旧注释：原书展示式正确，先前原书错误判断已撤销。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；mechanicalReversalCorrect对任意位置力F给出mechanicalField m F(Rz)=−R(mechanicalField m F z)。位置分量invMass m p关于p线性，力仅依赖位置；R(q,p)=(q,−p)，故两端均为(−invMass m p,F q)。取F=−grad U即原书Hamiltonian机械系统。任意F和实m推广不破坏恒等式，R本身对称，故不存在一般非对称involution的转置问题。[EXTRA]撤销先前误报原书机械符号错误是正确的。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.mechanicalReversalCorrect`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2222)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.3-ConjugateOrderPrinted · unnumbered_claim · 印刷p.132 / PDFp.154

### 2. 原文陈述

> and, if they are numerical methods, they will have similar stability properties and performance (e.g. the same effective order).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem conjugateOrderPrinted :
    ∀ (n r : ℕ) (χ : Q n ≃ₜ Q n) (G Φ : ℝ → Q n → Q n) (B : Set (Q n)),
      0 < r → IsCompact B → MolecularDynamics.Chapter03Review.localOrder G Φ B r →
      MolecularDynamics.Chapter03Review.localOrder
        (fun h z => χ (G h (χ.symm z))) (fun h z => χ (Φ h (χ.symm z))) (χ '' B) r := by
  sorry



/-- 修正版，对应原文 MD-3.6.3-ConjugateOrderPrinted。改动：补运输映射的全局Lipschitz充分资格；只给单向局部误差阶运输，不声称全部effective order、性能或稳定性。 -/
```

独立修正版：

```lean
theorem conjugateOrderPrinted_corrected :
    ∀ (n r : ℕ) (χ : Q n ≃ₜ Q n) (G Φ : ℝ → Q n → Q n) (B : Set (Q n)),
      0 < r → IsCompact B →
      (∃ L ≥ 0, ∀ x y, ‖χ x-χ y‖ ≤ L*‖x-y‖) → MolecularDynamics.Chapter03Review.localOrder G Φ B r →
      MolecularDynamics.Chapter03Review.localOrder
        (fun h z => χ (G h (χ.symm z))) (fun h z => χ (Φ h (χ.symm z))) (χ '' B) r := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.conjugateOrderPrinted`；`MD.Ch03.conjugateOrderPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 将“same effective order”按同一局部误差幂阶和真实共轭参考流解释；χ至少homeomorphism、紧初值域、r>0。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 补运输映射的全局Lipschitz充分资格；只给单向局部误差阶运输，不声称全部effective order、性能或稳定性。 | [EXTRA] |

[EXTRA] 将“same effective order”按同一局部误差幂阶和真实共轭参考流解释；χ至少homeomorphism、紧初值域、r>0。；[ERRATUM?] 补运输映射的全局Lipschitz充分资格；只给单向局部误差阶运输，不声称全部effective order、性能或稳定性。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；展开 Chapter03Review.localOrder：存在 C>0,δ>0，使全部 |h|<δ 和 z∈B 满足 ‖G h z−Φ h z‖≤C|h|^(r+1)。这不是 effective order 的定义，而是相对任意参考映射的局部误差上界；Φ 没有任何实际流资格。Homeomorph 与 IsCompact B、r>0 都不足以保持同一误差幂阶。已有标记指出数学风险，但 Lean 签名仍断言错误的全称命题，不能因 sorry 或 NEEDS\_HUMAN 标记而通过。原文问题是 “similar stability properties and performance (e.g. the same effective order)” 中 effective order 的精确定义、允许的处理器以及正则性未给出；这部分须数学判断，A记 NEEDS\_HUMAN，C的明确假命题记FAIL。还未形式化原句的稳定性/性能条款。

### 7. 状态与证明位置

incomplete；`MD.Ch03.conjugateOrderPrinted`：未证（原书疑误不证）；`MD.Ch03.conjugateOrderPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2231)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.3-ReversibleVolumeFailure · unnumbered_claim · 印刷p.132 / PDFp.154

### 2. 原文陈述

> Of particular importance for molecular dynamics are the following properties: a symplectic map will preserve volume, whereas a time-reversible map need not do so, and a symplectic integrator will approximately conserve energy due to the existence of the perturbed Hamiltonian, whereas a time-reversible integrator may give rise to a drift in energy [166].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem reversibleVolumeFailure :
  ∃ (n : ℕ) (R : Q n →L[ℝ] Q n) (G : Q n ≃ Q n), linearInvolution R ∧
    ContDiff ℝ 1 G ∧ ContDiff ℝ 1 G.symm ∧ (∀ z, R (G (R (G z)))=z) ∧
    ∃ z, |(textbookCoordinateJacobian G z).det| ≠ 1 := by
  sorry



/-- 修正版，对应原文 MD-3.6.3-ReversibleVolumeFailure。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem reversibleVolumeFailure_corrected :
  ∃ (n : ℕ) (R : Q n →L[ℝ] Q n) (G : Q n ≃ Q n), linearInvolution R ∧
    ContDiff ℝ 1 G ∧ ContDiff ℝ 1 G.symm ∧ (∀ z, R (G (R (G z)))=z) ∧
    ∃ z, |(textbookCoordinateJacobian G z).det| ≠ 1 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.reversibleVolumeFailure`；`MD.Ch03.reversibleVolumeFailure_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开Ch03\_deps.txt中的实际定义：MolecularDynamics.Chapter02Review.Q n := Fin n → ℝ（第2816行）；linearInvolution R := R.comp R = ContinuousLinearMap.id ℝ (Q n)（第3616行）；MolecularDynamics.textbookCoordinateJacobian G z := LinearMap.toMatrix' (fderiv ℝ G z).toLinearMap（第2365–2366行），其第(i,j)项为((fderiv ℝ G z) (Pi.single j 1)) i（第2368–2369行）。因此这里是实n维空间的真实导数矩阵，而非替代变量。G : Q n ≃ Q n给出双射及逆，双方ContDiff ℝ 1给出C¹微分同胚；R是连续线性对合，∀z, R(G(R(G z)))=z等价于R∘G∘R=G⁻¹，忠实表达相对于R的可逆性。存在z使绝对雅可比行列式不为1，结合C¹微分同胚的换元性质，确实表达不保持Lebesgue体积。量词∃n∃R∃G再∃z正确表达need not，而非错误地要求所有可逆映射都非保体积。C¹、双射和线性对合是为给出真实光滑反例采用的合理对象限制；本条无[EXTRA]或[ERRATUM?]标注，也无原书错误需静默修正。然而statement\_scope明确包含所引整句，Lean签名只覆盖其中“a time-reversible map need not do so”这一子句，缺少其余三项结论。context\_notation称其他结论已在别处保留，不能代替本条对具体声明或引用的覆盖。故完整范围的语义审计FAIL；若范围显式限定为可逆非保体积存在性，则此签名本身可通过该子句的语义审计。Ch03.lean第1276–1280行的证明为sorry；这是未完成证明，独立于上述签名覆盖不足的判断。

### 7. 状态与证明位置

incomplete；`MD.Ch03.reversibleVolumeFailure`：未证（原书疑误不证）；`MD.Ch03.reversibleVolumeFailure_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2255)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7-HardCoreDomain · definition · 印刷p.132 / PDFp.154

### 2. 原文陈述

> We assume, as usual a Hamiltonian $H=p^TM^{-1}p/2+U(q)$ but we add the inequality constraint $\|q_i-q_j\|\ge\sigma_i+\sigma_j$ where $\sigma_i$, $i=1,\ldots,N$ is a core radius. The condition $\|q_i-q_j\|=\sigma_i+\sigma_j$, some $i,j$ defines the constraint surface.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def hardCoreDomain {N d : ℕ} (σ : Fin N → ℝ) : Set (Fin N → Position d) :=
  {q | ∀ i j, i ≠ j → σ i+σ j ≤ ‖q i-q j‖}

def hardCoreDomainPhysical {N d : ℕ} (σ : Fin N → ℝ) (_hσ : ∀ i, 0 ≤ σ i) :
    Set (Fin N → Position d) := hardCoreDomain σ

def hardCoreContactSurface {N d : ℕ} (σ : Fin N → ℝ) : Set (Fin N → Position d) :=
  {q ∈ hardCoreDomain σ | ∃ i j, i ≠ j ∧ ‖q i-q j‖ = σ i+σ j}

def hardCoreMechanicalHamiltonian {N d : ℕ} (m : Fin N → ℝ) (_hm : ∀ i, 0 < m i)
    (U : (Fin N → Position d) → ℝ) (q p : Fin N → Position d) : ℝ :=
  (∑ i, ‖p i‖^2/(2*m i))+U q
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hardCoreDomain`；`MD.Ch03.hardCoreDomainPhysical`；`MD.Ch03.hardCoreContactSurface`；`MD.Ch03.hardCoreMechanicalHamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] hardCoreDomain保留任意实半径的代数集合辅助；新增非负半径物理包装、接触面（至少一对取等号）及H=K+U的明确对象。域不自动保证动力学存在。 | [EXTRA] |

[EXTRA] [EXTRA] hardCoreDomain保留任意实半径的代数集合辅助；新增非负半径物理包装、接触面（至少一对取等号）及H=K+U的明确对象。域不自动保证动力学存在。

### 6. 审计结论

本轮修复：hardCoreDomain保留任意实半径的代数集合辅助；新增非负半径物理包装、接触面（至少一对取等号）及H=K+U的明确对象。域不自动保证动力学存在。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；hardCoreDomain本身正确表达N个d维欧氏位置的闭非重叠区域：对所有不同粒子i,j，距离≥半径和，接触等号允许。i≠j来自物理语境而非原文显式，context已如实披露。任意实σ的集合定义有意义；物理半径非负未编码，应明确限定其物理解释。按本条现有完整statement\_scope，所引Hamiltonian H=K+U以及“某一粒子对取等号”的接触面均未在唯一Lean声明中表达；不能把域定义称为所引全部内容的完整对应。

### 7. 状态与证明位置

self-contained；`MD.Ch03.hardCoreDomain`：定义；`MD.Ch03.hardCoreDomainPhysical`：定义；`MD.Ch03.hardCoreContactSurface`：定义；`MD.Ch03.hardCoreMechanicalHamiltonian`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2276)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7-ElasticReflection · definition · 印刷p.132 / PDFp.154

### 2. 原文陈述

> When the particles are not touching, they move along Newtonian paths defined by the standard equations of motion. At impact, they exchange momentum and energy according to the rules of elastic collision. Specifically, at the point of contact, the momentum vectors of the two spheres are adjusted according to the rule:

$$
p:=p+\alpha u_\perp
$$


> where $u_\perp$ is normal to the constraint surface and $\alpha$ is a parameter chosen to maintain the conservation of energy.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def elasticReflection {n : ℕ} (m : Fin n → ℝ) (u p : Position n) : Position n := p+elasticCoefficient m u p • u
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.elasticReflection` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]选取质量度量反射α=−2Σuᵢpᵢ/mᵢ ÷ Σuᵢ²/mᵢ，具体α原书在障碍特例p134给出；正质量/非零法向是后条守恒资格。 | [EXTRA] |

[EXTRA] [EXTRA]选取质量度量反射α=−2Σuᵢpᵢ/mᵢ ÷ Σuᵢ²/mᵢ，具体α原书在障碍特例p134给出；正质量/非零法向是后条守恒资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开 Position n 为欧氏空间；elasticCoefficient=-2(Σ\_i u\_i p\_i/m\_i)/(Σ\_i u\_i²/m\_i)，elasticReflection=p+elasticCoefficient •u。这是固定位置时沿法向的质量度量弹性反射；坐标可表示完整配置动量。能量方程展开为 α(2T+αS)=0，定义选取反射分支 −2T/S，而非恒等分支。[EXTRA] 是合理的弹性碰撞分支选择；正质量和非零法向在后条守恒定理中给出。定义本身可对任意 u、m 总定义，不应据此宣称非法参数也代表物理碰撞；其类型未证明 u 是某接触面的法向，该对应是调用语境。原文运动与碰撞叙述是此局部更新定义的背景，未将该定义误作完整动力学定理。无 [ERRATUM?]；定义无 sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch03.elasticReflection`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2292)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7-ElasticEnergy · unnumbered_claim · 印刷p.132 / PDFp.154

### 2. 原文陈述

> where $u_\perp$ is normal to the constraint surface and $\alpha$ is a parameter chosen to maintain the conservation of energy.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem elasticEnergy :
  ∀ (n : ℕ) (m : Fin n → ℝ) (u p : Position n), positiveMass m → u ≠ 0 →
    kinetic m (elasticReflection m u p)=kinetic m p ∧
      (∑ i, u i*elasticReflection m u p i/m i)=-(∑ i, u i*p i/m i) := by
  intro n m u p hm hu
  have hex : ∃ i, u i ≠ 0 := by
    by_contra! h
    apply hu
    ext i
    exact h i
  let S : ℝ := ∑ i, u i^2/m i
  let T : ℝ := ∑ i, u i*p i/m i
  have hS : 0 < S := by
    apply Finset.sum_pos'
    · intro i _; exact div_nonneg (sq_nonneg _) (le_of_lt (hm i))
    · obtain ⟨i, hi⟩ := hex
      exact ⟨i, Finset.mem_univ i, div_pos (sq_pos_of_ne_zero hi) (hm i)⟩
  let a := -2*T/S
  have hid : ∀ i, (p i+a*u i)^2/m i =
      p i^2/m i+2*a*(u i*p i/m i)+a^2*(u i^2/m i) := by
    intro i; ring
  have hnormal : ∀ i, u i*(p i+a*u i)/m i =
      u i*p i/m i+a*(u i^2/m i) := by
    intro i; ring
  constructor
  · change (∑ i, (p i+a*u i)^2/m i)/2 = (∑ i, p i^2/m i)/2
    simp_rw [hid, Finset.sum_add_distrib, ← Finset.mul_sum]
    change ((∑ i, p i^2/m i)+2*a*T+a^2*S)/2 = _
    dsimp [a]
    field_simp
    ring
  · change (∑ i, u i*(p i+a*u i)/m i) = -T
    simp_rw [hnormal, Finset.sum_add_distrib, ← Finset.mul_sum]
    change T+a*S = -T
    dsimp [a]
    field_simp
    ring
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.elasticEnergy` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量、u≠0，α取前条实际质量度量反射值；碰撞时位置不变，K守恒即总能量守恒。 | [EXTRA] |

[EXTRA] 正质量、u≠0，α取前条实际质量度量反射值；碰撞时位置不变，K守恒即总能量守恒。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；展开 positiveMass=∀ i,0<m\_i，kinetic=(Σ\_i p\_i²/m\_i)/2，elasticReflection 与 elasticCoefficient 如前条，Position n 为欧氏坐标。量词 n,m,u,p 后跟正质量与 u≠0；它们使 S=Σ u\_i²/m\_i>0，是一般质量反射公式的合理非退化资格。结论第一项是 K 守恒；碰撞位置固定使 U 不变，因而对应原文总能量守恒。第二项 T\_after=−T\_before 是同一反射公式的有效加强，不是额外假设；可直接由 T+(-2T/S)S=−T 得出。此加强不缩减对象或原结论。无 [ERRATUM?]。Ch03.lean 此项含具体证明而非 sorry；本次仅审签名语义，未编译验证证明。

### 7. 状态与证明位置

self-contained；`MD.Ch03.elasticEnergy`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2296)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7-CollisionComposition · definition · 印刷p.132–133 / PDFp.154–155

### 2. 原文陈述

> Let $\mathcal R_c$ denote the action of the collision operator on the vector of positions and momenta. Then we can write the evolution formally as

$$
\mathcal F_\tau^{\mathrm{h.s.}}(q,p)=\mathcal G_{\Delta\tau_r}\circ\mathcal R_c\circ\mathcal G_{\Delta\tau_{r-1}}\cdots\circ\mathcal R_c\circ\mathcal G_{\Delta\tau_0}
$$


> where $\Delta\tau_1,\Delta\tau_2,\ldots,\Delta\tau_{r-1}$ are the times between collisions, $\Delta\tau_0$ is the time until the first collision, and $\Delta\tau_r$ is the time between the last collision and $\tau$. Here $\mathcal G_t$ is the flow map of the smooth system (Hamiltonian $H$).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def collisionComposition {E : Type*} (G : ℝ → E → E) (Rc : E → E) (times : List ℝ) : E → E :=
  match times with
  | [] => id
  | [t] => G t
  | t::u::ts => collisionComposition G Rc (u::ts) ∘ Rc ∘ G t
termination_by times.length

theorem collisionComposition_two {E : Type*} (G : ℝ → E → E) (Rc : E → E)
    (t₀ t₁ : ℝ) : collisionComposition G Rc [t₀,t₁] = G t₁ ∘ Rc ∘ G t₀ := by
  simp [collisionComposition]
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 自然时间顺序的形式组合公式；不在本条声称任意G、Rc就是实际Hamilton碰撞流。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.collisionComposition`；`MD.Ch03.collisionComposition_two` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 列表现在按自然时间顺序[Δτ₀,…,Δτᵣ]存储，递归先执行首段、再碰撞、再余段；二段桥接展开递归核对为G t₁∘Rc∘G t₀。此为形式组合器，非负时长、总时长及G/Rc来自实际Hamilton碰撞的资格不由任意函数定义推出。 | [EXTRA] |
| 尚未覆盖的结论 | 实际事件存在性、非负时长和总时长的动力学资格由具体碰撞模型另行承担 | 覆盖缺口，未声称已证明 |

[EXTRA] [EXTRA] 列表现在按自然时间顺序[Δτ₀,…,Δτᵣ]存储，递归先执行首段、再碰撞、再余段；二段桥接展开递归核对为G t₁∘Rc∘G t₀。此为形式组合器，非负时长、总时长及G/Rc来自实际Hamilton碰撞的资格不由任意函数定义推出。

### 6. 审计结论

本轮修复：列表现在按自然时间顺序[Δτ₀,…,Δτᵣ]存储，递归先执行首段、再碰撞、再余段；二段桥接展开递归核对为G t₁∘Rc∘G t₀。此为形式组合器，非负时长、总时长及G/Rc来自实际Hamilton碰撞的资格不由任意函数定义推出。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；递归定义对任意E、G、Rc及有限实列表存在意义，空表为id、单元素为单个流。对[t0,t1]展开为G t0∘Rc∘G t1；因此它只有在列表按[Δτr,…,Δτ0]逆时间存储时才与原公式相符。当前JSON和签名均没有给出这一关键映射；按原文从首段到末段的自然列表[Δτ0,…,Δτr]理解，得到反向时间次序。[EXTRA]为空，context仅说右到左不能确定列表含义。也未编码事件时长非负、总和τ、G为H流或Rc为实际碰撞；可作形式组合器，不是实际流存在定理。

### 7. 状态与证明位置

self-contained；`MD.Ch03.collisionComposition`：定义；`MD.Ch03.collisionComposition_two`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2336)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7-CollisionRegularity · unnumbered_claim · 印刷p.133 / PDFp.155

### 2. 原文陈述

> The trajectory is thus piecewise smooth with continuous configurational path and momenta exhibiting finite jump discontinuities.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem collisionRegularity :
  ∀ (n : ℕ) (m : Fin n → ℝ) (F : Q n → Q n) (g : Q n → ℝ)
    (times : ℕ → ℝ) (segments : ℕ → ℝ → Z n) ν,
    positiveMass m → ContDiff ℝ ∞ F → ContDiff ℝ 1 g →
    (∀ j < ν, grad g (segments j (times (j+1))).1 ≠ 0 ∧
      (∑ i, grad g (segments j (times (j+1))).1 i *
        (segments j (times (j+1))).2 i/m i) < 0) →
    (∀ j ≤ ν, ∀ t ∈ Icc (times j) (times (j+1)), 0 ≤ g (segments j t).1) →
    concatenatedCollisionSegments m F g times segments ν →
    (∀ j < ν, (segments j (times (j+1))).2 ≠ (segments (j+1) (times (j+1))).2) ∧
    ContinuousOn (fun t => (gluedCollision times segments ν t).1) (Icc (times 0) (times (ν+1))) ∧
    (∀ j ≤ ν, ∀ t ∈ Ioo (times j) (times (j+1)),
      ContDiffAt ℝ ∞ (gluedCollision times segments ν) t) ∧
    (∀ j < ν, Tendsto (fun t => (gluedCollision times segments ν t).2)
      (𝓝[<] (times (j+1))) (𝓝 ((segments j (times (j+1))).2)) ∧
      Tendsto (fun t => (gluedCollision times segments ν t).2)
      (𝓝[>] (times (j+1))) (𝓝 ((segments (j+1) (times (j+1))).2))) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.collisionRegularity` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 有限严格递增隔离时刻、相邻实际光滑ODE段、碰撞接触处位置匹配和真实法向动量跳跃；不把拼接后连续或光滑结论作假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补光滑接触函数、非零法向、严格入射及各段合法非重叠资格；结论补完整(q,p)内段光滑及每次真实碰撞的非零动量跳跃，保留双侧有限极限。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 仅将各内段结论ContDiffAt ℝ ⊤改为scoped ∞，与C∞力前提一致；全部有限事件、横截、拼接及左右极限条件不变。 | [EXTRA] |

[EXTRA] 有限严格递增隔离时刻、相邻实际光滑ODE段、碰撞接触处位置匹配和真实法向动量跳跃；不把拼接后连续或光滑结论作假设。；[EXTRA] 补光滑接触函数、非零法向、严格入射及各段合法非重叠资格；结论补完整(q,p)内段光滑及每次真实碰撞的非零动量跳跃，保留双侧有限极限。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[EXTRA] 仅将各内段结论ContDiffAt ℝ ⊤改为scoped ∞，与C∞力前提一致；全部有限事件、横截、拼接及左右极限条件不变。

### 6. 审计结论

本轮修复：仅将各内段结论ContDiffAt ℝ ⊤改为scoped ∞，与C∞力前提一致；全部有限事件、横截、拼接及左右极限条件不变。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；量词覆盖所有n、正质量m、C∞力F、C¹接触函数g、有限ν碰撞及ν+1个ODE段。拼接条件给严格递增事件、各闭段ODE、接触位置相等和质量加权法向反射；非零法向/严格入射保证非零动量跳跃；合法域g≥0是物理资格。gluedCollision选择已开始的最大段，足以表达右连续拼接、位置连续和左右动量极限。然而内段结论仍写ContDiffAt ℝ ⊤，按本任务指定的现代光滑阶语义它要求实解析，而前提F仅∞光滑，不能推出解析。[EXTRA]声称前提及输出均恢复∞，与实际输出不符。有限事件、横截等都是明确加强，未伪装成从原文无条件推出。

### 7. 状态与证明位置

incomplete；`MD.Ch03.collisionRegularity`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2353)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-HardCorePotential · definition · 印刷p.133 / PDFp.155

### 2. 原文陈述

> Splitting methods are suggested by considering a formal hard-sphere Hamiltonian

$$
H_{\mathrm{h.s.}}=p^TM^{-1}p/2+U(q)+U_{\mathrm{h.s.}},
$$


> where $U_{\mathrm{h.s.}}$ is assumed to be infinite for overlapping configurations (some $\|q_i-q_j\|\le\sigma_i+\sigma_j$) and zero otherwise.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def hardCorePotential {N d : ℕ} (σ : Fin N → ℝ) (q : Fin N → Position d) : ENNReal :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ ≤ σ i+σ j then ⊤ else 0

def hardSphereHamiltonianPrinted {N d : ℕ} (m σ : Fin N → ℝ)
    (_hm : ∀ i, 0 < m i) (U : (Fin N → Position d) → ℝ)
    (q p : Fin N → Position d) : WithTop ℝ :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ ≤ σ i+σ j then ⊤
  else ((∑ i, ‖p i‖^2/(2*m i))+U q : ℝ)

def hardCorePotential_contactAllowed {N d : ℕ} (σ : Fin N → ℝ) (q : Fin N → Position d) : ENNReal :=
  @ite ENNReal (q ∈ hardCoreDomain σ) (Classical.propDecidable _) 0 ⊤



/-- 修正版，对应原文 MD-3.7.1-HardCorePotential。改动：允许接触等号，只有严格重叠才取∞；原印≤判∞独立保留。 -/
```

独立修正版：

```lean
def hardCorePotential_corrected {N d : ℕ} (σ : Fin N → ℝ)
    (_hσ : ∀ i, 0 ≤ σ i) (q : Fin N → Position d) : ENNReal :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ < σ i+σ j then ⊤ else 0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.hardCorePotential`；`MD.Ch03.hardSphereHamiltonianPrinted`；`MD.Ch03.hardCorePotential_contactAllowed`；`MD.Ch03.hardCorePotential_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 原印≤接触也取∞独立忠实定义，并补K+U+U\_hs完整Hamiltonian；原接触允许的物理版本改名保留辅助。两种边界约定明确区分，不擅自勘误原书。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 允许接触等号，只有严格重叠才取∞；原印≤判∞独立保留。 | [EXTRA] |

[EXTRA] [EXTRA] 原印≤接触也取∞独立忠实定义，并补K+U+U\_hs完整Hamiltonian；原接触允许的物理版本改名保留辅助。两种边界约定明确区分，不擅自勘误原书。；[ERRATUM?] 允许接触等号，只有严格重叠才取∞；原印≤判∞独立保留。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；原印≤已目视确认。hardCorePotential以ENNReal表达不同粒子距离≤半径和则∞、否则0，字面忠实；hardSphereHamiltonianPrinted在同一判据下返回∞，否则正质量动能和任意实U，WithTop ℝ容许负有限势，完整H表达正确。contactAllowed辅助为闭允许域内0、外∞，对应严格重叠才惩罚的物理边界，明确分名，不能代替Printed。定义本身无签名错误；原书p132允许等号和p133将等号判∞的冲突必须保留人工裁定。

### 7. 状态与证明位置

self-contained；`MD.Ch03.hardCorePotential`：定义；`MD.Ch03.hardSphereHamiltonianPrinted`：定义；`MD.Ch03.hardCorePotential_contactAllowed`：定义；`MD.Ch03.hardCorePotential_corrected`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2376)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-PrimitiveSplitting · definition · 印刷p.133 / PDFp.155

### 2. 原文陈述

> One approach is to consider the splitting $H=H_{\mathrm{free}}+U$, evolving $H_{\mathrm{free}}$ for fixed intervals punctuated by impulses derived from the smooth potential $U$. In [40, 184] this algorithm is termed the “Primitive Splitting Algorithm” and can be described by the three steps:

$$
P:=p-\frac h2\nabla U(q),\qquad(Q,P):=\mathcal G_h^{\mathrm{free}}(q,P),\qquad P:=P-\frac h2\nabla U(Q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def primitiveSplitting {n : ℕ} (U : Q n → ℝ)
    (Gfree : ℝ → SymplecticCoordinates n → SymplecticCoordinates n) (h : ℝ) :=
  textbookMomentumKick (textbookPotentialForce U) (h/2) ∘ Gfree h ∘ textbookMomentumKick (textbookPotentialForce U) (h/2)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.primitiveSplitting` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开Ch03\_deps.txt:33的SymplecticCoordinates=(Fin n⊕Fin n)→ℝ、568–571的位置投影、583–585的textbookPotentialForce(U)(q)_i=−fderiv(U,q)(e\_i)、619–624的textbookMomentumKick：位置保持、动量加hF(q)。函数复合从右向左，恰为初始半kick、给定Gfree h、末尾半kick。U的光滑性和Gfree是真实自由硬球流属于原文语境，本条定义只描述给定流的数学组合，并不声称任意Gfree具有物理意义或证明流存在；现有context明确此范围。无额外定理结论或sorry。

### 7. 状态与证明位置

self-contained；`MD.Ch03.primitiveSplitting`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2396)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-PrimitiveOrder · unnumbered_claim · 印刷p.133–134 / PDFp.155–156

### 2. 原文陈述

> Even with this symmetric form (“kick”, “drift”, “kick”) where “drift” now involves the solution of the system $H_{\mathrm{free}}$, it was shown in [184] that energy accumulates rapidly. Assuming a finite number of collisions on a fixed interval, the error behaves as $O(h)$. In long simulations the energy error grows without bound.
> In general, because an error of size $O(h)$ occurs in each collision and there are a finite number of collisions in a fixed time interval, the total error is also $O(h)$, i.e. first order.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem primitiveOrder :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U g : Q n → ℝ) (Gfree : ℝ → Z n → Z n)
    (q p : ℝ → Q n) τ events,
    positiveMass m → ContDiff ℝ ⊤ U → ContDiff ℝ ⊤ g → 0 < τ →
    finiteCollisionTrajectory m (fun x => -grad U x) g q p 0 τ events → freeCollisionFlow m g Gfree →
    collisionalGlobalOrder (fun h =>
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1)) ∘ Gfree h ∘
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1))) q p τ 1 := by
  sorry



/-- 修正版，对应原文 MD-3.7.1-PrimitiveOrder。改动：限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。 -/
```

独立修正版：

```lean
def finiteCollisionTrajectory_corrected {n : ℕ} (m : Fin n → ℝ)
    (F : Q n → Q n) (g : Q n → ℝ) (q p : ℝ → Q n) (τ : ℝ) (events : Finset ℝ) : Prop :=
  finiteCollisionTrajectory m F g q p 0 τ events ∧
  admissibleCollisionState m g (q 0,p 0) ∧ 0 < g (q τ) ∧
  Tendsto p (𝓝[>] 0) (𝓝 (p 0)) ∧ Tendsto p (𝓝[<] τ) (𝓝 (p τ)) ∧
  (∀ t ∈ Ico 0 τ, Tendsto p (𝓝[>] t) (𝓝 (p t))) ∧
  (∀ t ∈ Ioo 0 τ, g (q t)=0 ↔ t ∈ events) ∧
  (∀ t ∈ events, grad g (q t) ≠ 0)

theorem primitiveOrder_corrected :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U g : Q n → ℝ) (Gfree : ℝ → Z n → Z n)
    (q p : ℝ → Q n) τ events,
    positiveMass m → ContDiff ℝ ∞ U → ContDiff ℝ ∞ g → 0 < τ →
    finiteCollisionTrajectory_corrected m (fun x => -grad U x) g q p τ events → freeCollisionFlow m g Gfree →
    collisionalGlobalOrder (fun h =>
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1)) ∘ Gfree h ∘
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1))) q p τ 1 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.primitiveOrder`；`MD.Ch03.finiteCollisionTrajectory_corrected`；`MD.Ch03.primitiveOrder_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量、C∞势/接触函数、有限横截隔离单接触、真实freeCollisionFlow；采用O(h)单调时间对齐以比较跳跃动量，不假设结论误差界。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。 | [EXTRA] |

[EXTRA] 正质量、C∞势/接触函数、有限横截隔离单接触、真实freeCollisionFlow；采用O(h)单调时间对齐以比较跳跃动量，不假设结论误差界。；[ERRATUM?] 限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开Q、Z(2816–2817)、grad(2932)、positiveMass(2948)、invMass(2840)、finiteCollisionTrajectory(4431–4441)、collisionalGlobalOrder(4460–4464)、admissibleCollisionState及freeCollisionFlow(4465–4472)。目标是经θ:ℝ≃oℝ进行O(h)时间移动后的全相空间网格误差，而原文以能量缺陷为论据，且明确包含长期能量误差无界；该结论子句完全未表示。更严重，finiteCollisionTrajectory只要求q在闭区间连续，p的ODE仅在内部非事件点成立，事件时只约束左右极限，不约束p(t)的取值；端点动量也无连续性要求。故它不能保证真实初始状态和右侧轨道一致，签名甚至在无碰撞时为假。有限横截性确有内积<0，单个光滑g则是比多硬球约束窄的模型；C∞可作为充分正则性，但非书中明确必需条件。freeCollisionFlow对每个τ只允许内部事件且要求全局有限碰撞，强于所称固定区间假设。sorry独立存在，不改变这些语义缺陷。

### 7. 状态与证明位置

incomplete；`MD.Ch03.primitiveOrder`：未证（原书疑误不证）；`MD.Ch03.finiteCollisionTrajectory_corrected`：定义；`MD.Ch03.primitiveOrder_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2404)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-ObstacleReflection · definition · 印刷p.134 / PDFp.156

### 2. 原文陈述

> The coefficient $\alpha$ is chosen so that the kinetic energy is conserved through collision, thus

$$
\alpha=-2\frac{u_\perp\cdot\overline P}{u_\perp\cdot u_\perp}.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def obstacleReflection {d : ℕ} (u p : Position d) : Position d := p- (2*inner ℝ u p / inner ℝ u u) • u
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.obstacleReflection` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；obstacleReflection对任意有限欧氏维数、法向u及碰前动量p返回p−(2⟨u,p⟩/⟨u,u⟩)u，即原书P̂=P̄+αu⊥，第二参数明确是P̄，返回值明确不是α。[EXTRA]为空。context给定原点固定障碍、运动质量1、两半径0.5及‖qc‖=1，保证物理调用u=qc≠0。函数在u=0按实数全除法有定义但不声称此时物理接触有效；能量守恒定理由明确的其他条目承担。本条是反射更新定义，未冒称本函数定义已经证明能量守恒。

### 7. 状态与证明位置

self-contained；`MD.Ch03.obstacleReflection`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2441)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-PrimitiveDefect · unnumbered_claim · 印刷p.134 / PDFp.156

### 2. 原文陈述

> We next calculate the change in energy in a single step by inserting $Q$ and $P$ into the Hamiltonian and expanding around the point of collision $q_c$, obtaining

$$
\Delta H\stackrel{\mathrm{def}}=H(Q,P)-H(q,p)=-(h-2\tau_c)\frac{q_c^T\overline P}{q_c^Tq_c}q_c^T\nabla U(q_c)+O(h^2).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem primitiveDefect :
  ∀ (d : ℕ) (U : Position d → ℝ) (qc pbar : Position d)
    (initial final : ℝ → Position d × Position d) (tc : ℝ → ℝ) (Δ : ℝ), 0 < Δ → ContDiff ℝ 3 U → qc ≠ 0 → ‖qc‖=1 →
    Tendsto (fun h ↦ (initial h).1) (𝓝[>] 0) (𝓝 qc) →
    (∀ h ∈ Ioo 0 Δ, 0 < tc h ∧ tc h < h ∧
      let F := -gradient U (initial h).1
      let pminus := pbar+(h/2) • F
      (initial h).2=pbar ∧ (initial h).1=qc-tc h • pminus ∧
      (∀ t ∈ Ioo 0 (tc h), 1 < ‖(initial h).1+t • pminus‖) ∧
      final h=(qc+(h-tc h) • obstacleReflection qc pminus,
        obstacleReflection qc pminus+(h/2) • (-gradient U (qc+(h-tc h) • obstacleReflection qc pminus)))) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ,
      |((‖(final h).2‖^2/2+U (final h).1)-(‖(initial h).2‖^2/2+U (initial h).1))+
        (h-2*tc h)*(inner ℝ qc (pbar+(h/2) • (-gradient U (initial h).1))/inner ℝ qc qc)*inner ℝ qc (gradient U qc)| ≤ C*h^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.primitiveDefect` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | C³势、固定非零qc、真实初末碰撞步族和0<tc(h)<h；O(h²)以小正h的一致界表示。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 仅小正h、单位接触点及初态趋近接触点的首次单碰撞物理分支；系数使用原书碰前P̄（含半kick），不再用初始p冒充；保留O(h²)余项。 | [EXTRA] |

[EXTRA] C³势、固定非零qc、真实初末碰撞步族和0<tc(h)<h；O(h²)以小正h的一致界表示。；[EXTRA] 仅小正h、单位接触点及初态趋近接触点的首次单碰撞物理分支；系数使用原书碰前P̄（含半kick），不再用初始p冒充；保留O(h²)余项。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；对任意维数、C³势、固定单位qc和固定初动量pbar，量化真实初末状态族与tc(h)。小正h的假设包含0<tc<h、第一次半kick后的pminus、初态动量=pbar、初位置=qc−tc pminus、此前在球外及完整反射和末次半kick。结论是存在正C、δ，对所有0<h<δ能量差加原书主项的绝对值≤Ch²，符号与原书一致；δ可缩小到Δ以内，无需把δ≤Δ写成前提。系数实际已使用pbar+(h/2)(−gradient U(initial h).1)，正是P̄。初态趋向qc和C³提供局部有界梯度及Taylor余项，故旧的“将初动量冒充P̄”疑问已不适用于当前声明。[EXTRA]中的固定单位接触、固定初动量和局部单碰撞是透明的局部版本。

### 7. 状态与证明位置

incomplete；`MD.Ch03.primitiveDefect`：未证（缺大型理论）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2447)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-CollisionDefectZero · unnumbered_claim · 印刷p.134 / PDFp.156

### 2. 原文陈述

> • the collision occurs at the middle of the timestep, $\tau_c=h/2$,
> • the directional derivative of $U$ along the collision vector $(u_\perp=q_c)$ vanishes, or
> • the momentum vector is orthogonal to the collision vector at the point of contact.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem collisionDefectZero :
  ∀ h tc a b c : ℝ, (h=2*tc ∨ a=0 ∨ c=0) → (h-2*tc)*(a/b)*c=0 := by
  exact MolecularDynamics.Chapter03Review.collisionDefectZero_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.collisionDefectZero` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；Ch03\_deps.txt:4496–4497及Ch03.lean:1399–1402的结论为(h−2tc)(a/b)c=0。取a=⟨qc,P̄⟩，b=⟨qc,qc⟩，c=⟨qc,∇U(qc)⟩：h=2tc对应中点，c=0对应方向导数零，a=0对应动量正交。析取顺序不影响语义；全称实数代数式是三种消项的通用引理，b=0下Lean的除法也有定义，但原书物理实例b=1。原context明确只审线性系数、保留O(h²)，因此没有从消项擅自推出三阶。Ch03.lean引用collisionDefectZero\_proved；这与本次签名语义PASS分开。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.collisionDefectZero`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2464)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-EndImpactThirdOrderPrinted · unnumbered_claim · 印刷p.134 / PDFp.156

### 2. 原文陈述

> In cases (i) and (ii) it is clear that the error accumulating in a single step will be third order in the stepsize, since the Verlet method has local error of order three (since it is a second order method).
> • there is no collision
> • the collision occurs at the end of a timestep

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem endImpactThirdOrderPrinted :
  ∀ (d : ℕ) (U : Position d → ℝ) (qc pbar : Position d)
    (initial final : ℝ → Position d × Position d) (tc : ℝ → ℝ),
    ContDiff ℝ 3 U → qc ≠ 0 →
    (∀ h > 0, tc h = h ∧
      let F := -gradient U (initial h).1
      let pminus := pbar+(h/2) • F
      (initial h).2=pbar ∧ (initial h).1=qc-tc h • pminus ∧
      final h=(qc+(h-tc h) • obstacleReflection qc pminus,
        obstacleReflection qc pminus+(h/2) • (-gradient U (qc+(h-tc h) • obstacleReflection qc pminus)))) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ,
      |((‖(final h).2‖^2/2+U (final h).1)-(‖(initial h).2‖^2/2+U (initial h).1))| ≤ C*h^3 := by
  sorry



/-- 修正版，对应原文 MD-3.7.1-EndImpactThirdOrderPrinted。改动：原末端碰撞三阶能量断言有反例；对接近接触点的初值族只给一阶上界，新增趋近资格排除隐式方程的远端分支，不声称二阶或三阶。 -/
```

独立修正版：

```lean
theorem endImpactThirdOrderPrinted_corrected :
  ∀ (d : ℕ) (U : Position d → ℝ) (qc pbar : Position d)
    (initial final : ℝ → Position d × Position d) (tc : ℝ → ℝ),
    ContDiff ℝ 3 U → qc ≠ 0 → Tendsto (fun h => (initial h).1) (𝓝[>] 0) (𝓝 qc) →
    (∀ h > 0, tc h = h ∧
      let F := -gradient U (initial h).1
      let pminus := pbar+(h/2) • F
      (initial h).2=pbar ∧ (initial h).1=qc-tc h • pminus ∧
      final h=(qc+(h-tc h) • obstacleReflection qc pminus,
        obstacleReflection qc pminus+(h/2) • (-gradient U (qc+(h-tc h) • obstacleReflection qc pminus)))) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ,
      |((‖(final h).2‖^2/2+U (final h).1)-(‖(initial h).2‖^2/2+U (initial h).1))| ≤ C*h := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.endImpactThirdOrderPrinted`；`MD.Ch03.endImpactThirdOrderPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 原末端碰撞三阶能量断言有反例；对接近接触点的初值族只给一阶上界，新增趋近资格排除隐式方程的远端分支，不声称二阶或三阶。 | [EXTRA] |

[EXTRA] [ERRATUM?] 原末端碰撞三阶能量断言有反例；对接近接触点的初值族只给一阶上界，新增趋近资格排除隐式方程的远端分支，不声称二阶或三阶。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开Position和obstacleReflection，核对Ch03.lean:1404–1420：确实保留tc=h、反射及末尾half-kick，并用∃C,δ正量化O(h³)能量差。但原条范围还包括无碰撞分支，签名完全未表示该子句。末端反射分支本身为假，即使补上原文‖qc‖=1、局部物理入射，也不成立；以下单位球反例直接验证[ERRATUM?]，并非仅由套用步内公式到端点推测。C³是合理充分正则性，qc≠0合理；对所有h>0约束步族比局部误差需要更强。原文“error”的状态/能量解读应明确，但在当前选定能量解读下已有确定反例，因此FAIL。含sorry不作为语义FAIL理由。

### 7. 状态与证明位置

incomplete；`MD.Ch03.endImpactThirdOrderPrinted`：未证（原书疑误不证）；`MD.Ch03.endImpactThirdOrderPrinted_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2471)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.2-CollisionQuadraticPath · (3.18) · 印刷p.135 / PDFp.157

### 2. 原文陈述

> The idea is to make use of the quadratic

$$
Q(t)=q+tM^{-1}p-\frac{t^2}{2}M^{-1}\nabla U(q)\tag{3.18}
$$


> which represents the position vector obtained from a Verlet step of size $t$. Note that this defines quadratic paths for all particles in the system.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def collisionQuadraticPath {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (z : Z n) (t : ℝ) : Q n :=
  z.1+t • invMass m z.2+(t^2/2) • invMass m (F z.1)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.collisionQuadraticPath` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Ch03\_deps.txt 的 MolecularDynamics/Chapter02/ReviewDefinitions.lean：Q n=Fin n→ℝ，Z n=Q n×Q n，invMass m v i=(m i)^{-1}v i；verlet 的位置分量为 z.1+h•invMass m z.2+(h²/2)•invMass m(F z.1)，动量分量为 z.2+(h/2)•(F z.1+F qnew)。grad U q i=(fderiv ℝ U q)(Pi.single i 1)。本地 Ch03.lean:1419–1420 的 collisionQuadraticPath 与依赖 MolecularDynamics/Chapter03/ReviewDefinitions.lean:3649–3650 相同。令 z=(q,p)、F=−grad U、M 为坐标质量对角矩阵，即逐坐标得到式(3.18)，且确实是 Verlet 的位置分量；各粒子的坐标块由整个位形向量取出。一般 F 和全体实数 t 是公式的参数化延拓，不另声称任意 F 都来自势或任意零质量具有物理意义。原定义本身没有量词结论或[EXTRA]/[ERRATUM?]。这是定义，无 sorry 证明义务；本判定为签名／定义语义审计。

### 7. 状态与证明位置

self-contained；`MD.Ch03.collisionQuadraticPath`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2507)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.2-CollisionTimeRelation · (3.19) · 印刷p.135 / PDFp.157

### 2. 原文陈述

> It is then possible to calculate the collision times by solving equations

$$
\|Q_i(t)-Q_j(t)\|=\sigma_i+\sigma_j,\qquad i\ne j.\tag{3.19}
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def collisionTimeRelation {d : ℕ} (a b : ℝ → Position d) (radius t : ℝ) : Prop := 0 < t ∧ ‖a t-b t‖=radius
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.collisionTimeRelation` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；定义对任意d维位置路径a,b、实radius和t给出0<t及欧氏距离=radius；context将它们明确绑定为选定不同粒子Qi,Qj和σi+σj，正好是式(3.19)的正时间接触候选。没有最早性、路径二次性或根存在定理，但这些已明说不属于该辅助关系。原文式(3.19)本身不是最早根定义，故不以缺最早性判FAIL。当前本批已含physicalCVARelation，旧context仍说本批仅给定tc后的更新，不再准确。

### 7. 状态与证明位置

self-contained；`MD.Ch03.collisionTimeRelation`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2511)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.2-CollisionQuartic · unnumbered_claim · 印刷p.135 / PDFp.157

### 2. 原文陈述

> If the Verlet method is used, then it turns out that the insertion of (3.18) into (3.19) results in a quartic polynomial that must be solved for each particle pair.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem collisionQuartic :
  ∀ (d : ℕ) (a b c : Position d) (R t : ℝ), 0 ≤ R →
    (‖a+t • b+t^2 • c‖=R ↔
      inner ℝ c c*t^4+2*inner ℝ b c*t^3+(inner ℝ b b+2*inner ℝ a c)*t^2+
        2*inner ℝ a b*t+inner ℝ a a-R^2=0) := by
  exact MolecularDynamics.Chapter03Review.collisionQuartic_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.collisionQuartic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | radius≥0保证平方不引入负半径伪根；四次最高系数可退化，degree≤4。 | [EXTRA] |

[EXTRA] radius≥0保证平方不引入负半径伪根；四次最高系数可退化，degree≤4。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 433a13ca6407）。
网站原返回（对应其审校版本）：PASS；已展开 Position d=EuclideanSpace ℝ (Fin d)（MolecularDynamics/Notation.lean:844），inner ℝ 是其标准欧氏内积；collisionQuadraticPath 的二次项系数是 invMass m(F q)/2，invMass 的各坐标值为 F(q)_k/m\_k。两粒子路径差因此写成 a+t•b+t²•c。Ch03.lean:1427–1432 和依赖 MolecularDynamics/Chapter03/Statements.lean:4496–4501 的命题完全一致，量词顺序为任意 d,a,b,c,R,t 后加 0≤R；结论是接触范数等式与完整四次系数表达式等于零的双向等价。依赖 MolecularDynamics/Chapter03/ReviewProofs.lean:4768 起实际展开 ‖a+tb+t²c‖²，系数依次为 ⟨c,c⟩、2⟨b,c⟩、⟨b,b⟩+2⟨a,c⟩、2⟨a,b⟩、⟨a,a⟩−R²，完全吻合。该命题不声称有根，也不替代各粒子对的枚举。[EXTRA] R≥0 必要且合理：物理半径和非负；若 R<0，平方方程可能有根而原范数等式不成立。[EXTRA]最高项可退化的说明合理：c=0 时是至多二次，不应给原文的泛称 quartic 强行增加 ⟨c,c⟩≠0。无[ERRATUM?]。本地包装引用 collisionQuartic\_proved，已读该证明正文，相关证明体没有 sorry；没有运行编译，也不以证明存在代替语义核对。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch03.collisionQuartic`：已证。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2515)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.2-CollisionalVerletRelation · definition · 印刷p.135 / PDFp.157

### 2. 原文陈述

> Collisional Verlet Algorithm (CVA) [Single Step]
> [computes $h$ (the timestep) and $(Q,P)$ given a starting point $(q,p)$]
> Calculate $\tau_c$ the time of next collision from the Verlet paths (quadratics) of (3.18) using collision conditions (3.19).
> If $\tau_c<h_{\max}$, then

$$
h:=\tau_c,\qquad(Q,P):=R_c\mathcal G_h^{\mathrm{Verlet}}(q,p)
$$


> else

$$
h:=h_{\max},\qquad(Q,P):=\mathcal G_h^{\mathrm{Verlet}}(q,p).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def collisionalVerletRelation {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (Rc : Z n → Z n)
    (tc hmax h : ℝ) (z w : Z n) : Prop :=
  0 < tc ∧ 0 < hmax ∧ h=min tc hmax ∧
    w=if tc<hmax then Rc (verlet m F h z) else verlet m F h z

def particleQuadraticPath {N d : ℕ} (m : Fin N → ℝ)
    (F : (Fin N → Position d) → Fin N → Position d)
    (z : (Fin N → Position d) × (Fin N → Position d)) (t : ℝ) : Fin N → Position d :=
  fun i ↦ z.1 i+(t/m i) • z.2 i+(t^2/(2*m i)) • F z.1 i

def particleVerlet {N d : ℕ} (m : Fin N → ℝ)
    (F : (Fin N → Position d) → Fin N → Position d)
    (h : ℝ) (z : (Fin N → Position d) × (Fin N → Position d)) :=
  let P := z.2+(h/2) • F z.1
  let Q := fun i ↦ z.1 i+(h/m i) • P i
  (Q,P+(h/2) • F Q)

def particleReflection {N d : ℕ} (m : Fin N → ℝ) (i j : Fin N)
    (z : (Fin N → Position d) × (Fin N → Position d)) :=
  let u : Fin N → Position d := fun a ↦ if a=i then z.1 i-z.1 j
    else if a=j then z.1 j-z.1 i else 0
  let α := -2*(∑ a, inner ℝ (u a) (z.2 a)/m a)/(∑ a, ‖u a‖^2/m a)
  (z.1,z.2+α • u)

def physicalCVARelation {N d : ℕ} (m σ : Fin N → ℝ)
    (U : (Fin N → Position d) → ℝ)
    (F : (Fin N → Position d) → Fin N → Position d)
    (event : Option (ℝ × (Fin N × Fin N))) (hmax h : ℝ)
    (z w : (Fin N → Position d) × (Fin N → Position d)) : Prop :=
  (∀ i, 0 < m i ∧ 0 < σ i) ∧ Differentiable ℝ U ∧
  (∀ q ξ, fderiv ℝ U q ξ = -∑ i, inner ℝ (F q i) (ξ i)) ∧
  (∀ i j, i ≠ j → σ i+σ j ≤ ‖z.1 i-z.1 j‖) ∧ 0 < hmax ∧
  match event with
  | none =>
    (∀ t > 0, ∀ i j, i ≠ j → σ i+σ j <
      ‖particleQuadraticPath m F z t i-particleQuadraticPath m F z t j‖) ∧
    h=hmax ∧ w=particleVerlet m F h z
  | some (tc,(i,j)) =>
    0 < tc ∧ i ≠ j ∧
    ‖particleQuadraticPath m F z tc i-particleQuadraticPath m F z tc j‖=σ i+σ j ∧
    (∀ t ∈ Ioo 0 tc, ∀ a b, a ≠ b → σ a+σ b <
      ‖particleQuadraticPath m F z t a-particleQuadraticPath m F z t b‖) ∧
    (∀ a b, a ≠ b → (a,b) ≠ (i,j) → (a,b) ≠ (j,i) →
      σ a+σ b < ‖particleQuadraticPath m F z tc a-particleQuadraticPath m F z tc b‖) ∧
    h=min tc hmax ∧ w=if tc<hmax then particleReflection m i j (particleVerlet m F h z)
      else particleVerlet m F h z



/-- 修正版，对应原文 MD-3.7.2-CollisionalVerletRelation。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def collisionalVerletRelation_corrected {n : ℕ} (m : Fin n → ℝ) (F : Q n → Q n) (Rc : Z n → Z n)
    (tc hmax h : ℝ) (z w : Z n) : Prop :=
  0 < tc ∧ 0 < hmax ∧ h=min tc hmax ∧
    w=if tc<hmax then Rc (verlet m F h z) else verlet m F h z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.collisionalVerletRelation`；`MD.Ch03.particleQuadraticPath`；`MD.Ch03.particleVerlet`；`MD.Ch03.particleReflection`；`MD.Ch03.physicalCVARelation`；`MD.Ch03.collisionalVerletRelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | tc>0,hmax>0明示；tc必须是下一接触时刻，求根实现不是数学定理。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留给定tc/Rc的更新辅助；补实际粒子二次路径、正质量/半径、F=−∇U的对偶资格、不同粒子对的最早真实接触、唯一单碰撞及该接触面的质量加权弹性反射。Option.none明确无正根；严格tc<hmax及等号else照原印保留，不静默修改算法。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] tc>0,hmax>0明示；tc必须是下一接触时刻，求根实现不是数学定理。；[EXTRA] 保留给定tc/Rc的更新辅助；补实际粒子二次路径、正质量/半径、F=−∇U的对偶资格、不同粒子对的最早真实接触、唯一单碰撞及该接触面的质量加权弹性反射。Option.none明确无正根；严格tc<hmax及等号else照原印保留，不静默修改算法。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；辅助collisionalVerletRelation精确保留0<tc、0<hmax、h=min(tc,hmax)和严格tc<hmax才反射的分支；m,F,Rc任意，故仅是参数化更新。physicalCVARelation已补正质量/半径、可微U及F的负微分对偶、初态非重叠、粒子二次路径、全体粒子对先前严格分离、唯一碰撞对（交换同一对除外）和质量加权弹性反射。particleVerlet与二次路径位置一致，particleReflection的法向两粒子分量相反，分母由正质量及接触距离正而非零。none分支要求所有正时间无接触，表示无未来根而非仅步长内无根；some允许tc超过hmax，不会误反射。tc=hmax严格走else忠实于原书；但下一步从接触初态选严格正根可能遗漏即时反射，算法边界疑点保留。额外排除多重碰撞、要求初态合法和保守力均明确披露，未声称阶数或求根实现。

### 7. 状态与证明位置

self-contained；`MD.Ch03.collisionalVerletRelation`：定义；`MD.Ch03.particleQuadraticPath`：定义；`MD.Ch03.particleVerlet`：定义；`MD.Ch03.particleReflection`：定义；`MD.Ch03.physicalCVARelation`：定义；`MD.Ch03.collisionalVerletRelation_corrected`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2527)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.2-CollisionalVerletOrder · unnumbered_claim · 印刷p.135 / PDFp.157

### 2. 原文陈述

> A step can then be taken to the first point of subsequent collision, with positions updated using the quadratic and momenta adjusted according to the Verlet map combined with $R_c$. In this way, all steps taken are Verlet steps so the order of accuracy is two. Effectively, this is a Verlet method with variable timestep chosen to match collision times.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem collisionalVerletOrder :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U g : Q n → ℝ) (q p : ℝ → Q n) τ events
    (tc : Z n → ℝ) (Rc : Z n → Z n) (G : ℝ → Z n → Z n),
    positiveMass m → ContDiff ℝ ⊤ U → ContDiff ℝ ⊤ g → 0 < τ →
    finiteCollisionTrajectory m (fun x => -grad U x) g q p 0 τ events →
    (∀ z, admissibleCollisionState m g z → 0 < tc z ∧
      g (collisionQuadraticPath m (fun x => -grad U x) z (tc z))=0 ∧
      ∀ t ∈ Ioo 0 (tc z), 0 < g (collisionQuadraticPath m (fun x => -grad U x) z t)) →
    (∀ z, Rc z=(z.1,z.2+(-2*(∑ i, grad g z.1 i*z.2 i/m i)/
      (∑ i, grad g z.1 i^2/m i)) • grad g z.1)) →
    (∀ h > 0, ∀ z, collisionalVerletRelation m (fun x => -grad U x) Rc (tc z) h (min (tc z) h) z (G h z)) →
    ∃ C > 0, ∃ δ > 0, ∀ hmax ∈ Ioo 0 δ, ∀ times : ℕ → ℝ,
      times 0=0 → (∀ j, times (j+1)=times j+min (tc (oneStepIterate G hmax (q 0,p 0) j)) hmax) →
      (∀ j, times j < τ → admissibleCollisionState m g (oneStepIterate G hmax (q 0,p 0) j) ∧
        tc (oneStepIterate G hmax (q 0,p 0) j) ≠ hmax) →
      ∃ θ : ℝ ≃o ℝ, θ 0=0 ∧ θ τ=τ ∧ (∀ t ∈ Icc 0 τ, |θ t-t| ≤ C*hmax^2) ∧
        ∀ j, times j ≤ τ →
          ‖oneStepIterate G hmax (q 0,p 0) j-(q (θ (times j)),p (θ (times j)))‖ ≤ C*hmax^2 := by
  sorry



/-- 修正版，对应原文 MD-3.7.2-CollisionalVerletOrder。改动：限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。 -/
```

独立修正版：

```lean
theorem collisionalVerletOrder_corrected :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U g : Q n → ℝ) (q p : ℝ → Q n) τ events
    (tc : Z n → ℝ) (Rc : Z n → Z n) (G : ℝ → Z n → Z n),
    positiveMass m → ContDiff ℝ ∞ U → ContDiff ℝ ∞ g → 0 < τ →
    finiteCollisionTrajectory_corrected m (fun x => -grad U x) g q p τ events →
    (∀ z, admissibleCollisionState m g z → 0 < tc z ∧
      g (collisionQuadraticPath m (fun x => -grad U x) z (tc z))=0 ∧
      ∀ t ∈ Ioo 0 (tc z), 0 < g (collisionQuadraticPath m (fun x => -grad U x) z t)) →
    (∀ z, admissibleCollisionState m g z →
      ∑ i, grad g (collisionQuadraticPath m (fun x => -grad U x) z (tc z)) i *
        invMass m (z.2+(tc z) • (-grad U z.1)) i < 0) →
    (∀ z, Rc z=(z.1,z.2+(-2*(∑ i, grad g z.1 i*z.2 i/m i)/
      (∑ i, grad g z.1 i^2/m i)) • grad g z.1)) →
    (∀ h > 0, ∀ z, collisionalVerletRelation m (fun x => -grad U x) Rc (tc z) h (min (tc z) h) z (G h z)) →
    ∃ C > 0, ∃ δ > 0, ∀ hmax ∈ Ioo 0 δ, ∀ times : ℕ → ℝ,
      times 0=0 → (∀ j, times (j+1)=times j+min (tc (oneStepIterate G hmax (q 0,p 0) j)) hmax) →
      (∀ j, times j < τ → admissibleCollisionState m g (oneStepIterate G hmax (q 0,p 0) j) ∧
        tc (oneStepIterate G hmax (q 0,p 0) j) ≠ hmax) →
      ∃ θ : ℝ ≃o ℝ, θ 0=0 ∧ θ τ=τ ∧ (∀ t ∈ Icc 0 τ, |θ t-t| ≤ C*hmax^2) ∧
        ∀ j, times j ≤ τ →
          ‖oneStepIterate G hmax (q 0,p 0) j-(q (θ (times j)),p (θ (times j)))‖ ≤ C*hmax^2 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.collisionalVerletOrder`；`MD.Ch03.collisionalVerletOrder_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量、C∞势/接触函数、有限横截隔离事件、最小正接触根；自适应累计真实时间及O(hmax²)单调时间对齐；所有内部接触严格早于hmax，排除伪代码未反射的相等边界。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。 | [EXTRA] |

[EXTRA] 正质量、C∞势/接触函数、有限横截隔离事件、最小正接触根；自适应累计真实时间及O(hmax²)单调时间对齐；所有内部接触严格早于hmax，排除伪代码未反射的相等边界。；[ERRATUM?] 限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已读本地 Ch03.lean:1445–1468 及依赖 MolecularDynamics/Chapter03/Statements.lean:4508–4530，并展开所有专用定义。Q n=Fin n→ℝ，Z n=Q n×Q n；positiveMass m 为 ∀i,0<m i；grad U q i=(fderiv ℝ U q)(Pi.single i 1)；invMass m v i=v i/m i；collisionQuadraticPath 与 verlet 如式(3.18)及完整速度 Verlet 更新。oneStepIterate G h z j=(G h)^[j]z（MolecularDynamics/Chapter02/OneStepConvergence.lean:1443–1444），所以这里迭代的 h 参数是固定外层 hmax，实际累计时间另由 times 的 min(tc,hmax) 递推。admissibleCollisionState（Statements.lean:4464–4465）为 g(q)>0 或 g(q)=0 且 ∑ grad g(q)_i p\_i/m\_i>0。finiteCollisionTrajectory（4431–4440）只要求 q 在闭区间连续、g(q)≥0、在开区间非事件处满足 Newton ODE，并在有限 events 的每个内部事件有接触、左右动量极限、负入射法向速度及弹性左右极限关系；它不规定 p 在端点的值／连续性，不规定事件处 p(t) 取哪侧，也没有“所有接触恰为 events”的双向资格。签名再要求每个 admissible 状态都有有限最小正二次路径根 tc，明确给出 Rc 的质量加权反射公式，并要求所有 h>0、所有状态满足分支关系。结论是存在统一 C,δ，在合格自适应网格上允许 θ:ℝ≃oℝ 的 O(hmax²) 时间对齐后，全相空间节点误差 O(hmax²)，且 θ 固定0和τ。定义全部已找到，不需要 NEEDS\_HUMAN。
[EXTRA]正质量、光滑势／接触函数和有限非切向实际事件，是可用于限定二阶论断的合理资格，但数值根没有横截条件；所谓“有限横截隔离事件”只保证列出的实际 events，而不排除漏列接触。排除 tc=hmax 如实避开原书未反射边界，得到的是额外限定版本；时间对齐在结论中而非前提中，不能冒充原书明示的同时间二阶误差定义。要求对所有 admissible 状态必有有限未来根不必要且过强，排除了自由静止或永不相撞的合法状态，宜按有限窗口／可选接触表示。
更直接地，现有签名为假：finiteCollisionTrajectory 没有约束终点动量，却在结论中强制比较该终点动量，下面反例满足全部现有前提。原书的概括性论断不能由这一失真的轨迹对象承载。[ERRATUM?]本条无该标签；保留原书严格分支，不因本次签名反例给原书添加未经依据的勘误。该 theorem 的证明体为 sorry，这是独立的证明完成度问题，FAIL 来自定义／结论反例而非 sorry。

### 7. 状态与证明位置

incomplete；`MD.Ch03.collisionalVerletOrder`：未证（原书疑误不证）；`MD.Ch03.collisionalVerletOrder_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2586)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.3-PairForceDecoupling · definition · 印刷p.136 / PDFp.158

### 2. 原文陈述

> This can be achieved in systems of spheres with pair potentials $\varphi_{ij}$ only by writing $\varphi_{ij}=\alpha_{ij}+\beta_{ij}$ where the derivative of the second term is chosen to vanish at the point of contact between the spheres, i.e. $\alpha'_{ij}(\sigma_i+\sigma_j)=0$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def pairForceDecoupling (φ α β : ℝ → ℝ) (contact : ℝ) : Prop :=
  (∀ r, φ r=α r+β r) ∧ deriv α contact=0



/-- 修正版，对应原文 MD-3.7.3-PairForceDecoupling。改动：明确α为kick势并补接触点可微，deriv α contact=0才作为经典零接触力；α/β文字冲突保留导师选项。 -/
```

独立修正版：

```lean
def pairForceDecoupling_corrected (φ α β : ℝ → ℝ) (contact : ℝ) : Prop :=
  (∀ r, φ r=α r+β r) ∧ DifferentiableAt ℝ α contact ∧ deriv α contact=0
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.pairForceDecoupling`；`MD.Ch03.pairForceDecoupling_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 明确α为kick势并补接触点可微，deriv α contact=0才作为经典零接触力；α/β文字冲突保留导师选项。 | [EXTRA] |

[EXTRA] [ERRATUM?] 明确α为kick势并补接触点可微，deriv α contact=0才作为经典零接触力；α/β文字冲突保留导师选项。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；Ch03.lean:1467–1468展开为对每个实数r有φ(r)=α(r)+β(r)，且deriv α contact=0；无其他封装定义。contact作为σ\_i+σ\_j的参数化是合理抽象，但定义只保留展示公式的α′条件，没有解决原文“second term”应指β而后句又让β负责kick的矛盾。[ERRATUM?]冲突经PDF确认成立；需数学判断究竟修改文字“second”为“first”，还是修改公式α′为β′，两者会产生不同算法。另需注意Lean的deriv是全函数，未可微处取0；原书谈导数的语义需适当可微条件。无[EXTRA]。这是定义而非含sorry的定理，签名问题独立于证明状态。所需定义均已找到，NEEDS\_HUMAN的原因仅为上述原书问题。

### 7. 状态与证明位置

self-contained；`MD.Ch03.pairForceDecoupling`：定义；`MD.Ch03.pairForceDecoupling_corrected`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2639)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.3-DecoupledOrder · unnumbered_claim · 印刷p.136 / PDFp.158

### 2. 原文陈述

> The idea is to exploit the observation that impulsive forces (“kicks”) can be supplied without reducing the order of accuracy as long as these have a vanishing component in the direction of the collision vector $u_\perp$, that is if $F_\perp=-\nabla U(q_c)\cdot u_\perp=0$.
> If this decomposition is used, then it is possible to build a 2nd order accurate hybrid method that uses only the first part $\alpha$ to define the quadratic Verlet paths for the collision detection scheme, whereas $\beta$ is introduced as a standard “kick” at collision points.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem decoupledOrder :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U V g : Q n → ℝ) (q p : ℝ → Q n) τ events
    (Gfree : ℝ → Z n → Z n), positiveMass m → ContDiff ℝ ⊤ U → ContDiff ℝ ⊤ V →
    ContDiff ℝ ⊤ g → 0 < τ →
    (∀ x, g x=0 → ∑ i, grad g x i*invMass m (grad U x) i=0) →
    finiteCollisionTrajectory m (fun x => -grad U x-grad V x) g q p 0 τ events →
    (∀ z, 0 ≤ g z.1 → ∀ T > 0, ∃ ev, Gfree 0 z=z ∧
      finiteCollisionTrajectory m (fun x => -grad V x) g
        (fun t => (Gfree t z).1) (fun t => (Gfree t z).2) 0 T ev) →
    collisionalGlobalOrder (fun h =>
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1)) ∘ Gfree h ∘
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1))) q p τ 2 := by
  sorry



/-- 修正版，对应原文 MD-3.7.3-DecoupledOrder。改动：限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。 -/
```

独立修正版：

```lean
theorem decoupledOrder_corrected :
  ∀ (n : ℕ) (m : Fin n → ℝ) (U V g : Q n → ℝ) (q p : ℝ → Q n) τ events
    (Gfree : ℝ → Z n → Z n), positiveMass m → ContDiff ℝ ∞ U → ContDiff ℝ ∞ V →
    ContDiff ℝ ∞ g → 0 < τ →
    (∀ x, g x=0 → ∑ i, grad g x i*invMass m (grad U x) i=0) →
    finiteCollisionTrajectory_corrected m (fun x => -grad U x-grad V x) g q p τ events →
    (∀ z, 0 ≤ g z.1 → (∀ t ≥ 0, Tendsto (fun s => (Gfree s z).2) (𝓝[>] t) (𝓝 ((Gfree t z).2)))) →
    (∀ z, 0 ≤ g z.1 → ∀ T > 0, ∃ ev, Gfree 0 z=z ∧
      finiteCollisionTrajectory m (fun x => -grad V x) g
        (fun t => (Gfree t z).1) (fun t => (Gfree t z).2) 0 T ev) →
    collisionalGlobalOrder (fun h =>
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1)) ∘ Gfree h ∘
      (fun z : Z n => (z.1,z.2-(h/2) • grad U z.1))) q p τ 2 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch03.decoupledOrder`；`MD.Ch03.decoupledOrder_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 以U表示真正kick势并要求它在接触法向导数0；另一V用于碰撞子流；正质量、有限横截隔离事件与时间对齐误差。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。 | [EXTRA] |

[EXTRA] 以U表示真正kick势并要求它在接触法向导数0；另一V用于碰撞子流；正质量、有限横截隔离事件与时间对齐误差。；[ERRATUM?] 限定为事件表穷尽真实接触、非零法向、初端右连续、终端左连续且终端无碰撞、事件取碰后动量的轨道；只保留明确的时间对齐误差目标，不宣称同时间动量阶。精确子流Strang仍是独立限定解释，原混合法及无根事件分支未覆盖。二阶项另限数值碰撞横截；尚缺统一事件稳定性与误差累积理论。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖Ch03\_deps.txt已展开：ReviewDefinitions中的Q n=Fin n→ℝ，Z n=Q n×Q n，grad U q i=(fderiv ℝ U q)(Pi.single i 1)，invMass m v i=v\_i/m\_i，positiveMass为逐分量正质量；Statements中的finiteCollisionTrajectory要求q在闭区间连续、g(q)≥0、非事件开区间内q′=M⁻¹p及p′=F(q)，有限事件具有入射负法向速度、左右极限和弹性反射；但不约束p在0、τ或事件时刻的实际取值，也不要求端点动量连续。collisionalGlobalOrder展开为∃C>0、ν₀>0，对每个ν≥ν₀存在保序双射θ，固定0和τ且|θ(t)−t|≤C(τ/ν)^2，所有j≤ν的数值状态与(q,p)(θ(jτ/ν))误差≤C(τ/ν)^2；oneStepIterate是真正从(q0,p0)迭代(G h)^j。以下无碰撞反例已否定签名。[EXTRA]正质量、有限横截事件、光滑性和允许O(h²)时间对齐可作为明确的局部适用条件，但Gfree被假设为任意时长的精确V碰撞流，结论使用步首步尾U半kick，未给出原书α的二次Verlet碰撞检测及在碰撞点施加β kick的混合法。边界法向条件是质量加权grad g·M⁻¹grad U=0，需说明它与原书u_⊥的坐标/质量约定，不能直接认作原书未加权点积。并且对所有g≥0状态要求全时长Gfree远强于有限横截局部问题；缺少右连续及端点实际动量约定。[ERRATUM?]原书α/β矛盾确实存在，需另行裁定，但此FAIL不依赖其裁定。Ch03.lean:1485后为sorry；未证明状态与上述语义失败分别记录。

### 7. 状态与证明位置

incomplete；`MD.Ch03.decoupledOrder`：未证（原书疑误不证）；`MD.Ch03.decoupledOrder_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2652)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.3-ModifiedCollisionProjection · definition · 印刷p.136 / PDFp.158

### 2. 原文陈述

> In particular, one may use the backward error analysis to obtain a modified Hamiltonian $\widetilde H_h$ corresponding to the Verlet method with stepsize $h$, then to project during collisions not onto the energy surface, but onto the modified energy surface, so that

$$
\widetilde H_h\equiv\mathrm{const}.
$$


> (In practice, a low order approximation of $\widetilde H_h$ is used, such as the truncation to terms of order four or six in the stepsize.)

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def modifiedCollisionProjection {n : ℕ} (H : SymplecticCoordinates n → ℝ)
    (Hj : ℕ → SymplecticCoordinates n → ℝ) (r k : ℕ) (h : ℝ)
    (z w : SymplecticCoordinates n) : Prop :=
  textbookTruncatedHamiltonian H Hj r k h w=textbookTruncatedHamiltonian H Hj r k h z
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | [EXTRA] 通用有限截断Hamiltonian等值辅助关系；不覆盖原段Verlet专属修正系数、投影存在唯一、变步长共同修正能量或统计精度。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.modifiedCollisionProjection` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] [EXTRA] 通用有限截断Hamiltonian等值辅助关系；不覆盖原段Verlet专属修正系数、投影存在唯一、变步长共同修正能量或统计精度。 未覆盖内容已列coverage\_gaps；原引文保留。 | [EXTRA] |
| 尚未覆盖的结论 | Hj为Verlet修正系数的资格绑定 | 覆盖缺口，未声称已证明 |
| 尚未覆盖的结论 | 四阶/六阶截断专属选择 | 覆盖缺口，未声称已证明 |
| 尚未覆盖的结论 | 投影存在唯一性 | 覆盖缺口，未声称已证明 |
| 尚未覆盖的结论 | 整个变步长轨道共同修正能量及BEA/统计精度 | 覆盖缺口，未声称已证明 |

[EXTRA] [EXTRA] [EXTRA] 通用有限截断Hamiltonian等值辅助关系；不覆盖原段Verlet专属修正系数、投影存在唯一、变步长共同修正能量或统计精度。 未覆盖内容已列coverage\_gaps；原引文保留。

### 6. 审计结论

本轮修复：[EXTRA] 通用有限截断Hamiltonian等值辅助关系；不覆盖原段Verlet专属修正系数、投影存在唯一、变步长共同修正能量或统计精度。 未覆盖内容已列coverage\_gaps；原引文保留。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；modifiedCollisionProjection对任意相空间维数、任意H/Hj、任意自然r,k、实h和两状态，仅定义H(w)+∑j∈[r,k]h^jHj(w)=同一表达式在z的值。等值关系本身正确，并不保证投影存在唯一，context对此已披露；但Hj与Verlet没有任何资格绑定，r,k也不指定四阶/六阶或Verlet偶次修正，因而不能表达所引“Verlet对应的修正Hamiltonian”的完整结论。当前statement\_scope仍泛指整段，[EXTRA]为空，遗漏的是核心对象资格，不是要求补证明。即便关系成立也不能推出整个变步长轨道有一个共同修正能量，更不能推出BEA/统计精度。

### 7. 状态与证明位置

self-contained；`MD.Ch03.modifiedCollisionProjection`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2690)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-FreeHardSphereHamiltonian · definition · 印刷p.133 / PDFp.155

### 2. 原文陈述

> The hard sphere system described by

$$
H_{\mathrm{free}}=p^TM^{-1}p/2+U_{\mathrm{h.s.}}
$$


> consists of purely ballistic (straight line) motion punctuated by momentum jumps.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def freeHardSphereHamiltonian {N d : ℕ} (m σ : Fin N → ℝ)
    (_hm : ∀ i, 0 < m i) (q p : Fin N → Position d) : WithTop ℝ :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ ≤ σ i+σ j then ⊤
  else ((∑ i, ‖p i‖^2/(2*m i) : ℝ) : WithTop ℝ)

theorem freeHardSphereHamiltonian_ballistic {N d : ℕ} (m : Fin N → ℝ)
    (_hm : ∀ i, 0 < m i) (q p : Fin N → Position d) :
    (∀ t : ℝ, HasDerivAt (fun s ↦ fun i ↦ q i+(s/m i) • p i)
      (fun i ↦ (m i)⁻¹ • p i) t) ∧
    (∀ t : ℝ, HasDerivAt (fun _ : ℝ ↦ p) 0 t) := by
  sorry

def freeHardSphereHamiltonian_contactAllowed {N d : ℕ} (m σ : Fin N → ℝ)
    (q p : Fin N → Position d) : WithTop ℝ :=
  @ite (WithTop ℝ) (q ∈ MolecularDynamics.Chapter03Review.hardCoreDomain σ)
    (Classical.propDecidable _) ((∑ i, ‖p i‖^2/(2*m i) : ℝ) : WithTop ℝ) ⊤



/-- 修正版，对应原文 MD-3.7.1-FreeHardSphereHamiltonian。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def freeHardSphereHamiltonian_corrected {N d : ℕ} (m σ : Fin N → ℝ)
    (_hm : ∀ i, 0 < m i) (q p : Fin N → Position d) : WithTop ℝ :=
  if ∃ i j, i ≠ j ∧ ‖q i-q j‖ ≤ σ i+σ j then ⊤
  else ((∑ i, ‖p i‖^2/(2*m i) : ℝ) : WithTop ℝ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 原印自由硬球Hamiltonian、非接触弹道ODE；所引动力学中接触弹性反射关系及能量保存由MD-3.7-ElasticReflection和MD-3.7-ElasticEnergy承担。原印≤边界与接触允许物理版本独立命名。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch03.freeHardSphereHamiltonian`；`MD.Ch03.freeHardSphereHamiltonian_ballistic`；`MD.Ch03.freeHardSphereHamiltonian_contactAllowed`；`MD.Ch03.freeHardSphereHamiltonian_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量下用WithTop ℝ保留有限动能和+∞障碍；沿用p132接触允许的边界，p133≤疑点仍由HardCorePotential保留。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 忠实保留原印≤无穷势并显式正质量，接触允许物理版本另名存档；补非接触直线运动q′=M⁻¹p,p′=0，接触弹性反射由ElasticReflection/ElasticEnergy原有条目承担。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 正质量下用WithTop ℝ保留有限动能和+∞障碍；沿用p132接触允许的边界，p133≤疑点仍由HardCorePotential保留。；[EXTRA] 忠实保留原印≤无穷势并显式正质量，接触允许物理版本另名存档；补非接触直线运动q′=M⁻¹p,p′=0，接触弹性反射由ElasticReflection/ElasticEnergy原有条目承担。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；主定义对正质量、N个d维位置和动量给出原印≤障碍的自由Hamiltonian，有限区动能∑‖pi‖²/(2mi)及WithTop ℝ编码正确。ballistic辅助对所有t给出q\_i(t)=q\_i+t p\_i/mi的全局导数及常动量导数0，公式正确；它是自由段ODE公式，不声称直线路径穿过障碍仍是实际硬球轨道。contactAllowed辅助保留闭可行域版本；其自身未带正质量前提，作为实全除法定义有意义，物理使用须另加正质量。scope已明确接触反射由其他条目承担。旧[EXTRA]第一项说主版本沿用p132接触允许，与当前主定义矛盾，应更正；原印边界冲突仍须人工处理。

### 7. 状态与证明位置

incomplete；`MD.Ch03.freeHardSphereHamiltonian`：定义；`MD.Ch03.freeHardSphereHamiltonian_ballistic`：未证（原书疑误不证）；`MD.Ch03.freeHardSphereHamiltonian_contactAllowed`：定义；`MD.Ch03.freeHardSphereHamiltonian_corrected`：定义。
位置：[Blueprint/Ch03.lean](../../Blueprint/Ch03.lean#L2699)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

