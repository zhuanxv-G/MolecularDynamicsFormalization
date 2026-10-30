[上一部分](part06.zh-CN.md) / [目录](../../CH02_BLUEPRINT.zh-CN.md) / [下一部分](part08.zh-CN.md)

## 1. MD-2.4.1-SplittingLocal · unnumbered_claim · 印刷p.83 / PDFp.105

### 2. 原文陈述

> For this to be a first order method, we need at least $`\|\mathcal G_h(\boldsymbol u)-\mathcal F_h(\boldsymbol u)\|\le C(\boldsymbol u)h^2`$.

### 3. 原文证明

> Expand $`\mathcal F_h(\boldsymbol u)`$ in a Taylor series:

$$
\mathcal F_h(\boldsymbol u)=\boldsymbol u+hJ\nabla H+\mathcal O(h^2)=\boldsymbol u+h(J\nabla H_1+J\nabla H_2)+\mathcal O(h^2).\tag{2.24}
$$


> On the other hand,

$$
\mathcal F_h^1(\boldsymbol u)=\boldsymbol u+hJ\nabla H_1(\boldsymbol u)+\mathcal O(h^2),\qquad\mathcal F_h^2(\boldsymbol u)=\boldsymbol u+hJ\nabla H_2(\boldsymbol u)+\mathcal O(h^2).
$$


> Composing the maps we have

$$
\mathcal F_h^1\circ\mathcal F_h^2(\boldsymbol u)=\boldsymbol u+hJ\nabla H_2(\boldsymbol u)+hJ\nabla H_1(\boldsymbol u+hJ\nabla H_2(\boldsymbol u))+\mathcal O(h^2).
$$


> Assuming $`H_1`$ is $`C^2`$, we have

$$
\mathcal F_h^1\circ\mathcal F_h^2(\boldsymbol u)=\boldsymbol u+h(J\nabla H_2(\boldsymbol u)+J\nabla H_1(\boldsymbol u))+\mathcal O(h^2),
$$


> which agrees with the expansion (2.24) of the flow map through the terms of first order. Thus the splitting method does indeed provide a second order local approximation of the flow map.
原书计算按原页转录。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem splittingLocal {Nc : ℕ}
    (D : Set (SymplecticCoordinates Nc)) (hD : IsOpen D)
    (H₁ H₂ : SymplecticCoordinates Nc → ℝ)
    (hH₁ : ContDiffOn ℝ 2 H₁ D) (hH₂ : ContDiffOn ℝ 2 H₂ D)
    (F F₁ F₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (u : SymplecticCoordinates Nc) {τ : ℝ} (hτ : 0 ≤ τ)
    (hFD : ∀ t ∈ Icc 0 τ, F t u ∈ D)
    (hF₂D : ∀ t ∈ Icc 0 τ, F₂ t u ∈ D)
    (hF₁D : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, F₁ t (F₂ s u) ∈ D)
    (hF : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F v u)
      (textbookHamiltonianVectorField (fun x => H₁ x + H₂ x) (F t u)) (Icc 0 τ) t)
    (hF₂ : ∀ t ∈ Icc 0 τ, HasDerivWithinAt (fun v => F₂ v u)
      (textbookHamiltonianVectorField H₂ (F₂ t u)) (Icc 0 τ) t)
    (hF₁ : ∀ s ∈ Icc 0 τ, ∀ t ∈ Icc 0 τ, HasDerivWithinAt
      (fun v => F₁ v (F₂ s u)) (textbookHamiltonianVectorField H₁ (F₁ t (F₂ s u))) (Icc 0 τ) t)
    (hc : ContinuousOn (fun p : ℝ × ℝ => F₁ p.2 (F₂ p.1 u)) (Icc 0 τ ×ˢ Icc 0 τ))
    (hinit : F 0 u = u) (hinit₂ : F₂ 0 u = u)
    (hinit₁ : ∀ s ∈ Icc 0 τ, F₁ 0 (F₂ s u) = F₂ s u) :
    ∃ C : ℝ, 0 < C ∧
      (∀ h ∈ Icc 0 τ, ‖F₁ h (F₂ h u) - F h u‖ ≤ C * h ^ 2) ∧
      (0 < τ → Asymptotics.IsBigO (𝓝[>] (0 : ℝ))
        (fun h => F₁ h (F₂ h u) - F h u) (fun h : ℝ => h ^ 2)) := by
  exact MolecularDynamics.exists_hamiltonian_splitting_localError_bound
    D hD H₁ H₂ hH₁ hH₂ F F₁ F₂ u hτ hFD hF₂D hF₁D hF hF₂ hF₁ hc hinit hinit₂ hinit₁
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.splittingLocal` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际H及两个子Hamilton局部ODE、初值及留开放域；H₁,H₂ C²，组合在紧时间矩形连续；没有假设待证局部误差。 | [EXTRA] |

[EXTRA] 实际H及两个子Hamilton局部ODE、初值及留开放域；H₁,H₂ C²，组合在紧时间矩形连续；没有假设待证局部误差。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Nc、开放域D，H₁,H₂在D上C²；u任意但由F 0 u=u与留域条件保证u∈D。τ≥0，F在[0,τ]上满足H₁+H₂的ODE，F₂满足H₂，F₁在F₂(s,u)出发的整矩形轨道满足H₁；初值、留域、矩形联合连续条件齐备。结论存在C>0使所有0≤h≤τ的实际复合与总流差≤C h²，τ>0还给右侧h→0的O(h²)。常数可依赖u及固定输入，未假设待证误差。τ=0时只需初值相等，BigO有τ>0前提，未把退化区间当作局部渐近结论。C²双势、留域及连续性均为充分[EXTRA]；原书second order local指O(h²)，不误读成全局二阶。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.splittingLocal`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1325)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-KineticFlow · Example 2.4 · 印刷p.83 / PDFp.105

### 2. 原文陈述

> Let

$$
H_1(\boldsymbol q,\boldsymbol p)=\boldsymbol p^TM^{-1}\boldsymbol p/2,\qquad H_2(\boldsymbol q,\boldsymbol p)=U(\boldsymbol q),
$$


> then a splitting method for $`H=H_1+H_2`$ may be obtained by determining the flow maps for each of the two parts. For $`H_1`$ we have the differential equations

$$
\dot{\boldsymbol q}=M^{-1}\boldsymbol p,\qquad\dot{\boldsymbol p}=\boldsymbol0.
$$


> The second equation tells us that $`\boldsymbol p`$ is constant, so it is fixed at its initial value, whereas the first equation says that $`\boldsymbol q`$ evolves on a linear path, hence its flow map is

$$
\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol p,\qquad\boldsymbol P=\boldsymbol p.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
noncomputable def bp_kineticFlow {Nc : ℕ} (m : Fin Nc → ℝ) (h : ℝ)
    (z : SymplecticCoordinates Nc) : SymplecticCoordinates Nc :=
  Sum.elim (fun i => z (Sum.inl i) + h * (m i)⁻¹ * z (Sum.inr i))
    (fun i => z (Sum.inr i))

private noncomputable def momentumKickDerivative {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc) :
    SymplecticCoordinates Nc →L[ℝ] SymplecticCoordinates Nc :=
  ContinuousLinearMap.pi (Sum.elim
    (fun i => ContinuousLinearMap.proj (Sum.inl i))
    (fun i => ContinuousLinearMap.proj (Sum.inr i) + h •
      (ContinuousLinearMap.proj i).comp
        ((fderiv ℝ F (textbookPositionProjection Nc z)).comp
          (textbookPositionProjection Nc))))

private theorem momentumKick_hasFDerivAt {Nc : ℕ}
    (F : (Fin Nc → ℝ) → (Fin Nc → ℝ)) (h : ℝ) (z : SymplecticCoordinates Nc)
    (hF : ContDiff ℝ 1 F) :
    HasFDerivAt (textbookMomentumKick F h) (momentumKickDerivative F h z) z := by
  apply hasFDerivAt_pi.mpr
  intro i
  rcases i with i | i
  · exact hasFDerivAt_apply (Sum.inl i) z
  · have hf := ((hF.differentiable_one (textbookPositionProjection Nc z)).hasFDerivAt.comp z
      (textbookPositionProjection Nc).hasFDerivAt)
    have hi := (hasFDerivAt_apply i (F (textbookPositionProjection Nc z))).comp z hf
    simpa only [textbookMomentumKick, Sum.elim_inr, Pi.add_apply, Pi.smul_apply,
      Function.comp_apply, smul_eq_mul] using
      (hasFDerivAt_apply (Sum.inr i) z).fun_add (hi.fun_const_smul h)

def kineticHamiltonian {Nc : ℕ} (m : Fin Nc → ℝ) (z : SymplecticCoordinates Nc) : ℝ :=
  ∑ i, (z (Sum.inr i))^2/(2*m i)

theorem bp_kineticFlow_initial {Nc : ℕ} (m : Fin Nc → ℝ) (z : SymplecticCoordinates Nc) :
    bp_kineticFlow m 0 z = z := by
  funext i
  cases i <;> simp [bp_kineticFlow]

theorem bp_kineticFlow_hamiltonian {Nc : ℕ} (m : Fin Nc → ℝ)
    (_hm : ∀ i, 0 < m i) (z : SymplecticCoordinates Nc) (t : ℝ) :
    HasDerivAt (fun s => bp_kineticFlow m s z)
      (textbookHamiltonianVectorField (kineticHamiltonian m) (bp_kineticFlow m t z)) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_kineticFlow`；`MD.Ch02.momentumKickDerivative`；`MD.Ch02.momentumKick_hasFDerivAt`；`MD.Ch02.kineticHamiltonian`；`MD.Ch02.bp_kineticFlow_initial`；`MD.Ch02.bp_kineticFlow_hamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留总化代数公式和kick导数辅助；新增正质量下动能Hamiltonian、初值及真实Hamilton方程声明。kick导数不作为kinetic流证明；Hamilton识别尚未证明。 | [EXTRA] |

[EXTRA] [EXTRA] 保留总化代数公式和kick导数辅助；新增正质量下动能Hamiltonian、初值及真实Hamilton方程声明。kick导数不作为kinetic流证明；Hamilton识别尚未证明。

### 6. 审计结论

本轮修复：保留总化代数公式和kick导数辅助；新增正质量下动能Hamiltonian、初值及真实Hamilton方程声明。kick导数不作为kinetic流证明；Hamilton识别尚未证明。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；bp\_kineticFlow对任意Nc、m、h、z给出Q\_i=q\_i+h(m\_i)⁻¹p\_i与P\_i=p\_i，坐标公式正确。另两条private声明momentumKickDerivative和momentumKick\_hasFDerivAt只论任意C¹力F的kick导数：位置投影不变，动量导数为dp+h DF(q)dq，其类型及前提合理，但与动能Hamilton流识别无关。全部声明均没有H₁=pᵀM⁻¹p/2、H=H₁+H₂、时间ODE或流初值/群律结论，不能核验引句的完整Hamilton流断言。m非零只在context文字中，不是Lean前提；零质量总化可作代数扩展，不能被称为教材M的实际逆。

### 7. 状态与证明位置

incomplete；`MD.Ch02.bp_kineticFlow`：定义；`MD.Ch02.momentumKickDerivative`：定义；`MD.Ch02.momentumKick_hasFDerivAt`：已证；`MD.Ch02.kineticHamiltonian`：定义；`MD.Ch02.bp_kineticFlow_initial`：已证；`MD.Ch02.bp_kineticFlow_hamiltonian`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1352)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-PotentialFlow · definition · 印刷p.84 / PDFp.106

### 2. 原文陈述

> Similarly, the flow map of the system with Hamiltonian $`H_2=U`$ is

$$
\boldsymbol Q=\boldsymbol q,\qquad\boldsymbol P=\boldsymbol p-h\nabla U(\boldsymbol q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_potentialFlow {Nc : ℕ} (U : Q Nc → ℝ)
    (h : ℝ) : SymplecticCoordinates Nc → SymplecticCoordinates Nc :=
  textbookMomentumKick (textbookPotentialForce U) h

def potentialHamiltonian {Nc : ℕ} (U : Q Nc → ℝ) (z : SymplecticCoordinates Nc) : ℝ :=
  U (textbookPositionProjection Nc z)

theorem bp_potentialFlow_initial {Nc : ℕ} (U : Q Nc → ℝ) (z : SymplecticCoordinates Nc) :
    bp_potentialFlow U 0 z = z := by
  funext i
  cases i <;> simp [bp_potentialFlow, textbookMomentumKick]

theorem bp_potentialFlow_hamiltonian {Nc : ℕ} (U : Q Nc → ℝ)
    (_hU : ContDiff ℝ 1 U) (z : SymplecticCoordinates Nc) (t : ℝ) :
    HasDerivAt (fun s => bp_potentialFlow U s z)
      (textbookHamiltonianVectorField (potentialHamiltonian U) (bp_potentialFlow U t z)) t := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_potentialFlow`；`MD.Ch02.potentialHamiltonian`；`MD.Ch02.bp_potentialFlow_initial`；`MD.Ch02.bp_potentialFlow_hamiltonian` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 原总化公式仅作候选辅助；新增H₂=U∘位置投影、初值及C¹势下候选轨道的真实Hamilton方程声明；Hamilton识别尚未证明，不将不可微点的fderiv总化值称为经典梯度。 | [EXTRA] |

[EXTRA] [EXTRA] 原总化公式仅作候选辅助；新增H₂=U∘位置投影、初值及C¹势下候选轨道的真实Hamilton方程声明；Hamilton识别尚未证明，不将不可微点的fderiv总化值称为经典梯度。

### 6. 审计结论

本轮修复：原总化公式仅作候选辅助；新增H₂=U∘位置投影、初值及C¹势下候选轨道的真实Hamilton方程声明；Hamilton识别尚未证明，不将不可微点的fderiv总化值称为经典梯度。

网站：按网站审校意见修复，本地核验通过（未再送网站）。
网站原返回（对应其审校版本）：FAIL；bp\_potentialFlow对任意Nc、任意势U及实h返回kick(-fderiv U)。展开得到Q=q、P\_i=p\_i-h(fderiv ℝ U q)e\_i，符号、坐标次序正确。但是声明没有U可微前提，也没有H₂=U∘位置投影及HasDerivAt/Flow性质；fderiv在不可微点总化，不能无条件等同经典梯度。因此它只定义候选公式，没有完整覆盖原书“system with Hamiltonian H₂=U”的实际流断言。

### 7. 状态与证明位置

incomplete；`MD.Ch02.bp_potentialFlow`：定义；`MD.Ch02.potentialHamiltonian`：定义；`MD.Ch02.bp_potentialFlow_initial`：已证；`MD.Ch02.bp_potentialFlow_hamiltonian`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1399)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-SplitEuler · unnumbered_claim · 印刷p.84 / PDFp.106

### 2. 原文陈述

> The composition of these maps simplifies to

$$
\boldsymbol Q=\boldsymbol q+hM^{-1}\boldsymbol P,\qquad\boldsymbol P=\boldsymbol p-h\nabla U(\boldsymbol q),
$$


> which is precisely the Symplectic Euler method. Similarly, composing the same two maps in the opposite order gives the adjoint Symplectic Euler method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem splitEuler :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h,
    splittingMap (textbookPositionDrift m) (textbookMomentumKick (textbookPotentialForce U)) h =
      textbookSymplecticEuler m U h ∧
    splittingMap (textbookMomentumKick (textbookPotentialForce U)) (textbookPositionDrift m) h =
      (fun z => textbookAdjointSymplecticEuler m U h z) := by
  exact MolecularDynamics.Chapter02Review.kineticPotentialComposition_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.splitEuler` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀n,m,U,h，两个函数等式均审查：splittingMap drift kick=原辛Euler（先kick后drift），splittingMap kick drift=伴随辛Euler（先drift后kick）。textbookSymplecticEulerEquiv采用置换乘法即函数复合，逆使顺序交换；输出P在原法drift中使用，伴随法在新位置Q施力。Q n和坐标直和空间转换无混淆。结论只是代数函数相等，故不需要U可微或m≠0来保证这个总化恒等式；物理质量/经典梯度解释应限定教材域。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.splitEuler`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1419)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-VerletComposition · Example 2.5 (Verlet is Symplectic) · 印刷p.84–85 / PDFp.106–107

### 2. 原文陈述

> For the Symplectic Euler method $`\mathcal G_h`$ and its adjoint method $`\mathcal G_h^\dagger`$, consider the composition

$$
\mathcal K_h:=\mathcal G_{h/2}^\dagger\circ\mathcal G_{h/2}.
$$



### 3. 原文证明

> Let

$$
\begin{bmatrix}\bar{\boldsymbol q}\\\bar{\boldsymbol p}\end{bmatrix}=\mathcal G_{h/2}\begin{bmatrix}\boldsymbol q\\\boldsymbol p\end{bmatrix},
$$


> i.e.,

$$
\bar{\boldsymbol q}=\boldsymbol q+(h/2)M^{-1}\bar{\boldsymbol p},\qquad\bar{\boldsymbol p}=\boldsymbol p-(h/2)\nabla U(\boldsymbol q).
$$


> and set

$$
\begin{bmatrix}\boldsymbol Q\\\boldsymbol P\end{bmatrix}=\mathcal G_{h/2}^\dagger\begin{bmatrix}\bar{\boldsymbol q}\\\bar{\boldsymbol p}\end{bmatrix},
$$


> i.e.,

$$
\boldsymbol Q=\bar{\boldsymbol q}+(h/2)M^{-1}\bar{\boldsymbol p},\qquad\boldsymbol P=\bar{\boldsymbol p}-(h/2)\nabla U(\boldsymbol Q).
$$


> The composition simplifies to

$$
\bar{\boldsymbol p}=\boldsymbol p-\frac h2\nabla U(\boldsymbol q),\qquad\boldsymbol Q=\boldsymbol q+hM^{-1}\bar{\boldsymbol p},\qquad\boldsymbol P=\bar{\boldsymbol p}-\frac h2\nabla U(\boldsymbol Q).
$$


> This is just the leapfrog/Verlet method in its Hamiltonian form.
原书计算按原页转录。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletComposition :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h z,
    coordinateVerlet m (textbookPotentialForce U) h z =
      pack (verlet m (textbookPotentialForce U) h (unpack z)) ∧
    coordinateVerlet m (textbookPotentialForce U) h z =
      textbookAdjointSymplecticEuler m U (h/2) (textbookSymplecticEuler m U (h/2) z) := by
  exact MolecularDynamics.Chapter02Review.verletComposition_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletComposition` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀n,m,U,h,z，两个合取均正确：coordinateVerlet=pack(verlet(...)(unpack z))，且等于G†_(h/2)(G_(h/2)z)。前者的位置更新q+h m⁻¹p+(h²/2)m⁻¹F(q)，动量更新p+(h/2)(F(q)+F(Q))与两次半kick一次全drift一致；后者是kick(h/2)∘drift(h/2)∘drift(h/2)∘kick(h/2)，次序没有倒置。任意力函数的代数恒等式不需要正则性；U、零质量的总化扩展同上一条，不在本结论中声称实际Hamilton流或精度。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.verletComposition`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1428)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-VerletSymplectic · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> Since we have obtained the method as the composition of two symplectic maps, and the symplectic maps form a group, we know that this method will also be symplectic.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem verletSymplectic :
  ∀ n (m : Fin n → ℝ) (U : Q n → ℝ) h, ContDiff ℝ 2 U →
    IsTextbookSymplecticMap (coordinateVerlet m (textbookPotentialForce U) h) := by
  exact MolecularDynamics.Chapter02Review.verletSymplectic_proved
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.verletSymplectic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | U C²；真实完整步映射。 | [EXTRA] |

[EXTRA] U C²；真实完整步映射。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；∀n、任意固定对角m、任意势U、实h，在U全局C²下，coordinateVerlet的完整kick(h/2)∘drift(h)∘kick(h/2)是C¹且逐点DΦᵀJDΦ=J。不是只验证某个子步。U C²为充分[EXTRA]，各实步长及零维均包括；零质量的总化仍使drift为保辛剪切，不使定理为假。原句借群性说明结论，在本例两个子法确有显式逆；保辛结论不需要一般保辛自映射都全球可逆。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.verletSymplectic`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1438)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-SymmetricComposition · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> When we construct a composition of a method with its adjoint method, we see readily that it is symmetric, i.e. self-adjoint, since

$$
\mathcal K_h^{\dagger}:=[\mathcal G_{h/2}^{\dagger}\circ\mathcal G_{h/2}]^{\dagger}=\mathcal G_{h/2}^{\dagger}\circ\mathcal G_{h/2}=\mathcal K_h.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symmetricComposition {E : Type*}
    (G : ℝ → Equiv.Perm E) :
    textbookAdjointMethod (textbookSymmetricComposition G) =
      textbookSymmetricComposition G := by
  apply MolecularDynamics.textbookSymmetricComposition_isSelfAdjoint <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.symmetricComposition` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | 实际可逆步Equiv.Perm；完整伴随半步组合。 | [EXTRA] |

[EXTRA] 实际可逆步Equiv.Perm；完整伴随半步组合。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意类型E及所有实步长的实际可逆映射；伴随为G(-h)的逆，组合为G†(h/2)乘G(h/2)，Perm乘法对应先右后左。结论为整个步族的自伴随等式，半步、次序和负步长均正确。Equiv.Perm为已披露的可逆资格。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.symmetricComposition`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1445)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.1-SymmetricEven · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> Self-adjoint, or symmetric schemes have unique features; in particular they have even order [164, 227].

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem symmetricEven :
  ∀ n (G F : ℝ → Equiv.Perm (Q n)) r,
    0 < r → textbookAdjointMethod G = G → textbookAdjointMethod F = F →
    (∀ h k z, F h (F k z) = F (h+k) z) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => G x.1 x.2) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => F x.1 x.2) →
    methodLocalOrder (fun h => G h) (fun h => F h) r →
    (¬ methodLocalOrder (fun h => G h) (fun h => F h) (r+1)) → Even r := by
  sorry



/-- 修正版，对应原文 MD-2.4.1-SymmetricEven。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem symmetricEven_corrected :
  ∀ n (G F : ℝ → Equiv.Perm (Q n)) r,
    0 < r → textbookAdjointMethod G = G → textbookAdjointMethod F = F →
    (∀ h k z, F h (F k z) = F (h+k) z) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => G x.1 x.2) →
    ContDiff ℝ ∞ (fun x : ℝ × Q n => F x.1 x.2) →
    methodLocalOrder (fun h => G h) (fun h => F h) r →
    (¬ methodLocalOrder (fun h => G h) (fun h => F h) (r+1)) → Even r := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.symmetricEven`；`MD.Ch02.symmetricEven_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]r>0为有限确切局部阶：r阶界成立而r+1阶不成立；两族C∞且原流为群，自伴随并实际可逆。原书省略“确切”阶资格，精确流没有有限阶。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]r>0为有限确切局部阶：r阶界成立而r+1阶不成立；两族C∞且原流为群，自伴随并实际可逆。原书省略“确切”阶资格，精确流没有有限阶。；[EXTRA] C∞编码补充修复：指定版本裸⊤表示实解析Cω，现将原smooth的前提及输出恢复为scoped ∞；正式库冻结，已有证明随本批重查，失败依≤3次小修规则记录。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；Q n为有限维实空间；r为正自然数，G、F均实际可逆且联合C∞，F具有群律。逐点局部误差O(|h|^(r+1))且非O(|h|^(r+2))编码有限确切阶；光滑自伴随族的首个非零局部误差次数为奇数，故r偶。群律与可逆性推出F 0=id；正阶误差推出G 0=id。加强条件已标EXTRA，结论合理；原句省略有限确切阶资格须保留提醒。 当前限定版/Printed签名本身忠实且合理；本条综合判NEEDS\_HUMAN来自必须保留的原书数学资格或疑误，并非据此判Lean签名错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.symmetricEven`：未证（原书疑误不证）；`MD.Ch02.symmetricEven_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1455)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.2-CompositionSymplectic · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> More generally, if we have any two symplectic numerical methods, say $`\mathcal G_h^1`$ and $`\mathcal G_h^2`$, then the composition

$$
\mathcal G_h:=\mathcal G_{h/2}^1\circ\mathcal G_{h/2}^2
$$


> is another symplectic numerical method.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem compositionSymplectic {Nc : ℕ}
    (G₁ G₂ : ℝ → SymplecticCoordinates Nc → SymplecticCoordinates Nc)
    (hG₁ : ∀ h, IsTextbookSymplecticMap (G₁ h))
    (hG₂ : ∀ h, IsTextbookSymplecticMap (G₂ h)) (h : ℝ) :
    IsTextbookSymplecticMap (textbookComposeMaps G₁ G₂ h) := by
  apply MolecularDynamics.textbookComposeMaps_isSymplectic <;> assumption
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.compositionSymplectic` | 完整代码见第4段；两个版本独立列出 |

[EXTRA] 无新增技术资格。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意Nc、两族全实步长C¹辛映射，h为任意实数。项目定义用标准J及DΦᵀ J DΦ=J；textbookComposeMaps确为G₁(h/2)∘G₂(h/2)。结论包括复合C¹及每点Jacobian保辛，域和复合方向完整。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

checked+documented priors；`MD.Ch02.compositionSymplectic`：已证。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1483)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.2-CompositionOrder · unnumbered_claim · 印刷p.85 / PDFp.107

### 2. 原文陈述

> The order of this method is typically the minimum of the orders of the two methods involved, but it can be higher, as the example of the Verlet method (constructed by composing symplectic Euler and its adjoint) shows.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem compositionOrder :
  ∀ n (F : ℝ → Equiv.Perm (Q n)) (G₁ G₂ : ℝ → Q n → Q n) r s,
    (∀ h k z, F h (F k z) = F (h+k) z) →
    methodLocalOrder G₁ (fun h => F h) r → methodLocalOrder G₂ (fun h => F h) s →
    (∀ δ > 0, ∃ L ≥ 0, ∀ h : ℝ, |h| < δ → ∀ u v, ‖G₁ h u-G₁ h v‖ ≤ (1 + |h| * L)*‖u-v‖) →
    methodLocalOrder (textbookComposeMaps G₁ G₂) (fun h => F h) (min r s) := by
  sorry



/-- 修正版，对应原文 MD-2.4.2-CompositionOrder。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem compositionOrder_corrected :
  ∀ n (F : ℝ → Equiv.Perm (Q n)) (G₁ G₂ : ℝ → Q n → Q n) r s,
    (∀ h k z, F h (F k z) = F (h+k) z) →
    methodLocalOrder G₁ (fun h => F h) r → methodLocalOrder G₂ (fun h => F h) s →
    (∀ δ > 0, ∃ L ≥ 0, ∀ h : ℝ, |h| < δ → ∀ u v, ‖G₁ h u-G₁ h v‖ ≤ (1 + |h| * L)*‖u-v‖) →
    methodLocalOrder (textbookComposeMaps G₁ G₂) (fun h => F h) (min r s) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.compositionOrder`；`MD.Ch02.compositionOrder_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]两个方法逼近同一实际流；第一个方法1+L\|h\|稳定；陈述保留至少min阶，允许更高，不把“typically”冒充确切阶相等。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]两个方法逼近同一实际流；第一个方法1+L|h|稳定；陈述保留至少min阶，允许更高，不把“typically”冒充确切阶相等。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：FAIL；已展开全部本条自定义对象：Chapter02Review.Q n = Fin n → ℝ，r、s为自然数；F是每个实时间的双射族，假设∀h k z, F h(F k z)=F(h+k)z，因此F 0=id。G₁、G₂是任意方法族，不要求辛；这是阶数估计的合理推广。methodLocalOrder G F r 实为 ∀z, ∃C>0, ∃δ>0, ∀h, |h|<δ → ‖G h z−F h z‖≤C|h|^(r+1)，是每个固定初值的局部截断误差下界，C与δ可依赖z，既非确切阶也非全局误差阶。textbookComposeMaps 展开为G₁(h/2)∘G₂(h/2)。实际量词顺序为n,F,G₁,G₂,r,s，然后流律、两条逐点局部阶假设、G₁稳定假设，结论只有同一逐点局部意义的min r s阶下界。[EXTRA]同一实际流合理，误差传播稳定条件合理作为充分条件，但实际稳定性为∀δ>0 ∃L≥0 ∀|h|<δ ∀u v，与原文未言明的全域空间稳定性及每个有限步长区间要求相比明显更强；证明局部阶通常只需某个小δ，不能称该全部额外强度必要。逐点误差常数不能直接用于随h移动的初值F(h/2)z，若采用通常的误差分解证明，还需补足邻域一致性或另给严格论证；本审计不据此断言定理数学上为假。确定的FAIL理由是全部结论未覆盖：至少min阶仅允许、没有断言或展示严格更高阶的实例；原文明确的Verlet由辛Euler及其伴随复合并达到更高阶未表达，typically也未形式化为任何泛型结论。原文statement\_scope覆盖整句，不能以[EXTRA]注释把整句缩成下界定理而仍判完全忠实。无[ERRATUM?]，未发现需要据此修改原书的错误。Ch02.lean 1059–1065与本批签名一致，含直接sorry；证明缺口与上述签名语义FAIL分开。

### 7. 状态与证明位置

incomplete；`MD.Ch02.compositionOrder`：未证（原书疑误不证）；`MD.Ch02.compositionOrder_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1493)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.3-HarmonicSplit · definition · 印刷p.85 / PDFp.107

### 2. 原文陈述

> Some systems can be decomposed into a harmonic (quadratic) part $`H_0(\boldsymbol q,\boldsymbol p)=\boldsymbol p^T M^{-1}\boldsymbol p/2+\boldsymbol q^T A\boldsymbol q/2`$ and an anharmonic part $`H_1(\boldsymbol q,\boldsymbol p)=\breve U(\boldsymbol q)`$. Then a splitting method can be formulated based on exact solution of the linear system together with “kicks” representing impulses defined by the anharmonic part. For a simple system consisting of a harmonic oscillator $`H_0(q,p)=p^2/2+\Omega^2q^2/2`$, such a method can be written

$$
\begin{bmatrix}Q\\\hat p\end{bmatrix}=\begin{bmatrix}\cos h\Omega&\frac{1}{\Omega}\sin h\Omega\\-\Omega\sin h\Omega&\cos h\Omega\end{bmatrix}\begin{bmatrix}q\\p\end{bmatrix},\qquad P=\hat p-h\breve U'(Q).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def bp_harmonicAnharmonic (Ω : ℝ) (_hΩ : Ω ≠ 0) (U : ℝ → ℝ) (_hU : Differentiable ℝ U) (h : ℝ) (z : ℝ × ℝ) : ℝ × ℝ :=
  let q := Real.cos (h*Ω)*z.1 + Real.sin (h*Ω)/Ω*z.2
  (q, -Ω*Real.sin (h*Ω)*z.1 + Real.cos (h*Ω)*z.2 - h*deriv U q)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.bp_harmonicAnharmonic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]Ω≠0时闭式除法有效；Ω=0须取极限漂移，原文未写退化情形。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 保留原除法闭式，频率非零落实为证明参数；U全域经典可微为更新点导数的充分[EXTRA]，未擅加Ω=0延拓。 | [EXTRA] |

[EXTRA] [EXTRA]Ω≠0时闭式除法有效；Ω=0须取极限漂移，原文未写退化情形。；[EXTRA] 保留原除法闭式，频率非零落实为证明参数；U全域经典可微为更新点导数的充分[EXTRA]，未擅加Ω=0延拓。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；定义仅承担已明确限域的标量简例：Ω非零、U全域可微，任意实h及(q,p)。先按振子矩阵计算Q，再以同一Q计算P=−Ωsin(hΩ)q+cos(hΩ)p−h U′(Q)。不是在旧q施加kick。非零频率和可微资格均已披露；一般M,A分裂作为背景，不误作已形式化。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch02.bp_harmonicAnharmonic`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1519)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-ImplicitLocal · unnumbered_claim · 印刷p.86 / PDFp.108

### 2. 原文陈述

> An implicit method will typically result in a system of nonlinear equations of the form

$$
g(\boldsymbol z_{n+1})=\boldsymbol\tau_n,\tag{2.25}
$$


> which will need to be solved at each timestep. The right hand side $`\boldsymbol\tau_n`$ is a vector that depends on the previous time-step $`\boldsymbol z_n`$, perhaps in a complicated way. We may assume the number of equations represented by (2.25) is equal to the dimension of the space where $`\boldsymbol z`$ is defined, so we have a square nonlinear system. Typically $`g`$ will depend on the stepsize and coefficients of the method and will have the property that for $`h`$ sufficiently small, the solution is uniquely defined and is continuously defined in terms of $`\boldsymbol\tau_n`$, that is the mapping $`g`$ has a bounded and smooth inverse.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem implicitLocal : ∀ n (g : ℝ → Q n → Q n) x
    (A : Q n ≃L[ℝ] Q n), ContDiff ℝ ∞ (Function.uncurry g) →
    HasFDerivAt (g 0) A.toContinuousLinearMap x →
    ∃ δ > 0, ∀ h : ℝ, |h| < δ → ∃ U V : Set (Q n),
      IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g h x ∈ V ∧ MapsTo (g h) U V ∧
      ∃ inv : Q n → Q n, ContDiffOn ℝ ∞ inv V ∧
        (∃ K ≥ 0, ∀ y ∈ V, ‖inv y‖ ≤ K) ∧
        (∀ y ∈ V, inv y ∈ U ∧ g h (inv y)=y) ∧
        (∀ y ∈ U, inv (g h y)=y) := by
  sorry



/-- 修正版，对应原文 MD-2.4.4-ImplicitLocal。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
theorem implicitLocal_corrected : ∀ n (g : ℝ → Q n → Q n) x
    (A : Q n ≃L[ℝ] Q n), ContDiff ℝ ∞ (Function.uncurry g) →
    HasFDerivAt (g 0) A.toContinuousLinearMap x →
    ∃ δ > 0, ∀ h : ℝ, |h| < δ → ∃ U V : Set (Q n),
      IsOpen U ∧ IsOpen V ∧ x ∈ U ∧ g h x ∈ V ∧ MapsTo (g h) U V ∧
      ∃ inv : Q n → Q n, ContDiffOn ℝ ∞ inv V ∧
        (∃ K ≥ 0, ∀ y ∈ V, ‖inv y‖ ≤ K) ∧
        (∀ y ∈ V, inv y ∈ U ∧ g h (inv y)=y) ∧
        (∀ y ∈ U, inv (g h y)=y) := by
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
| 对象、量词、假设和定义/结论 | `MD.Ch02.implicitLocal`；`MD.Ch02.implicitLocal_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]g依赖真实步长h；联合C∞，零步实际导数为连续线性同构。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA]结论为充分小步长的局部逆；缩小有界邻域，不宣称全域有界逆。 | [EXTRA] |
| 技术资格或版本解释 | [EXTRA] 补g\_h(U)⊆V，连同原左右逆完整表达局部微分同胚；不声称全域可解。 | [EXTRA] |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [EXTRA]g依赖真实步长h；联合C∞，零步实际导数为连续线性同构。；[EXTRA]结论为充分小步长的局部逆；缩小有界邻域，不宣称全域有界逆。；[EXTRA] 补g\_h(U)⊆V，连同原左右逆完整表达局部微分同胚；不声称全域可解。；[ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；对每个n、联合C∞的g(h,x)、基点x及零步可逆导数A，存在统一小步长δ；每个小步长有开U,V包含x,g\_h(x)，MapsTo及双向逆等式。inv在V内C∞且函数值有界；可通过缩小局部邻域取得该界，不等于宣称全域逆有界。前提和局部性均明确，未假设所需逆已经存在。 当前限定版/Printed签名本身忠实且合理；本条综合判NEEDS\_HUMAN来自必须保留的原书数学资格或疑误，并非据此判Lean签名错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.implicitLocal`：未证（原书疑误不证）；`MD.Ch02.implicitLocal_corrected`：未证（时间盒止）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1528)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-BackwardEulerSolve · Example 2.6 · 印刷p.86 / PDFp.108

### 2. 原文陈述

> The Backward Euler method,

$$
\boldsymbol z_{n+1}=\boldsymbol z_n+hf(\boldsymbol z_{n+1}),
$$


> is an example of an implicit method. The calculation of a timestep involves solving a system of equations of the form

$$
g(\boldsymbol w)\equiv\boldsymbol w-\boldsymbol z_n-hf(\boldsymbol w)=\boldsymbol0.
$$


> The map $`\mathcal G_t`$ is defined implicitly by the equation

$$
\mathcal G_h(\boldsymbol z)=\boldsymbol z+hf(\mathcal G_h(\boldsymbol z)).
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def backwardEulerResidual (f : E → E) (h : ℝ) (z w : E) : E := w-z-h • f w

theorem backwardEulerResidual_zero_iff (f : E → E) (h : ℝ) (z w : E) :
    backwardEulerResidual f h z w = 0 ↔ w = z + h • f w := by
  sorry

def backwardEulerMapRelation (f : E → E) (h : ℝ) (G : E → E) : Prop :=
  ∀ z, G z = z + h • f (G z)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.backwardEulerResidual`；`MD.Ch02.backwardEulerResidual_zero_iff`；`MD.Ch02.backwardEulerMapRelation` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA] 保留残差并补零点与隐式更新等价、给定G满足的映射方程；不假设任意f,h都有唯一解。 | [EXTRA] |

[EXTRA] [EXTRA] 保留残差并补零点与隐式更新等价、给定G满足的映射方程；不假设任意f,h都有唯一解。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；残差w−z−h•f(w)、其零点等价式、以及给定G的逐点隐式关系均吻合；未从定义推断解的存在唯一性。E的减法和实数作用按该表达式所需的实向量空间背景解释；摘录没有完整外围变量声明，本次仅作所给签名的语义核对。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.backwardEulerResidual`：定义；`MD.Ch02.backwardEulerResidual_zero_iff`：未证（缺大型理论）；`MD.Ch02.backwardEulerMapRelation`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1559)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-Newton · definition · 印刷p.86–87 / PDFp.108–109

### 2. 原文陈述

> Solving the system may then proceed, from an initial guess $`\boldsymbol z_{n+1}^{(0)}`$ by use of Newton’s method:

$$
\boldsymbol z_{n+1}^{(k+1)}=\boldsymbol z_{n+1}^{(k)}-[J^{(k)}]^{-1}(g(\boldsymbol z_n^{(k)})-\boldsymbol\tau_n),
$$


> where $`J^{(k)}`$ is the Jacobian matrix of the mapping $`g`$ evaluated at $`\boldsymbol z_n^{(k)}`$, or else an approximation of this Jacobian (assumed to be nonsingular due to the invertibility of the mapping). The iteration may be recast in the form

$$
\boldsymbol b_k=-(g(\boldsymbol z_n^{(k)})-\boldsymbol\tau_n),\quad J^{(k)}\Delta\boldsymbol z_k=\boldsymbol b_k,\quad\boldsymbol z_{n+1}^{(k+1)}=\boldsymbol z_{n+1}^{(k)}+\Delta\boldsymbol z_k.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
def newtonPrinted {n : ℕ} (g : Q n → Q n) (τ xNext xPrev : Q n)
    (J : Q n ≃L[ℝ] Q n) : Q n := xNext-J.symm (g xPrev-τ)



/-- 修正版，对应原文 MD-2.4.4-Newton。改动：将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 -/
```

独立修正版：

```lean
def newtonPrinted_corrected {n : ℕ} (g : Q n → Q n) (τ xNext xPrev : Q n)
    (J : Q n ≃L[ℝ] Q n) : Q n := xNext-J.symm (g xPrev-τ)
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 保留完整原文引文；Lean仅覆盖第4段明示的定义与限定结论，原书疑误或超出该陈述的内容不冒称已形式化。各版本差异见本条与ERRATA。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.newtonPrinted`；`MD.Ch02.newtonPrinted_corrected` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。 | [EXTRA] |

[EXTRA] [ERRATUM?] 将已有带明示资格的数学解释独立命名为修正版；原书逐字记录及已有声明保留。完整原句超出本声明部分在覆盖缺口/审阅问题中列明，不把有限资格解释当作原句无条件成立。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：原书疑误/资格待导师；原文与修正版并列。
网站原返回（对应其审校版本）：NEEDS\_HUMAN；newtonPrinted特意把当前被更新量xNext与残差求值量xPrev分开：xNext−J⁻¹(g(xPrev)−τ)，忠实保留原页n+1/n的混用，未擅改为标准Newton。J为连续线性同构对应可逆矩阵，也容纳所述可逆近似矩阵。原书的线性求解重写与该公式代数等价；未提供该等价的Lean定理，但定义没有错误变更字面公式。原书索引及“可逆映射所以Jacobian非奇异”的理由另须人工处理。 当前限定版/Printed签名本身忠实且合理；本条综合判NEEDS\_HUMAN来自必须保留的原书数学资格或疑误，并非据此判Lean签名错误。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

self-contained；`MD.Ch02.newtonPrinted`：定义；`MD.Ch02.newtonPrinted_corrected`：定义。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1571)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-NewtonQuadratic · unnumbered_claim · 印刷p.87 / PDFp.109

### 2. 原文陈述

> Newton’s method (without approximation of the Jacobian matrix) has a remarkable quadratic convergence property, meaning that, when the initial guess is close the solution, the errors $`e_k,e_{k+1}`$ at the $`k`$th and $`k+1`$st iterations satisfy the relation

$$
e_{k+1}\le Ke_k^2.
$$



### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem newtonQuadratic :
  ∀ n (g : Q n → Q n) x (A : Q n ≃L[ℝ] Q n),
    ContDiff ℝ 2 g → g x = 0 → HasFDerivAt g A.toContinuousLinearMap x →
    ∃ C > 0, ∃ δ > 0, ∀ y : Q n, ‖y-x‖ < δ →
      ∃ B : Q n ≃L[ℝ] Q n, HasFDerivAt g B.toContinuousLinearMap y ∧ ‖newtonStep g 0 y B-x‖ ≤ C*‖y-x‖^2 := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.newtonQuadratic` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]C²、简单零点及可逆实际导数；充分近初值；局部一步二次界涵盖迭代误差关系。 | [EXTRA] |

[EXTRA] [EXTRA]C²、简单零点及可逆实际导数；充分近初值；局部一步二次界涵盖迭代误差关系。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（EAUDIT复审）。
网站原返回（对应其审校版本）：PASS；任意n、C²映射g、简单零点x及其可逆实际导数A；存在统一C,δ，对每个邻点y提供该点的可逆实际导数B，并给标准newtonStep g 0 y B的一步二次误差界。不是近似Jacobian，且不复用Printed版的错位索引。缩小δ可保证Cδ<1而获得持续迭代；所列EXTRA充分。 本次只读检查任务所给完整签名及项目依赖定义，未修改工程、未补证明、未以sorry判失败，也未声称已编译验证。

### 7. 状态与证明位置

incomplete；`MD.Ch02.newtonQuadratic`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1582)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

## 1. MD-2.4.4-FrozenNewton · unnumbered_claim · 印刷p.87 / PDFp.109

### 2. 原文陈述

> For example, if the Jacobian matrix is large and can be written in the form

$$
J(\boldsymbol z)=D+E(\boldsymbol z),
$$


> where $`E`$ is small in norm and $`D`$ is a constant sparse matrix, then, in many cases, the Jacobian matrix may be replaced by the constant matrix $`D`$ and the iteration will still converge.
> This rapid convergence is typically lost when the Jacobian matrix is approximated in some way, and one finds instead

$$
e_{k+1}\le\rho e_k,
$$


> where $`0\lt \rho\lt 1`$, i.e., quadratic convergence is replaced by geometric convergence.

### 3. 原文证明

原书无独立完整证明。
原书未给独立完整证明。

### 4. 完整当前Lean（原文与修正版独立列出）

原文版、既有数学解释及同组辅助声明：

```lean
theorem frozenNewton :
  ∀ n (g : Q n → Q n) (A : Q n ≃L[ℝ] Q n) x δ ρ,
    g x = 0 → 0 < δ → 0 < ρ → ρ < 1 → ContDiff ℝ 1 g →
    (∀ y ∈ Metric.ball x δ, ‖ContinuousLinearMap.id ℝ (Q n)-A.symm.toContinuousLinearMap.comp (fderiv ℝ g y)‖ ≤ ρ) →
    ∀ y ∈ Metric.ball x δ, ‖newtonStep g 0 y A-x‖ ≤ ρ*‖y-x‖ := by
  sorry
```

### 5. 对照表

| 原文成分 | Lean对应 | 说明 |
|---|---|---|
| 当前覆盖范围 | 本条所引原句及展示公式；单个记号归入context\_notation。 | 仅承诺明确列出的数学内容 |
| 对象、量词、假设和定义/结论 | `MD.Ch02.frozenNewton` | 完整代码见第4段；两个版本独立列出 |
| 技术资格或版本解释 | [EXTRA]固定D连续线性同构，邻域内实际I−D⁻¹g′范数≤ρ<1，ρ>0；精确可核的small资格，未声称任意近似Jacobian都收敛。 | [EXTRA] |

[EXTRA] [EXTRA]固定D连续线性同构，邻域内实际I−D⁻¹g′范数≤ρ<1，ρ>0；精确可核的small资格，未声称任意近似Jacobian都收敛。

### 6. 审计结论

本地限定解释与原文问题见上列范围及对照；逐声明编译、公理结果见第7段。

网站：网站PASS（绑定版本 f24b625cda35c51074f87df43493f35787dd9137d25683675cb793b757d111bb）。
网站原返回（对应其审校版本）：PASS；Ch02.lean:1106–1111；依赖展开Q n=Fin n→ℝ及newtonStep g 0 y A=y−A.symm(g y)。A为固定D的可逆线性算子，x为残差零点；先固定δ,ρ，再要求δ>0、0<ρ<1、g为C¹以及整个球内‖I−A⁻¹g′(y)‖≤ρ，最后对每个球内y断言一步误差收缩。fderiv为实际导数，C¹保证其不是不可微时的默认值；comp表示先作用g′再作用A⁻¹。若g′=D+E，界等于‖−D⁻¹E‖≤ρ，明确了small必须相对于D的逆尺度，属于合理[EXTRA]，不是仅把所求误差界重写为前提。凸球上的导数界给出一步界，ρ<1保证球不变，归纳得e\_k≤ρ^k e\_0，涵盖几何收敛。常数矩阵稀疏和维数大是计算成本背景，不是收敛所必需；任意近似Jacobian均收敛并未被断言。依赖frozenNewton\_statement使用0≤ρ，实际声明使用原文0<ρ，按实际声明审计。定理含sorry，签名PASS与证明完成无关。

### 7. 状态与证明位置

incomplete；`MD.Ch02.frozenNewton`：未证（缺大型理论）。
位置：[Blueprint/Ch02.lean](../../../../Blueprint/Ch02.lean#L1591)；逐声明核验：blueprint/closeout24/ch02/errata-05.log。

