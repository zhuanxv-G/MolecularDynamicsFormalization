[上一部分](part04.zh-CN.md) / [目录](../../CH03_BLUEPRINT.zh-CN.md) / [下一部分](part06.zh-CN.md)

## 1. MD-3.4-Thm3.1 · Theorem 3.1 · 印刷p.114–116 / PDFp.136–138

### 2. 原文陈述

> Theorem 3.1. Suppose the Hamiltonian $`H`$ and modified Hamiltonian $`\bar H_k`$ are smooth functions globally defined on a convex, compact subset $`\mathcal B`$ of $`\mathbb R^{2N_c}`$ and suppose that the exact solution and numerical approximations (for $`h`$ sufficiently small) are confined to $`\mathcal B`$. Then, we have asymptotically for $`h\to0`$ that

$$
H(\boldsymbol z_n)=H(\boldsymbol z_0)+O(h^r),
$$


> for $`n=0,1,\ldots,\nu`$ where $`\tau=\nu h=O(h^{-k+r})`$.

### 3. 原文证明

> Proof First observe that due to smoothness and the assumptions on $`\mathcal B`$, we have a global Lipschitz constant

$$
|H(\boldsymbol u)-H(\boldsymbol v)|\lt  L\|\boldsymbol u-\boldsymbol v\|
$$


> for all $`\boldsymbol u,\boldsymbol v\in\mathcal B`$.
> Denote by $`\mathcal F_h^{(k)}`$ the flow map of the truncated Hamiltonian expansion $`\bar H_k`$,

$$
\mathcal F_h^{(k)}\stackrel{\mathrm{def}}=\exp(h\mathcal L_{\bar H_k}).
$$


> By construction, we have

$$
\boldsymbol z_{n+1}=\mathcal F_h^{(k)}(\boldsymbol z_n)+\boldsymbol\eta_n
$$


> where $`\|\boldsymbol\eta_n\|\le Ch^{k+1}`$.
> Since $`\mathcal F_h^{(k)}`$ preserves its Hamiltonian (3.11), we have

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


> We have $`\nu=\tau/h`$, thus

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


> so that, as long as $`\nu\le C_2h^{-k+r-1}`$, we have

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1079)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-CompactLipschitz · unnumbered_claim · 印刷p.114 / PDFp.136

### 2. 原文陈述

> Proof First observe that due to smoothness and the assumptions on $`\mathcal B`$, we have a global Lipschitz constant

$$
|H(\boldsymbol u)-H(\boldsymbol v)|\le L\|\boldsymbol u-\boldsymbol v\|
$$


> for all $`\boldsymbol u,\boldsymbol v\in\mathcal B`$.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1114)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-TruncatedFlow · definition · 印刷p.115 / PDFp.137

### 2. 原文陈述

> Denote by $`\mathcal F_h^{(k)}`$ the flow map of the truncated Hamiltonian expansion $`\bar H_k`$,

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1121)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-FiniteMatchingConstruction · unnumbered_claim · 印刷p.115 / PDFp.137

### 2. 原文陈述

> By construction, we have

$$
\boldsymbol z_{n+1}=\mathcal F_h^{(k)}(\boldsymbol z_n)+\boldsymbol\eta_n
$$


> where $`\|\boldsymbol\eta_n\|\le Ch^{k+1}`$.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1129)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-TruncatedConservation · unnumbered_claim · 印刷p.115 / PDFp.137

### 2. 原文陈述

> Since $`\mathcal F_h^{(k)}`$ preserves its Hamiltonian (3.11), we have

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1140)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1162)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1197)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1240)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1251)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-PolynomialEnergyRate · unnumbered_claim · 印刷p.116 / PDFp.138

### 2. 原文陈述

> so that, as long as $`\nu\le C_2h^{-k+r-1}`$, we have

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1325)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-StepCountPower · unnumbered_claim · 印刷p.116 / PDFp.138

### 2. 原文陈述

> so that, as long as $`\nu\le C_2h^{-k+r-1}`$, we have

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1350)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-ArbitraryFiniteTruncation · unnumbered_claim · 印刷p.116 / PDFp.138

### 2. 原文陈述

> If the differential equations are infinitely differentiable, we may take the truncation index $`k`$ as large as we like, but the constants appearing in the above theorem will depend on the truncation index in a complicated way.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1358)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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

