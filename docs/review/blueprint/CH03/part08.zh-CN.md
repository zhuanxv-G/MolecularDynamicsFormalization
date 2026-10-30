[上一部分](part07.zh-CN.md) / [目录](../../CH03_BLUEPRINT.zh-CN.md) / [下一部分](part09.zh-CN.md)

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

## 1. MD-3.6.3-SymplecticSpectrum · unnumbered_claim · 印刷p.131 / PDFp.153

### 2. 原文陈述

> The flow map is

$$
\mathcal F_t(z)=\mathrm e^{tJA}z
$$


> and the exponential matrix will inherit a related structure within the spectrum: $`\lambda`$ an eigenvalue of $`\exp(tJA)`$ implies that $`\overline\lambda`$, $`1/\lambda`$ and $`1/\overline\lambda`$ are all eigenvalues of $`\exp(tJA)`$. This eigenvalue structure is generic for linear symplectic maps in general.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2165)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.3-ReversibleSpectrum · unnumbered_claim · 印刷p.131 / PDFp.153

### 2. 原文陈述

> Suppose now we have a linear time-reversible map $`\phi(z)=Tz`$, then

$$
T^{-1}=RTR.
$$


> Given an eigenvalue, eigenvector pair $`(\lambda,u)`$ of $`T`$, let $`u=Rv`$, so that $`Ru=R^2v=v`$, then

$$
T^{-1}v=RTRv=RTu=\lambda Ru=\lambda v.
$$


> Thus $`\lambda`$ is an eigenvalue of $`T^{-1}`$ which, in turn, implies that $`1/\lambda`$ is an eigenvalue of $`T`$. The matrix being real implies that the conjugates of $`\lambda`$ and $`1/\lambda`$ are also eigenvalues, thus we have the same eigenvalue quadruplets as for a linear symplectic map.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2186)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.6.3-ConjugateIterates · unnumbered_claim · 印刷p.131–132 / PDFp.153–154

### 2. 原文陈述

> Recall that a pair of maps $`\Phi`$ and $`\Psi`$ are said to be conjugate if there is a homomorphism $`\chi`$ such that

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2197)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2222)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2231)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2255)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7-HardCoreDomain · definition · 印刷p.132 / PDFp.154

### 2. 原文陈述

> We assume, as usual a Hamiltonian $`H=p^TM^{-1}p/2+U(q)`$ but we add the inequality constraint $`\|q_i-q_j\|\ge\sigma_i+\sigma_j`$ where $`\sigma_i`$, $`i=1,\ldots,N`$ is a core radius. The condition $`\|q_i-q_j\|=\sigma_i+\sigma_j`$, some $`i,j`$ defines the constraint surface.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2276)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7-ElasticReflection · definition · 印刷p.132 / PDFp.154

### 2. 原文陈述

> When the particles are not touching, they move along Newtonian paths defined by the standard equations of motion. At impact, they exchange momentum and energy according to the rules of elastic collision. Specifically, at the point of contact, the momentum vectors of the two spheres are adjusted according to the rule:

$$
p:=p+\alpha u_\perp
$$


> where $`u_\perp`$ is normal to the constraint surface and $`\alpha`$ is a parameter chosen to maintain the conservation of energy.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2292)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7-ElasticEnergy · unnumbered_claim · 印刷p.132 / PDFp.154

### 2. 原文陈述

> where $`u_\perp`$ is normal to the constraint surface and $`\alpha`$ is a parameter chosen to maintain the conservation of energy.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2296)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7-CollisionComposition · definition · 印刷p.132–133 / PDFp.154–155

### 2. 原文陈述

> Let $`\mathcal R_c`$ denote the action of the collision operator on the vector of positions and momenta. Then we can write the evolution formally as

$$
\mathcal F_\tau^{\mathrm{h.s.}}(q,p)=\mathcal G_{\Delta\tau_r}\circ\mathcal R_c\circ\mathcal G_{\Delta\tau_{r-1}}\cdots\circ\mathcal R_c\circ\mathcal G_{\Delta\tau_0}
$$


> where $`\Delta\tau_1,\Delta\tau_2,\ldots,\Delta\tau_{r-1}`$ are the times between collisions, $`\Delta\tau_0`$ is the time until the first collision, and $`\Delta\tau_r`$ is the time between the last collision and $`\tau`$. Here $`\mathcal G_t`$ is the flow map of the smooth system (Hamiltonian $`H`$).

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2336)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

