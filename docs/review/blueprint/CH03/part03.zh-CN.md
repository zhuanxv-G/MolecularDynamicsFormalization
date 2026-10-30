[上一部分](part02.zh-CN.md) / [目录](../../CH03_BLUEPRINT.zh-CN.md) / [下一部分](part04.zh-CN.md)

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

