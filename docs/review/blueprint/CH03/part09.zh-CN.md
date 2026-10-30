[上一部分](part08.zh-CN.md) / [目录](../../CH03_BLUEPRINT.zh-CN.md) / [下一部分](part10.zh-CN.md)

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

