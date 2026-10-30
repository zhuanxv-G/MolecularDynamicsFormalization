[上一部分](part06.zh-CN.md) / [目录](../../CH04_BLUEPRINT.zh-CN.md) / [下一部分](part08.zh-CN.md)

## 1. MD-4.3.5-ConstrainedOrders · unnumbered_claim · 印刷p.161 / PDFp.183

### 2. 原文陈述

> The projected symplectic constrained method (4.20)–(4.24) is only first order accurate. We forego providing a detailed proof of this fact, but note that it could be demonstrated using standard methods [164]. There are several constraint-preserving, second-order alternatives which generalize the Störmer-Verlet scheme. One of these is the SHAKE method [322]. The symmetry suggests that this will be second order.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constrainedOrders :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (Φ E R : ℝ → MolecularDynamics.Chapter04Review.Z n) (pE pR : ℝ → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 R → ContDiff ℝ 3 Φ → E 0=z → R 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (R h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖R h-Φ h‖ ≤ C*h^3 := by
  sorry

theorem constrainedOrders_global (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (D : Set (MolecularDynamics.Chapter04Review.Z n)) (_hD : IsOpen D)
    (_hm : ∀ i, 0 < m i) (_hU : ContDiff ℝ 4 U) (_hg : ∀ j, ContDiff ℝ 4 (g j))
    (_hreg : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      (textbookConstraintGram m g z.1).det ≠ 0)
    (E R : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n)
    (pE pR : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n)
    (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (η : ℝ) (_hη : 0 < η)
    (_hE : ContDiffOn ℝ 3 (Function.uncurry E) (Ioo (-η) η ×ˢ D))
    (_hR : ContDiffOn ℝ 3 (Function.uncurry R) (Ioo (-η) η ×ˢ D))
    (_hrhoE : ContDiffOn ℝ 2 (Function.uncurry rhoE) (Ioo (-η) η ×ˢ D))
    (_hμE : ContDiffOn ℝ 2 (Function.uncurry μE) (Ioo (-η) η ×ˢ D))
    (_hrhoR : ContDiffOn ℝ 2 (Function.uncurry rhoR) (Ioo (-η) η ×ˢ D))
    (_hμR : ContDiffOn ℝ 2 (Function.uncurry μR) (Ioo (-η) η ×ˢ D))
    (_hzero : ∀ z ∈ D, E 0 z=z ∧ R 0 z=z ∧ μE 0 z=0 ∧ μR 0 z=0)
    (_hsteps : ∀ h ∈ Ioo (-η) η, ∀ z ∈ D,
      z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (μE h z) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (R h z) (pR h z) (rhoR h z) (μR h z))
    (T : ℝ) (_hT : 0 < T) (Φ : ℝ → MolecularDynamics.Chapter04Review.Z n)
    (_hΦ : ∀ t ∈ Icc 0 T, HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ t)) t)
    (_hc : ∀ t ∈ Icc 0 T, Φ t ∈ MolecularDynamics.Chapter04Review.cotangentSet m g)
    (_hcompact : ∃ B, IsCompact B ∧ B ⊆ D ∧ ∀ t ∈ Icc 0 T, Φ t ∈ B) :
    ∃ C > 0, ∃ N₀ : ℕ, ∀ N ≥ N₀, 0 < N →
      let h := T/(N:ℝ)
      ∀ k ≤ N, ‖(E h)^[k] (Φ 0)-Φ ((k:ℝ)*h)‖ ≤ C*h ∧
        ‖(R h)^[k] (Φ 0)-Φ ((k:ℝ)*h)‖ ≤ C*h^2 := by
  sorry

theorem constrainedOrders_firstOrderSharp :
    ∃ c > 0, ∃ N₀ : ℕ, ∀ N ≥ N₀, 0 < N →
      c/(N:ℝ) ≤ ‖(MolecularDynamics.Chapter04Review.symplecticEulerMatrix 1 (1/(N:ℝ)))^N *ᵥ
        (![1,0] : Fin 2 → ℝ)-![Real.cos 1,-Real.sin 1]‖ := by
  sorry



/-- 修正版，对应原文 MD-4.3.5-ConstrainedOrders。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem constrainedOrders_corrected :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (Φ E R : ℝ → MolecularDynamics.Chapter04Review.Z n) (pE pR : ℝ → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 R → ContDiff ℝ 3 Φ → E 0=z → R 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      MolecularDynamics.Chapter04Review.rattleRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (R h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖R h-Φ h‖ ≤ C*h^3 := by
  first
  | rfl
  | assumption
  | solve | simp only
  | sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 投影Euler全局一阶（含非二阶实例）及RATTLE全局二阶；SHAKE位置全局二阶由MD-4.3.5-SHAKEPositionOrder承担，其原印质量约定待导师。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedOrders`；`MD.Ch04.constrainedOrders_global`；`MD.Ch04.constrainedOrders_firstOrderSharp`；`MD.Ch04.constrainedOrders_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 正质量、C⁴数据、独立约束与真实光滑隐式解分支及紧区间；明确局部截断误差Euler O(h²)、RATTLE O(h³)。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留局部一致性辅助，补真实光滑正则求解分支及紧时间精确轨道上的全局Euler一阶/RATTLE二阶，并给无约束振子一阶下界表达only first order。SHAKE位置阶专归SHAKEPositionOrder，其质量勘误路线待导师；原文不删。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 正质量、C⁴数据、独立约束与真实光滑隐式解分支及紧区间；明确局部截断误差Euler O(h²)、RATTLE O(h³)。；[EXTRA] 保留局部一致性辅助，补真实光滑正则求解分支及紧时间精确轨道上的全局Euler一阶/RATTLE二阶，并给无约束振子一阶下界表达only first order。SHAKE位置阶专归SHAKEPositionOrder，其质量勘误路线待导师；原文不删。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；constrainedOrders：正质量、C⁴势/约束、初点余切约束及Gram非零；E/R/Φ为C³步长曲线且在0等于z，乘子为C²，末投影μE、μR在0为零；真实步关系与精确ODE在双侧小窗口成立。结论是同一起点单步Euler O(h²)、RATTLE O(h³)，并非全局阶。pE/pR未单列光滑性，但步关系已给其光滑表达式。global另在开放D上设联合C³ E/R、联合C²乘子、零步恒等及正则余切域；精确轨道在[0,T]落于D内紧集。结论对充分大正整数N、全部k≤N给Euler Ch和RATTLE Ch²全局误差；没有将误差作为假设。firstOrderSharp对T=1振子初值(1,0)给全步误差c/N下界，确实排除该方法统一二阶。以上对正力号修订方法数学上合理，但与原印负力号不能无标记等同。

### 7. 状态与证明位置

incomplete；`MD.Ch04.constrainedOrders`：未证（原书疑误不证）；`MD.Ch04.constrainedOrders_global`：未证（原书疑误不证）；`MD.Ch04.constrainedOrders_firstOrderSharp`：未证（原书疑误不证）；`MD.Ch04.constrainedOrders_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1865)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-RATTLESymplectic · unnumbered_claim · 印刷p.162 / PDFp.184

### 2. 原文陈述

> Moreover, the symplecticness of (4.30)–(4.34) may be demonstrated using a very similar approach to that used to demonstrate the symplectic condition for (4.20)–(4.24). Given the above discussion and derivation, the proof of symplecticness of the RATTLE method (4.30)–(4.34) is now a formality. For details refer to [229].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem rattleSymplectic (n l : ℕ) (m : Fin n → ℝ)
    (U : MolecularDynamics.Chapter04Review.Q n → ℝ)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (_hm : ∀ i, 0 < m i) (_hU : ContDiff ℝ 2 U) (_hg : ∀ j, ContDiff ℝ 2 (g j))
    (D : Set (MolecularDynamics.Chapter04Review.Z n)) (_hD : IsOpen D) (h : ℝ)
    (G : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n)
    (half : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n)
    (rho μ : MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l)
    (_hreg : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) z.1))
    (_hG : ContDiffOn ℝ 1 G D) (_hp : ContDiffOn ℝ 1 half D)
    (_hr : ContDiffOn ℝ 1 rho D) (_hμ : ContDiffOn ℝ 1 μ D)
    (_hstep : ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.rattleRelation m
        (fun q ↦ -MolecularDynamics.Chapter04Review.grad U q) g h z (G z) (half z) (rho z) (μ z)) :
    ∀ z ∈ D, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      ∀ u v, MolecularDynamics.Chapter04Review.tangentPhase m g z u →
      MolecularDynamics.Chapter04Review.tangentPhase m g z v →
        MolecularDynamics.Chapter04Review.phaseForm ((fderiv ℝ G z) u) ((fderiv ℝ G z) v)=
          MolecularDynamics.Chapter04Review.phaseForm u v := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.rattleSymplectic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际C¹分支、C²势与约束；完整真实拉回两形式，非把辛性作假设。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 改为正质量、C²势/约束、余切域满秩的开放邻域C¹求解分支上真实拉回辛性；不假设全局隐式单值法，不声称分支存在。 | [EXTRA] |

[EXTRA] 实际C¹分支、C²势与约束；完整真实拉回两形式，非把辛性作假设。；[EXTRA] 改为正质量、C²势/约束、余切域满秩的开放邻域C¹求解分支上真实拉回辛性；不假设全局隐式单值法，不声称分支存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意n/l、正质量、C² U/g、开放D及固定实步长h；仅在D与余切约束集交上要求位置梯度独立。G、half、rho、μ均在D上C¹；真实RATTLE关系只对约束初点要求，输出由关系保证位置及隐藏约束。tangentPhase准确包含g的一阶切条件及g′M⁻¹p的一阶切条件。结论对每个该初点及任意两条切向量给phaseForm(DG u,DG v)=phaseForm(u,v)，是完整受限辛性。正质量和满秩使该受限域为正则余切流形，允许由约束集上的关系沿切向量微分。h=0亦无问题。未要求全局单值求解或分支存在。[EXTRA]与签名一致；sorry不参与判错。

### 7. 状态与证明位置

incomplete；`MD.Ch04.rattleSymplectic`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1945)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-StaggeredConstraint · definition · 印刷p.162 / PDFp.184

### 2. 原文陈述

> the iterations generated by them can be related to the following staggered iteration

$$
q_{n+1}=q_n+hM^{-1}p_{n+1/2},\tag{4.35}
$$



$$
p_{n+1/2}=p_{n-1/2}+hF_n-hg'(q_n)^T\widetilde\lambda_n,\tag{4.36}
$$



$$
0=g(q_{n+1}),\tag{4.37}
$$


> where, for SHAKE, $`\widetilde\lambda_n=\lambda_n`$, while, in case of RATTLE, we must define $`\widetilde\lambda_n=(\lambda_n+\mu_n)/2`$.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def staggeredConstraintRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (q qnew oldHalf newHalf : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  newHalf=oldHalf+h • (F q-(textbookConstraintJacobian g q)ᵀ *ᵥ rho) ∧
  qnew=q+h • MolecularDynamics.Chapter04Review.invMass m newHalf ∧ qnew ∈ MolecularDynamics.Chapter04Review.constraintSet g



/-- 修正版，对应原文 MD-4.3.5-StaggeredConstraint。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def staggeredConstraintRelation_corrected {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (q qnew oldHalf newHalf : MolecularDynamics.Chapter04Review.Q n) (rho : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  newHalf=oldHalf+h • (F q-(textbookConstraintJacobian g q)ᵀ *ᵥ rho) ∧
  qnew=q+h • MolecularDynamics.Chapter04Review.invMass m newHalf ∧ qnew ∈ MolecularDynamics.Chapter04Review.constraintSet g
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.staggeredConstraintRelation`；`MD.Ch04.staggeredConstraintRelation_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。参数rho是独立的交错乘子，关系完整记录(4.35)–(4.37)，无sorry。但原文还有SHAKE的tildeλ=λ和RATTLE的tildeλ=(λ+μ)/2及两种迭代可归约为此关系，签名没有原方法乘子、无换算公式、无归约断言，遗漏实质子句。[ERRATUM?]成立：合并上一RATTLE末步和当前首步得newHalf=oldHalf+hF−Gᵀ(μₙ+(h/2)λₙ)，故h≠0时tildeλ=λₙ/2+μₙ/h，非印刷平均。

### 7. 状态与证明位置

self-contained；`MD.Ch04.staggeredConstraintRelation`：定义；`MD.Ch04.staggeredConstraintRelation_corrected`：定义。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1970)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKERATTLEEquivalence · unnumbered_claim · 印刷p.162 / PDFp.184

### 2. 原文陈述

> Given an initial condition $`(q_0^S,p_0^S)`$ for the SHAKE discretization, we easily determine $`\lambda_0^S`$ by taking a step. Then it follows that

$$
p_{-1/2}=p_0-(h/2)F(q_0^S)-(h/2)g'(q_0^S)^T\lambda_0^S,
$$


> by solving (4.29). Next we obtain $`p_0^R`$ by solving (4.33)–(4.34) with $`n=-1`$. Then the sequences generated using $`(q_0^S,p_0^S)`$ as the initial point for SHAKE and that generated using $`(q_0^S,p_0^R)`$ in RATTLE will have identical positions (the momenta can be made compatible by simply projecting the SHAKE momenta onto the constraints).

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shakeRattlePositions :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) h,
    h ≠ 0 → (∀ i, 0 < m i) →
    (∀ q, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      LinearIndependent ℝ (fun j => textbookConstraintGradient (g j) q)) →
    (∀ q base : MolecularDynamics.Chapter04Review.Q n, ∀ eta nu : MolecularDynamics.Chapter04Review.Q l, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      MolecularDynamics.Chapter04Review.projectionResidual m g q base eta=0 → MolecularDynamics.Chapter04Review.projectionResidual m g q base nu=0 →
      (textbookConstraintJacobian g q)ᵀ *ᵥ eta=(textbookConstraintJacobian g q)ᵀ *ᵥ nu) →
    ∀ (qS pS qR pR halfS halfR : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhoS rhoR muR : ℕ → MolecularDynamics.Chapter04Review.Q l),
      qS 0=qR 0 → halfS 0=halfR 0 →
      (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (qS k,pS k) (qS (k+1),pS (k+1))
        (halfS k) (rhoS k) (rhoS (k+1))) →
      (∀ k, MolecularDynamics.Chapter04Review.rattleRelation m F g h (qR k,pR k) (qR (k+1),pR (k+1))
        (halfR k) (rhoR k) (muR (k+1))) →
      ∀ k, qS k=qR k ∧ pR (k+1)=textbookCotangentProjection m g (qS (k+1)) (pS (k+1)) := by
  sorry



/-- 修正版，对应原文 MD-4.3.5-SHAKERATTLEEquivalence。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shakeRattlePositions_corrected :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) h,
    h ≠ 0 → (∀ i, 0 < m i) →
    (∀ q, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      LinearIndependent ℝ (fun j => textbookConstraintGradient (g j) q)) →
    (∀ q base : MolecularDynamics.Chapter04Review.Q n, ∀ eta nu : MolecularDynamics.Chapter04Review.Q l, q ∈ MolecularDynamics.Chapter04Review.constraintSet g →
      MolecularDynamics.Chapter04Review.projectionResidual m g q base eta=0 → MolecularDynamics.Chapter04Review.projectionResidual m g q base nu=0 →
      (textbookConstraintJacobian g q)ᵀ *ᵥ eta=(textbookConstraintJacobian g q)ᵀ *ᵥ nu) →
    ∀ (qS pS qR pR halfS halfR : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhoS rhoR muR : ℕ → MolecularDynamics.Chapter04Review.Q l),
      qS 0=qR 0 → halfS 0=halfR 0 →
      (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (qS k,pS k) (qS (k+1),pS (k+1))
        (halfS k) (rhoS k) (rhoS (k+1))) →
      (∀ k, MolecularDynamics.Chapter04Review.rattleRelation m F g h (qR k,pR k) (qR (k+1),pR (k+1))
        (halfR k) (rhoR k) (muR (k+1))) →
      ∀ k, qS k=qR k ∧ pR (k+1)=textbookCotangentProjection m g (qS (k+1)) (pS (k+1)) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakeRattlePositions`；`MD.Ch04.shakeRattlePositions_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实两套关系、相容初始半动量、正质量和同一局部唯一投影分支；不假设位置序列相同。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA]位置约束上梯度线性独立，保证显式逆Gram投影有定义；旧命题此资格缺失，不静默忽略。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] 真实两套关系、相容初始半动量、正质量和同一局部唯一投影分支；不假设位置序列相同。；[EXTRA]位置约束上梯度线性独立，保证显式逆Gram投影有定义；旧命题此资格缺失，不静默忽略。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开 Ch04\_deps.txt 的 ReviewDefinitions：Q n=Fin n→ℝ，Z n=Q n×Q n；invMass m v 的第i分量为(m i)⁻¹v i；constraintSet g={q | ∀j,g j q=0}。ConstrainedSymplectic 相关定义中 textbookConstraintGradient γ q i=(fderiv ℝ γ q)(Pi.single i 1)，textbookConstraintJacobian 的第j行为该真实梯度，因此 Gᵀρ 为约束梯度线性组合，并非抽象占位符。cotangentSet m g 展开为 g(q)=0 且 G(q)M⁻¹p=0；grad U 是实际 Fréchet 坐标梯度，textbookPotentialForce U=-grad U。已展开projectionResidual\_j=g\_j(base−M⁻¹G(q)ᵀeta)、Gram=GM⁻¹Gᵀ、cotangentMultiplier=Gram⁻¹GM⁻¹p、cotangentProjection=p−GᵀGram⁻¹GM⁻¹p。两套真实步骤、qS0=qR0、halfS0=halfR0推出位置相同及k+1动量投影关系，是合理的条件版本，未直接假设位置相同。正质量及约束上梯度独立为实际投影所需，合理。但原文从给定SHAKE初态构造RATTLE初态，签名把半步兼容直接作假设，没有构造pR0，也无k=0的动量投影结论。宣称“同一局部唯一投影分支”的[EXTRA]实际却量化所有q、所有base、所有eta/nu，要求全局根的法向修正唯一；未限制邻域或分支，远强于局部资格并排除常见非线性约束。[ERRATUM?]初始反力符号疑误成立：由(4.29)应得oldHalf=p0−(h/2)F+(h/2)Gᵀλ0，而印刷为负号。定理体为sorry；本FAIL针对原文初始化缺项与不合理全局资格，不声称这个强假设下的条件定理必然为假。

### 7. 状态与证明位置

incomplete；`MD.Ch04.shakeRattlePositions`：未证（原书疑误不证）；`MD.Ch04.shakeRattlePositions_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L1988)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKEElimination · unnumbered_claim · 印刷p.161 / PDFp.183

### 2. 原文陈述

> It is possible to demonstrate (see exercises) that this method reduces to (4.25)–(4.26) by eliminating the momenta.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shakeElimination :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    h (q p half : ℕ → MolecularDynamics.Chapter04Review.Q n) (rho : ℕ → MolecularDynamics.Chapter04Review.Q l),
    (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (q k,p k) (q (k+1),p (k+1)) (half k) (rho k) (rho (k+1))) →
    ∀ k, MolecularDynamics.Chapter04Review.shakePositionRelation m F g h (q k) (q (k+1)) (q (k+2)) (rho (k+1)) := by
  intro n l m F g h q p half rho hs k
  have h0 := hs k
  have h1 := hs (k+1)
  rcases h0 with ⟨hh0,hq0,hg0,hp0⟩
  rcases h1 with ⟨hh1,hq1,hg1,hp1⟩
  constructor
  · ext i
    have e0 := congrFun hq0 i
    have e1 := congrFun hq1 i
    have e2 := congrFun hp0 i
    have e3 := congrFun hh1 i
    simp [MolecularDynamics.Chapter04Review.invMass,Pi.smul_apply,smul_eq_mul] at e0 e1 e2 e3 ⊢
    linear_combination e1-e0+h*(m i)⁻¹*(e3+e2)
  · simpa [Nat.add_assoc] using hg1



/-- 修正版，对应原文 MD-4.3.5-SHAKEElimination。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shakeElimination_corrected :
  ∀ n l (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    h (q p half : ℕ → MolecularDynamics.Chapter04Review.Q n) (rho : ℕ → MolecularDynamics.Chapter04Review.Q l),
    (∀ k, MolecularDynamics.Chapter04Review.shakeRelation m F g h (q k,p k) (q (k+1),p (k+1)) (half k) (rho k) (rho (k+1))) →
    ∀ k, MolecularDynamics.Chapter04Review.shakePositionRelation m F g h (q k) (q (k+1)) (q (k+2)) (rho (k+1)) := by
  intro n l m F g h q p half rho hs k
  have h0 := hs k
  have h1 := hs (k+1)
  rcases h0 with ⟨hh0,hq0,hg0,hp0⟩
  rcases h1 with ⟨hh1,hq1,hg1,hp1⟩
  constructor
  · ext i
    have e0 := congrFun hq0 i
    have e1 := congrFun hq1 i
    have e2 := congrFun hp0 i
    have e3 := congrFun hh1 i
    simp [MolecularDynamics.Chapter04Review.invMass,Pi.smul_apply,smul_eq_mul] at e0 e1 e2 e3 ⊢
    linear_combination e1-e0+h*(m i)⁻¹*(e3+e2)
  · simpa [Nat.add_assoc] using hg1
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakeElimination`；`MD.Ch04.shakeElimination_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]实际相空间SHAKE消元给质量一致M⁻¹(F−Gᵀλ)；原(4.25)缺M⁻¹的字面版单列待审；只转录正文结论，不进入习题。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]实际相空间SHAKE消元给质量一致M⁻¹(F−Gᵀλ)；原(4.25)缺M⁻¹的字面版单列待审；只转录正文结论，不进入习题。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖展开（Ch04\_deps.txt，MolecularDynamics/Chapter04/ReviewDefinitions.lean）：Q n=Fin n→ℝ；invMass m v 的第 i 分量为 (m i)⁻¹*v i；constraintSet g={x|∀j,g j x=0}；shakePositionRelation a b c rho 为 c−2b+a=h² M⁻¹(F(b)−G(b)ᵀrho) 且 g(c)=0。CotangentProjection.lean 中 textbookConstraintJacobian 的 (j,i) 项是 textbookConstraintGradient (g j) q i；ConstrainedProjection.lean 中该梯度为 (fderiv ℝ (g j) q)(Pi.single i 1)，即真实坐标导数。 shakeRelation 展开为 half=p+(h/2)(F(q)−G(q)ᵀrho)，qnew=q+hM⁻¹half，g(qnew)=0，pnew=half+(h/2)(F(qnew)−G(qnew)ᵀrhonew)。签名全称量化 n,l,m,F,g,h 及四套序列，假设每一步满足该关系；用连续两步消去 p，结论以 k+1 为中心、乘子 rho(k+1)，并包含 g(q(k+2))=0；指标及量词正确，代数不需 h≠0、质量正性或光滑性。[EXTRA] 实际是更换结论公式，非额外假设；质量一致消元在数学上正确，但并非原句声称的印刷 (4.25)。[ERRATUM?] 反力缺失 M⁻¹ 的判断成立，不能对一般非标量对角质量仅重命名乘子解决。故原文忠实性 FAIL，非判定修正式为假。Ch04.lean:1120 有显式代数证明，无 sorry；未运行 Lean 编译，证明完成状态与语义结论分开。

### 7. 状态与证明位置

self-contained；`MD.Ch04.shakeElimination`：已证；`MD.Ch04.shakeElimination_corrected`：已证。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2032)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5-SHAKEPositionOrder · unnumbered_claim · 印刷p.161 / PDFp.183

### 2. 原文陈述

> There are several constraint-preserving, second-order alternatives which generalize the Störmer-Verlet scheme. One of these is the SHAKE method [322]. The symmetry suggests that this will be second order.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem shakePositionOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) tau,
    0 < tau → (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 4 q → ContDiff ℝ 3 p →
    MolecularDynamics.Chapter04Review.constrainedSolution m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g q p rho (Icc 0 tau) →
    (∀ t ∈ Icc 0 tau, (textbookConstraintGram m g (q t)).det ≠ 0) →
    ∃ C > 0, ∃ N0 : ℕ, 2 ≤ N0 ∧ ∀ N ≥ N0,
      let h := tau/N
      ∃ (qn : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhon : ℕ → MolecularDynamics.Chapter04Review.Q l), qn 0=q 0 ∧ qn 1=q h ∧
      (∀ k, k+2 ≤ N → MolecularDynamics.Chapter04Review.shakePositionRelation m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g h
        (qn k) (qn (k+1)) (qn (k+2)) (rhon (k+1))) ∧
      ∀ k ≤ N, ‖qn k-q (k*h)‖ ≤ C*h^2 := by
  sorry



/-- 修正版，对应原文 MD-4.3.5-SHAKEPositionOrder。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem shakePositionOrder_corrected :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (q p : ℝ → MolecularDynamics.Chapter04Review.Q n) (rho : ℝ → MolecularDynamics.Chapter04Review.Q l) tau,
    0 < tau → (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 4 q → ContDiff ℝ 3 p →
    MolecularDynamics.Chapter04Review.constrainedSolution m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g q p rho (Icc 0 tau) →
    (∀ t ∈ Icc 0 tau, (textbookConstraintGram m g (q t)).det ≠ 0) →
    ∃ C > 0, ∃ N0 : ℕ, 2 ≤ N0 ∧ ∀ N ≥ N0,
      let h := tau/N
      ∃ (qn : ℕ → MolecularDynamics.Chapter04Review.Q n) (rhon : ℕ → MolecularDynamics.Chapter04Review.Q l), qn 0=q 0 ∧ qn 1=q h ∧
      (∀ k, k+2 ≤ N → MolecularDynamics.Chapter04Review.shakePositionRelation m (fun x => -MolecularDynamics.Chapter04Review.grad U x) g h
        (qn k) (qn (k+1)) (qn (k+2)) (rhon (k+1))) ∧
      ∀ k ≤ N, ‖qn k-q (k*h)‖ ≤ C*h^2 := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch04.shakePositionOrder`；`MD.Ch04.shakePositionOrder_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]正质量、C⁴势/约束/实际轨道、沿解非奇异Gram、相容两步初值；精确给真实有限区间位置误差O(h²)及分支存在，不把误差界作假设。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]正质量、C⁴势/约束/实际轨道、沿解非奇异Gram、相容两步初值；精确给真实有限区间位置误差O(h²)及分支存在，不把误差界作假设。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；依赖展开（Ch04\_deps.txt，MolecularDynamics/Chapter04/ReviewDefinitions.lean）：Q n=Fin n→ℝ；invMass m v 的第 i 分量为 (m i)⁻¹*v i；constraintSet g={x|∀j,g j x=0}；shakePositionRelation a b c rho 为 c−2b+a=h² M⁻¹(F(b)−G(b)ᵀrho) 且 g(c)=0。CotangentProjection.lean 中 textbookConstraintJacobian 的 (j,i) 项是 textbookConstraintGradient (g j) q i；ConstrainedProjection.lean 中该梯度为 (fderiv ℝ (g j) q)(Pi.single i 1)，即真实坐标导数。 grad U=textbookConstraintGradient U，所以 F=−∇U。constrainedSolution 在 I=[0,tau] 的每个 t 要求 q 的区间导数为 M⁻¹p，p 的区间导数为 −∇U−Gᵀrho，且 g(q)=0；textbookInverseMassMatrix=diag(m\_i⁻¹)，textbookConstraintGram=G diag(m\_i⁻¹) Gᵀ。全称量化数据与精确解后，先要求 tau>0、正质量、U/g/q 为 C⁴、p 为 C³、实际受约束解、沿紧区间 Gram 行列式非零；然后存在与 N 无关的 C>0,N0≥2，每个 N≥N0 存在离散位置及乘子，精确两步初值 qn0=q0,qn1=q(h)，满足 k+2≤N 的递推与全部 k≤N 的误差 C h²。这是真实有限区间二阶位置误差及存在性结论，不是把误差作假设。[EXTRA] 正质量、正则性、独立约束和相容起步对通常二阶收敛论述合理，但 C⁴ 全局正则及精确第二初值属于较强的充分条件，不应称为最小必要条件；结论仅选择存在的好分支，不声称所有隐式根均收敛，也不含动量误差。主要忠实性问题仍是：原页 symmetry 句紧接印刷 (4.25)，Lean 却对质量一致修正式给阶数，改变了方法；一般质量下两者甚至不逼近同一受约束解。因此 FAIL 不由 sorry 引起。Ch04.lean:1142 的证明为 sorry，二阶修正式的证明仍待完成，本审计不把它视为已验证定理。

### 7. 状态与证明位置

incomplete；`MD.Ch04.shakePositionOrder`：未证（原书疑误不证）；`MD.Ch04.shakePositionOrder_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2078)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-AdjointEuler · definition · 印刷p.163 / PDFp.185

### 2. 原文陈述

> Now replace $`h`$ by $`-h`$ and then swap $`Q`$ with $`q`$ and $`P`$ with $`p`$, resulting in

$$
\widehat P=p-hg'(q)^T\lambda,\quad Q=q+hM^{-1}\widehat P,\quad P=\widehat P+hF(Q)-hg'(Q)^T\mu,
$$


> where $`\lambda,\mu`$ are again defined by the constraint conditions. This defines the adjoint method, another first order method for the constrained system.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def adjointEulerRelation {n l : ℕ} (m : Fin n → ℝ) (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) (half : MolecularDynamics.Chapter04Review.Q n) (rho μ : MolecularDynamics.Chapter04Review.Q l) : Prop :=
  half=z.2-h • ((textbookConstraintJacobian g z.1)ᵀ *ᵥ rho) ∧
  out.1=z.1+h • MolecularDynamics.Chapter04Review.invMass m half ∧ out.1 ∈ MolecularDynamics.Chapter04Review.constraintSet g ∧
  out.2=half+h • F out.1-h • ((textbookConstraintJacobian g out.1)ᵀ *ᵥ μ) ∧
  out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g

theorem adjointEuler_inverseRelation (n l : ℕ) (m : Fin n → ℝ)
    (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ) (h : ℝ) (_hh : h ≠ 0)
    (z out : MolecularDynamics.Chapter04Review.Z n)
    (_hz : z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g)
    (_hout : out ∈ MolecularDynamics.Chapter04Review.cotangentSet m g) :
    (∃ half rho μ, adjointEulerRelation m F g h z out half rho μ) ↔
      ∃ pbar rho μ, MolecularDynamics.Chapter04Review.projectedEulerRelation m F g (-h) out z pbar rho μ := by
  sorry

theorem adjointEulerLocalOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (z : MolecularDynamics.Chapter04Review.Z n) (Φ E A : ℝ → MolecularDynamics.Chapter04Review.Z n) (pE pR : ℝ → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoR μR : ℝ → MolecularDynamics.Chapter04Review.Q l),
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g → (textbookConstraintGram m g z.1).det ≠ 0 →
    ContDiff ℝ 3 E → ContDiff ℝ 3 A → ContDiff ℝ 3 Φ → E 0=z → A 0=z → Φ 0=z →
    ContDiff ℝ 2 rhoE → ContDiff ℝ 2 μE → ContDiff ℝ 2 rhoR → ContDiff ℝ 2 μR →
    μE 0=0 → μR 0=0 →
    (∃ δ > 0, ∀ h ∈ Ioo (-δ) δ,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h) (pE h) (rhoE h) (μE h) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h) (pR h) (rhoR h) (μR h) ∧
      HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ h)) h) →
    ∃ C > 0, ∃ δ > 0, ∀ h ∈ Ioo 0 δ, ‖E h-Φ h‖ ≤ C*h^2 ∧ ‖A h-Φ h‖ ≤ C*h^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.adjointEulerRelation`；`MD.Ch04.adjointEuler_inverseRelation`；`MD.Ch04.adjointEulerLocalOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留原三式；补非零h、两端余切域上的真实逆步关系等价（对应所选局部逆分支），及正质量/光滑分支上实际ODE的O(h²)局部误差。未把逆映射或误差结论作为资格。 | [EXTRA] |

[EXTRA] [EXTRA] 保留原三式；补非零h、两端余切域上的真实逆步关系等价（对应所选局部逆分支），及正质量/光滑分支上实际ODE的O(h²)局部误差。未把逆映射或误差结论作为资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；adjointEulerRelation对任意n/l、质量、F、约束、h和输入输出相点及三个辅助向量定义三式，并要求输出位置约束、输出隐藏约束。定义自身未要求输入在余切域，使用时另给；这不等同自动存在求解。inverseRelation在h≠0且两端余切约束下，对存在乘子的伴随关系与反向步长−h的正向关系给双向等价，质量无需正性，因为这里只作代数改写；乘子交换并缩放即可。该关系等价不声称局部分支唯一或逆映射存在。adjointEulerLocalOrder另设正质量、C⁴ U/g、初点Gram非零、C³ E/A/Φ、C²乘子、零步初值及μE(0)=μR(0)=0，配真实步关系和ODE，结论Euler与伴随各自局部O(h²)，数学合理且符合[EXTRA]所限定局部精度范围。未提供全局一阶或严格非二阶下界，不将局部结论冒称这些更强命题。

### 7. 状态与证明位置

incomplete；`MD.Ch04.adjointEulerRelation`：定义；`MD.Ch04.adjointEuler_inverseRelation`：未证（缺大型理论）；`MD.Ch04.adjointEulerLocalOrder`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2117)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-ConstrainedComposition · unnumbered_claim · 印刷p.163 / PDFp.185

### 2. 原文陈述

> By composing the maps $`G_{h/2}`$ and $`G^*_{h/2}`$ we get a second order symplectic method. In the sense that it is defined by first order maps which reduce to the Symplectic Euler method and its adjoint, this is an analogous scheme to the Störmer-Verlet method. Interestingly, this method is not equivalent to SHAKE or RATTLE.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constrainedComposition :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (E A : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (pE pA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rhoE μE rhoA μA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (η : ℝ), 0 < η →
    (∀ j, ContDiff ℝ 3 (g j)) → ContDiff ℝ 3 U → (∀ i, 0 < m i) →
    (∀ q ∈ MolecularDynamics.Chapter04Review.constraintSet g, LinearIndependent ℝ (fun j ↦ textbookConstraintGradient (g j) q)) →
    (∀ h ∈ Ioo (-η) η, ContDiff ℝ 1 (E h) ∧ ContDiff ℝ 1 (A h) ∧
      ContDiff ℝ 1 (pE h) ∧ ContDiff ℝ 1 (pA h) ∧ ContDiff ℝ 1 (rhoE h) ∧
      ContDiff ℝ 1 (μE h) ∧ ContDiff ℝ 1 (rhoA h) ∧ ContDiff ℝ 1 (μA h)) →
    (∀ h ∈ Ioo (-η) η, ∀ z, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (μE h z) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h z) (pA h z) (rhoA h z) (μA h z)) →
    ∀ h ∈ Ioo (-η) η, MolecularDynamics.Chapter04Review.restrictedSymplectic m g (A (h/2) ∘ E (h/2)) := by
  sorry

theorem constrainedComposition_circleExample :
    let m : Fin 2 → ℝ := fun _ ↦ 1
    let g : Fin 1 → (Fin 2 → ℝ) → ℝ := fun _ q ↦ (q 0)^2+(q 1)^2-1
    let F : (Fin 2 → ℝ) → Fin 2 → ℝ := fun _ ↦ 0
    let z : MolecularDynamics.Chapter04Review.Z 2 := (![1,0],![0,1])
    let e : MolecularDynamics.Chapter04Review.Z 2 :=
      (![Real.sqrt 15/4,1/4],![-1/4,Real.sqrt 15/4])
    let a : MolecularDynamics.Chapter04Review.Z 2 :=
      (![7/8,Real.sqrt 15/8],![-Real.sqrt 15/8,7/8])
    let r : MolecularDynamics.Chapter04Review.Z 2 :=
      (![Real.sqrt 3/2,1/2],![-1/2,Real.sqrt 3/2])
    ∃ pE pA pR pS ρE μE ρA μA ρR μR ρS ρSnew pSout,
      MolecularDynamics.Chapter04Review.projectedEulerRelation m F g (1/4) z e pE ρE μE ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m F g (1/4) e a pA ρA μA ∧
      MolecularDynamics.Chapter04Review.rattleRelation m F g (1/2) z r pR ρR μR ∧
      MolecularDynamics.Chapter04Review.shakeRelation m F g (1/2) z (r.1,pSout) pS ρS ρSnew ∧
      a.1 ≠ r.1 := by
  sorry

theorem constrainedComposition_noConstraints (n : ℕ) (m : Fin n → ℝ)
    (F : MolecularDynamics.Chapter04Review.Q n → MolecularDynamics.Chapter04Review.Q n)
    (h : ℝ) (z out : MolecularDynamics.Chapter04Review.Z n) :
    ((∃ pbar rho μ, MolecularDynamics.Chapter04Review.projectedEulerRelation m F
      (Fin.elim0 : Fin 0 → MolecularDynamics.Chapter04Review.Q n → ℝ) h z out pbar rho μ) ↔
      out=(z.1+h • MolecularDynamics.Chapter04Review.invMass m (z.2+h • F z.1),z.2+h • F z.1)) ∧
    ((∃ half rho μ, MolecularDynamics.Chapter04Review.adjointEulerRelation m F
      (Fin.elim0 : Fin 0 → MolecularDynamics.Chapter04Review.Q n → ℝ) h z out half rho μ) ↔
      out=(z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2,
        z.2+h • F (z.1+h • MolecularDynamics.Chapter04Review.invMass m z.2))) := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 小h光滑分支上的组合辛性、无约束退化及非等价实例；二阶精度子句由MD-4.3.5.1-ConstrainedCompositionOrder承担，原文保留。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedComposition`；`MD.Ch04.constrainedComposition_circleExample`；`MD.Ch04.constrainedComposition_noConstraints` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | U/g为C³，正质量及独立约束；小步长窗口内C¹空间分支资格显式。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 分支关系限制小h窗口、C¹空间资格及独立约束，保留辛性；补无约束Euler/伴随退化及单位圆自由运动中与RATTLE/SHAKE位置不同的固定步长、存在乘子的非等价位置实例。二阶精度明确由ConstrainedCompositionOrder承担；C³是本签名实际充分资格。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 完整局部误差阶声明已核对，C³与真实关系/小步长资格齐；声明尚未证明；circleExample不含唯一性。 | [EXTRA] |

[EXTRA] U/g为C³，正质量及独立约束；小步长窗口内C¹空间分支资格显式。；[EXTRA] 分支关系限制小h窗口、C¹空间资格及独立约束，保留辛性；补无约束Euler/伴随退化及单位圆自由运动中与RATTLE/SHAKE位置不同的固定步长、存在乘子的非等价位置实例。二阶精度明确由ConstrainedCompositionOrder承担；C³是本签名实际充分资格。；[EXTRA] 完整局部误差阶声明已核对，C³与真实关系/小步长资格齐；声明尚未证明；circleExample不含唯一性。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：本地核验通过（网站因摘录缺失未判）。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；主定理量化n/l、正质量、C³ U/g、约束集上梯度独立以及η>0；E/A和所有辅助输出在每个|h|<η上对空间为C¹；对所有余切初点满足真实正向/伴随关系。结论仅组合在每个|h|<η上受限辛；h/2仍在窗口内，E输出在余切域，可再次应用A，故几何结论合理。这里无需步长光滑性，也没有步长光滑性，故不能由该签名附带得出二阶或对称性。circleExample：自由单位圆、m=1、初点((1,0),(0,1))，正向1/4得到e，伴随1/4得到a，RATTLE1/2得到r，SHAKE1/2存在同r位置的输出；a位置不同，确实给一组非等价候选更新。noConstraints准确退化为kick-drift Euler和drift-kick伴随，对任意质量/F/h成立，未声称任意F下辛。完整原文二阶子句仍须外部委托声明，按本任务材料不能核验；实例单值近分支资格也未覆盖。

### 7. 状态与证明位置

incomplete；`MD.Ch04.constrainedComposition`：未证（缺大型理论）；`MD.Ch04.constrainedComposition_circleExample`：未证（缺大型理论）；`MD.Ch04.constrainedComposition_noConstraints`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2153)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

## 1. MD-4.3.5.1-ConstrainedCompositionOrder · unnumbered_claim · 印刷p.163 / PDFp.185

### 2. 原文陈述

> By composing the maps $`G_{h/2}`$ and $`G^*_{h/2}`$ we get a second order symplectic method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem constrainedCompositionOrder :
  ∀ n l (m : Fin n → ℝ) (U : MolecularDynamics.Chapter04Review.Q n → ℝ) (g : Fin l → MolecularDynamics.Chapter04Review.Q n → ℝ)
    (E A : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Z n) (pE pA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q n) (rhoE muE rhoA muA : ℝ → MolecularDynamics.Chapter04Review.Z n → MolecularDynamics.Chapter04Review.Q l) (η : ℝ), 0 < η →
    (∀ i, 0 < m i) → ContDiff ℝ 4 U → (∀ j, ContDiff ℝ 4 (g j)) →
    ContDiff ℝ 3 (Function.uncurry E) → ContDiff ℝ 3 (Function.uncurry A) →
    (∀ z, E 0 z=z ∧ A 0 z=z ∧ muE 0 z=0) →
    (∀ h ∈ Ioo (-η) η, ∀ z, z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g →
      MolecularDynamics.Chapter04Review.projectedEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (E h z) (pE h z) (rhoE h z) (muE h z) ∧
      MolecularDynamics.Chapter04Review.adjointEulerRelation m (fun q => -MolecularDynamics.Chapter04Review.grad U q) g h z (A h z) (pA h z) (rhoA h z) (muA h z)) →
    ∀ z ∈ MolecularDynamics.Chapter04Review.cotangentSet m g, (textbookConstraintGram m g z.1).det ≠ 0 →
    ∀ Φ : ℝ → MolecularDynamics.Chapter04Review.Z n, ContDiff ℝ 3 Φ → Φ 0=z →
      (∃ d > 0, ∀ t ∈ Ioo (-d) d, HasDerivAt Φ (textbookConstrainedPhaseVectorField m g U (Φ t)) t) →
      ∃ C > 0, ∃ d > 0, ∀ h ∈ Ioo 0 d, ‖A (h/2) (E (h/2) z)-Φ h‖ ≤ C*h^3 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 组合方法O(h³)局部误差（二阶精度）子句；辛性、退化及非等价实例由MD-4.3.5.1-ConstrainedComposition承担；不冒充全局二阶收敛。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch04.constrainedCompositionOrder` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 真实光滑隐式分支、正质量、C⁴势/约束和一致时间区间；实际局部O(h³)精度。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 本条限定二阶局部精度，辛性在ConstrainedComposition同域对应的空间光滑分支中单列；将关系限制实际小h窗口，避免强迫全步长隐式分支存在。 | [EXTRA] |

[EXTRA] 真实光滑隐式分支、正质量、C⁴势/约束和一致时间区间；实际局部O(h³)精度。；[EXTRA] 本条限定二阶局部精度，辛性在ConstrainedComposition同域对应的空间光滑分支中单列；将关系限制实际小h窗口，避免强迫全步长隐式分支存在。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；量词覆盖任意有限维n、约束数l、正质量、C⁴势和约束，以及在同一对称步长窗口内满足两种离散关系的C³相空间映射E、A。初值恒等且muE在零步长为零；起点属于余切约束集且Gram行列式非零。对任意同初值C³精确局部ODE轨道，结论是正小步长局部误差≤C h³；不是全局误差估计。辛性不在本签名中，已由statement\_scope明确分出，外部ConstrainedComposition未在本任务提供，不能据本条认证它。projectedEulerRelation末次修正未乘h，是将原页乘子hμ吸收到muE中的参数化；muE 0 z=0与该参数化相容。

### 7. 状态与证明位置

incomplete；`MD.Ch04.constrainedCompositionOrder`：未证（缺大型理论）。
位置：[Blueprint/Ch04.lean](../../../../Blueprint/Ch04.lean#L2201)；逐声明核验：blueprint/closeout24/ch04/full-run.log。

