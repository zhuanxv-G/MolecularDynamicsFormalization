[上一部分](part03.zh-CN.md) / [目录](../../CH03_BLUEPRINT.zh-CN.md) / 下一部分：无

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2353)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-HardCorePotential · definition · 印刷p.133 / PDFp.155

### 2. 原文陈述

> Splitting methods are suggested by considering a formal hard-sphere Hamiltonian

$$
H_{\mathrm{h.s.}}=p^TM^{-1}p/2+U(q)+U_{\mathrm{h.s.}},
$$


> where $`U_{\mathrm{h.s.}}`$ is assumed to be infinite for overlapping configurations (some $`\|q_i-q_j\|\le\sigma_i+\sigma_j`$) and zero otherwise.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2376)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-PrimitiveSplitting · definition · 印刷p.133 / PDFp.155

### 2. 原文陈述

> One approach is to consider the splitting $`H=H_{\mathrm{free}}+U`$, evolving $`H_{\mathrm{free}}`$ for fixed intervals punctuated by impulses derived from the smooth potential $`U`$. In [40, 184] this algorithm is termed the “Primitive Splitting Algorithm” and can be described by the three steps:

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2396)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-PrimitiveOrder · unnumbered_claim · 印刷p.133–134 / PDFp.155–156

### 2. 原文陈述

> Even with this symmetric form (“kick”, “drift”, “kick”) where “drift” now involves the solution of the system $`H_{\mathrm{free}}`$, it was shown in [184] that energy accumulates rapidly. Assuming a finite number of collisions on a fixed interval, the error behaves as $`O(h)`$. In long simulations the energy error grows without bound.
> In general, because an error of size $`O(h)`$ occurs in each collision and there are a finite number of collisions in a fixed time interval, the total error is also $`O(h)`$, i.e. first order.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2404)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-ObstacleReflection · definition · 印刷p.134 / PDFp.156

### 2. 原文陈述

> The coefficient $`\alpha`$ is chosen so that the kinetic energy is conserved through collision, thus

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2441)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-PrimitiveDefect · unnumbered_claim · 印刷p.134 / PDFp.156

### 2. 原文陈述

> We next calculate the change in energy in a single step by inserting $`Q`$ and $`P`$ into the Hamiltonian and expanding around the point of collision $`q_c`$, obtaining

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2447)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.1-CollisionDefectZero · unnumbered_claim · 印刷p.134 / PDFp.156

### 2. 原文陈述

> • the collision occurs at the middle of the timestep, $`\tau_c=h/2`$,
> • the directional derivative of $`U`$ along the collision vector $`(u_\perp=q_c)`$ vanishes, or
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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2464)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2471)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.2-CollisionQuadraticPath · (3.18) · 印刷p.135 / PDFp.157

### 2. 原文陈述

> The idea is to make use of the quadratic

$$
Q(t)=q+tM^{-1}p-\frac{t^2}{2}M^{-1}\nabla U(q)\tag{3.18}
$$


> which represents the position vector obtained from a Verlet step of size $`t`$. Note that this defines quadratic paths for all particles in the system.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2507)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2511)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2515)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.2-CollisionalVerletRelation · definition · 印刷p.135 / PDFp.157

### 2. 原文陈述

> Collisional Verlet Algorithm (CVA) [Single Step]
> [computes $`h`$ (the timestep) and $`(Q,P)`$ given a starting point $`(q,p)`$]
> Calculate $`\tau_c`$ the time of next collision from the Verlet paths (quadratics) of (3.18) using collision conditions (3.19).
> If $`\tau_c\lt h_{\max}`$, then

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2527)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.2-CollisionalVerletOrder · unnumbered_claim · 印刷p.135 / PDFp.157

### 2. 原文陈述

> A step can then be taken to the first point of subsequent collision, with positions updated using the quadratic and momenta adjusted according to the Verlet map combined with $`R_c`$. In this way, all steps taken are Verlet steps so the order of accuracy is two. Effectively, this is a Verlet method with variable timestep chosen to match collision times.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2586)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.3-PairForceDecoupling · definition · 印刷p.136 / PDFp.158

### 2. 原文陈述

> This can be achieved in systems of spheres with pair potentials $`\varphi_{ij}`$ only by writing $`\varphi_{ij}=\alpha_{ij}+\beta_{ij}`$ where the derivative of the second term is chosen to vanish at the point of contact between the spheres, i.e. $`\alpha'_{ij}(\sigma_i+\sigma_j)=0`$.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2639)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.3-DecoupledOrder · unnumbered_claim · 印刷p.136 / PDFp.158

### 2. 原文陈述

> The idea is to exploit the observation that impulsive forces (“kicks”) can be supplied without reducing the order of accuracy as long as these have a vanishing component in the direction of the collision vector $`u_\perp`$, that is if $`F_\perp=-\nabla U(q_c)\cdot u_\perp=0`$.
> If this decomposition is used, then it is possible to build a 2nd order accurate hybrid method that uses only the first part $`\alpha`$ to define the quadratic Verlet paths for the collision detection scheme, whereas $`\beta`$ is introduced as a standard “kick” at collision points.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2652)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.7.3-ModifiedCollisionProjection · definition · 印刷p.136 / PDFp.158

### 2. 原文陈述

> In particular, one may use the backward error analysis to obtain a modified Hamiltonian $`\widetilde H_h`$ corresponding to the Verlet method with stepsize $`h`$, then to project during collisions not onto the energy surface, but onto the modified energy surface, so that

$$
\widetilde H_h\equiv\mathrm{const}.
$$


> (In practice, a low order approximation of $`\widetilde H_h`$ is used, such as the truncation to terms of order four or six in the stepsize.)

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2690)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L2699)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

