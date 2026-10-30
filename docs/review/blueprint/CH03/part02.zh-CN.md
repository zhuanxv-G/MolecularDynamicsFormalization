[上一部分](part01.zh-CN.md) / [目录](../../CH03_BLUEPRINT.zh-CN.md) / [下一部分](part03.zh-CN.md)

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L640)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-VerletModifiedHamiltonian · definition · 印刷p.107 / PDFp.129

### 2. 原文陈述

> In general for the Verlet method applied to Hamiltonians of the form $`H(q,p)=T(p)+U(q)`$, the BCH lemma gives

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L653)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-VerletModifiedMatching · unnumbered_claim · 印刷p.107 / PDFp.129

### 2. 原文陈述

> In general for the Verlet method applied to Hamiltonians of the form $`H(q,p)=T(p)+U(q)`$, the BCH lemma gives

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L678)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-ModifiedEven · unnumbered_claim · 印刷p.107–108 / PDFp.129–130

### 2. 原文陈述

> The extra power of $`h`$ in the leading perturbation reflects the fact that this method is 2nd order accurate, rather than first order, as Symplectic Euler. Note that only even order terms $`(h^2,h^4,\ldots)`$ appear in the perturbative expansion; this is a consequence of the symmetry of the method.
> Setting $`s=-t`$, the left hand side of (3.4) collapses to the identity. Hence the surviving even-powered terms in the expansion on the right hand side of (3.5) must be zero. If the even order terms vanish, then the effect of composing linear operators symmetrically is to keep only odd order terms in the exponent, giving the symmetric BCH formula

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L727)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-Strang · definition · 印刷p.108 / PDFp.130

### 2. 原文陈述

> For Hamiltonians $`X`$ and $`Y`$, consider symmetrizing a composition of exponentials (a Strang splitting), such that

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L749)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-DifferentLogsCommute · (3.4)–(3.5) · 印刷p.108 / PDFp.130

### 2. 原文陈述

> Multiplying by the same expansion using a different time step $`s`$, we have

$$
\exp(\tfrac s2X)\exp(sY)\exp(\tfrac s2X)\exp(\tfrac t2X)\exp(tY)\exp(\tfrac t2X)=\exp(sZ_s)\exp(tZ_t).\tag{3.4}
$$


> But we know that $`Z_t`$ commutes with $`Z_s`$, giving

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L775)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.2-StrangInverse · unnumbered_claim · 印刷p.108 / PDFp.130

### 2. 原文陈述

> Setting $`s=-t`$, the left hand side of (3.4) collapses to the identity.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L793)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L799)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.3-YoshidaComposition · definition · 印刷p.109 / PDFp.131

### 2. 原文陈述

> We now consider iterating this scheme three times, first using a step of $`\tau_0h`$, followed by a step of $`\tau_1h`$, and finally another step with stepsize $`\tau_0h`$ (where $`\tau_0h+\tau_1h+\tau_0h=h`$). The overall effect on the system is given by a product of exponentials, as

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L821)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.3-YoshidaCoefficients · definition · 印刷p.109 / PDFp.131

### 2. 原文陈述

> We have free reign over constants $`\tau_0`$ and $`\tau_1`$ as long as $`2\tau_0+\tau_1=1`$. Hence we have an opportunity to annihilate the perturbation operator at order $`h^{2s}`$ by choosing $`2\tau_0^{2s+1}+\tau_1^{2s+1}=0`$ as well. Solving simultaneously, there exists a unique real solution

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L824)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.3-YoshidaCancellation · unnumbered_claim · 印刷p.109 / PDFp.131

### 2. 原文陈述

> We have free reign over constants $`\tau_0`$ and $`\tau_1`$ as long as $`2\tau_0+\tau_1=1`$. Hence we have an opportunity to annihilate the perturbation operator at order $`h^{2s}`$ by choosing $`2\tau_0^{2s+1}+\tau_1^{2s+1}=0`$ as well.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L828)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L856)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.3-YoshidaRaiseOrder · unnumbered_claim · 印刷p.109 / PDFp.131

### 2. 原文陈述

> giving us a scheme of order $`2s+2`$. We can then proceed recursively, as this new order $`2s+2`$ scheme can be composed similarly to wipe out successive higher order terms.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L897)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.3-Yoshida4 · Example 3.1 / (3.8) · 印刷p.109–110 / PDFp.131–132

### 2. 原文陈述

> Example 3.1 Consider using velocity Verlet as the base second-order method to build a Yoshida fourth-order method from. As the scheme is second-order, we have $`s=1`$, and hence

$$
\tau_0=\frac1{2-\sqrt[3]2},\qquad\tau_1=-\frac{\sqrt[3]2}{2-\sqrt[3]2}.
$$


> The overall scheme is then three iterations of velocity Verlet, using stepsizes $`\tau_0h`$, $`\tau_1h`$ and $`\tau_0h`$ respectively. We write this with subindices $`\alpha,\beta`$ to indicate the intermediate stages.
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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L914)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L920)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L926)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L931)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L937)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.4-TakahashiShadow · definition · 印刷p.112 / PDFp.134

### 2. 原文陈述

> This is certainly not a coincidence. If we replace the potential $`U`$ by $`\widetilde U`$ in the Verlet expansion, we have

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L947)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L962)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.4-ProcessorEnergyPrinted · unnumbered_claim · 印刷p.113 / PDFp.135

### 2. 原文陈述

> and inserting these into $`H`$ yields, after expanding in a Taylor series:

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L969)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.3.4-TakahashiEffectiveOrder · unnumbered_claim · 印刷p.113 / PDFp.135

### 2. 原文陈述

> Since $`\widetilde H_h`$ is assumed to be constant along the numerical solution, the coordinate transformations have the result of giving an effective order of four for the energy. It turns out that the Takahashi-Imada method is, more generally, an effective 4th order scheme, i.e. for arbitrary quantities, not just the energy [166].

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
网站原返回（对应其审校版本）：FAIL；所有相关定义均已找到并展开：solution 要求γ在[0,τ]每点满足实际HasDerivWithinAt；mechanicalField(m,F)(q,p)=(M⁻¹p,F(q))；verlet 的q新值为q+hM⁻¹p+h²/2 M⁻¹F(q)，p新值为p+h/2(F(q)+F(q新))，此处F=−grad(takahashiPotential m U h)。textbookProcessedMethod χ B h=(χ h)⁻¹∘B\_h∘χ h，oneStepIterate=(G\_h)^[k]，oneStepMaxError=max_{0≤k≤ν}‖G\_h^[k](../../γ(0))−γ(kh)‖。所以它确实控制有限时间的全部网格轨迹误差，不只是能量或一步误差。量词∃χ在∀γ,τ之前要求同一族全空间homeomorphism服务所有轨迹，并且χ完全没有近恒等、h光滑性、式(3.9)的二阶系数或局部作用域要求。PDF134–135所说的是给定坐标变换带来的有效阶；该签名无法识别那个处理器，并额外要求全空间双向连续的精确逆。全局homeomorphism是存在结论的强化，并非一个已给出的额外前提，不能仅标[EXTRA]就证明合理。正质量、全域C∞、连续有限时间解是合理的充分正则化；全域正则性比局部需要强。给定这些确切缺失，判FAIL，无须以定义缺失或导师判断为由判NEEDS\_HUMAN。χ⁻¹∘G∘χ本身不是方向错误：若P是原文从原坐标到带波浪号坐标的后处理，则应取χ=P⁻¹，得到P∘G∘P⁻¹。原文关于能量的解释显式以影子能量沿数值解恒定为假定，该签名也未单列这项条件式能量结论。声明含sorry；未声称已否证存在任意全局χ的四阶定理。

### 7. 状态与证明位置

incomplete；`MD.Ch03.takahashiEffectiveOrder`：未证（原书疑误不证）；`MD.Ch03.takahashiEffectiveOrder_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1002)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-ModifiedField · definition · 印刷p.113 / PDFp.135

### 2. 原文陈述

> Assume a smooth differential equation system

$$
\frac{\mathrm d\boldsymbol z}{\mathrm dt}=f(\boldsymbol z)
$$


> with flow map $`\mathcal F_t`$, and a one-step method $`\mathcal G_h`$. We obtain, typically by matching of terms from Taylor expansion, a “modified differential equation” as a series expansion

$$
\frac{\mathrm d\boldsymbol z}{\mathrm dt}=\widetilde f_h(\boldsymbol z)=f(\boldsymbol z)+h^rf_r(\boldsymbol z)+h^{r+1}f_{r+1}(\boldsymbol z)+\cdots,
$$


> where $`r`$ is the classical order of accuracy of the method.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1030)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-LeadingModifiedField · unnumbered_claim · 印刷p.113 / PDFp.135

### 2. 原文陈述

> In fact, it is straightforward to show that if numerical method satisfies

$$
\mathcal G_h(\boldsymbol z)-\mathcal F_h(\boldsymbol z)=h^{r+1}\Gamma_{r+1}(\boldsymbol z)+O(h^{r+2}),
$$


> i.e. $`h^{r+1}\Gamma_{r+1}`$ is the leading term in the local error expansion, then we have

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1037)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1049)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

## 1. MD-3.4-TruncationSmooth · unnumbered_claim · 印刷p.114 / PDFp.136

### 2. 原文陈述

> Suppose the Hamiltonian $`H`$ and modified Hamiltonian $`\bar H_k`$ are smooth functions globally defined on a convex, compact subset $`\mathcal B`$ of $`\mathbb R^{2N_c}`$.

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
位置：[Blueprint/Ch03.lean](../../../../Blueprint/Ch03.lean#L1058)；逐声明核验：blueprint/closeout24/ch03/full-run.log。

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

