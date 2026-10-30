[上一部分](part03.zh-CN.md) / [目录](../../CH03_BLUEPRINT.zh-CN.md) / [下一部分](part05.zh-CN.md)

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

