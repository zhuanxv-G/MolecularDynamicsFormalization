from ch07_data import add

add('ThreeOperatorBCH','7.7.2',287,
r'''\[\exp(hS)=\exp(hZ)\exp(hY)\exp(hX).\tag{7.18}\]
\[S=X+Y+Z+\frac h2([Z,Y]+[Z,X]+[Y,X])+\frac{h^2}{4}[Z,Y,X]
+\frac{h^2}{12}([Y,Y,X]+[X,X,Y]+[Z,Z,Y]+[Z,Z,X]+[Y+X,Y+X,Z])+\cdots\]
where the notation $[A,B,C]$ is notation for $[A,[B,C]]$.''',
'''def threeStage {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) : PowerSeries R :=
  MolecularDynamics.textbookFormalOperatorExponential Z *
    MolecularDynamics.textbookFormalOperatorExponential Y * MolecularDynamics.textbookFormalOperatorExponential X
theorem threeOperatorBCH {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    PowerSeries.coeff 0 (formalModifiedGenerator (threeStage X Y Z)) = X+Y+Z ∧
    PowerSeries.coeff 1 (formalModifiedGenerator (threeStage X Y Z)) =
      (1/2 : ℝ) • (comm Z Y+comm Z X+comm Y X) ∧
    PowerSeries.coeff 2 (formalModifiedGenerator (threeStage X Y Z)) =
      (1/4 : ℝ) • comm Z (comm Y X)+(1/12 : ℝ) •
        (comm Y (comm Y X)+comm X (comm X Y)+comm Z (comm Z Y)+
          comm Z (comm Z X)+comm (Y+X) (comm (Y+X) Z)) := by
  sorry''',label='(7.18)',
proof='Apply the two-operator BCH formula first to exp(hY)exp(hX), and then to exp(hZ)exp(h(Y+X+...)); combine equal powers of h.',
extra=['完整记录最终0–2阶系数；中间未合并式作为原文推导说明，不另假装是完整精确算符相等。'],
missing='需三重形式指数乘积的低阶log系数展开；不建设无界算符BCH收敛理论。')

add('ScalarForwardOperators','7.7.2',288,
r'''In this one dimensional example, we substitute
\[Z=\mathcal L_A^\dagger=-p\frac\partial{\partial q},\quad Y=\mathcal L_B^\dagger=U'(q)\frac\partial{\partial p},\quad
X=\mathcal L_O^\dagger=\gamma\left({\rm Id}+p\frac\partial{\partial p}\right)+\frac{\sigma^2}{2}\frac{\partial^2}{\partial p^2},\]
where $\sigma=\sqrt{2\gamma k_BT}$.''',
'''abbrev Density1 := (ℝ × ℝ) → ℝ
def dq (f : Density1) (x : ℝ × ℝ) : ℝ := deriv (fun q ↦ f (q,x.2)) x.1
def dp (f : Density1) (x : ℝ × ℝ) : ℝ := deriv (fun p ↦ f (x.1,p)) x.2
def opA (f : Density1) (x : ℝ × ℝ) : ℝ := -x.2*dq f x
def opB (U : ℝ → ℝ) (f : Density1) (x : ℝ × ℝ) : ℝ := deriv U x.1*dp f x
def opO (γ θ : ℝ) (f : Density1) (x : ℝ × ℝ) : ℝ := γ*(f x+x.2*dp f x)+γ*θ*dp (dp f) x
def opLD (U : ℝ → ℝ) (γ θ : ℝ) (f : Density1) : Density1 := opA f+opB U f+opO γ θ f
def opComm (A B : Density1 → Density1) (f : Density1) : Density1 := A (B f)-B (A f)''',kind='definition',
extra=['所有偏导都是实际deriv，单位质量、θ=k_BT；用于光滑密度与γ≥0,θ>0。这里不把未规定定义域的微分表达式直接称闭算符。'])

add('CommutatorAB','7.7.2',288,
r'''\[[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho=-p\frac\partial{\partial q}\left(U'(q)\frac{\partial\rho}{\partial p}\right)-U'(q)\frac\partial{\partial p}\left(-p\frac{\partial\rho}{\partial q}\right)
=-pU''(q)\rho_p-pU'(q)\rho_{pq}+U'(q)\rho_q+U'(q)p\rho_{qp}.\]
As this is the commutator of two 1st order differential operators, the mixed partial term vanishes, leaving
\[[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho=-pU''(q)\rho_p+U'(q)\rho_q.\]''',
'''theorem commutatorAB (U : ℝ → ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 2 U) (hρ : ContDiff ℝ 2 ρ) : ∀ x,
    opComm opA (opB U) ρ x = -x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x := by
  sorry''',proof='Expand both product derivatives and cancel the mixed partials using equality of mixed partials.',
missing='需实二变量偏导乘积与混合偏导交换的短桥；不重建一般微分算符理论。')

add('CommutatorsAOBO','7.7.2',289,
r'''Similar computations give
\[[\mathcal L_A^\dagger,\mathcal L_O^\dagger]\rho=\gamma p\rho_q+\sigma^2\rho_{qp},\qquad
[\mathcal L_B^\dagger,\mathcal L_O^\dagger]\rho=\gamma U'(q)\rho_p.\]''',
'''theorem commutatorsAOBO (U : ℝ → ℝ) (ρ : Density1) (γ θ : ℝ)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    opComm opA (opO γ θ) ρ x = γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x ∧
    opComm (opB U) (opO γ θ) ρ x = γ*deriv U x.1*dp ρ x := by
  sorry''',missing='需三阶偏导乘积展开与交换桥接；最多短路线，不建大型算符理论。')

add('OBAModifiedOperator','7.7.2','288–289',
r'''\[\exp(h\widehat{\mathcal L}_{[OBA]}^\dagger)=\exp(h\mathcal L_A^\dagger)\exp(h\mathcal L_B^\dagger)\exp(h\mathcal L_O^\dagger).\]
\[\widehat{\mathcal L}_{[OBA]}^\dagger\rho=\mathcal L_{LD}^\dagger\rho+\frac h2[-pU''(q)\rho_p+U'(q)\rho_q+\gamma p\rho_q+\sigma^2\rho_{qp}+\gamma U'(q)\rho_p]+O(h^2).\]''',
'''def obaFirstCorrection (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1) (x : ℝ × ℝ) : ℝ :=
  (1/2)*(-x.2*deriv (deriv U) x.1*dp ρ x+deriv U x.1*dq ρ x+
    γ*x.2*dq ρ x+2*γ*θ*dq (dp ρ) x+γ*deriv U x.1*dp ρ x)
theorem obaFirstCorrection_commutators (U : ℝ → ℝ) (γ θ : ℝ) (ρ : Density1)
    (hU : ContDiff ℝ 3 U) (hρ : ContDiff ℝ 3 ρ) : ∀ x,
    obaFirstCorrection U γ θ ρ x = (1/2)*(opComm opA (opB U) ρ x+
      opComm opA (opO γ θ) ρ x+opComm (opB U) (opO γ θ) ρ x) := by
  intro x
  rw [commutatorAB U ρ (hU.of_le (by norm_num)) (hρ.of_le (by norm_num)),
    (commutatorsAOBO U ρ γ θ hU hρ x).1, (commutatorsAOBO U ρ γ θ hU hρ x).2]
  dsimp [obaFirstCorrection]
  ring''',
extra=['只证明三个真实交换子表达式与所印一阶修正一致；整体离散传播子的余项界需Taylor/弱展开桥，不声称完成。'])

add('SpectralQualification','7.7.2',289,
r'''The assumption of validity becomes more credible as we find that the operator $\mathcal L_{LD}^\dagger$ has a compact resolvent and therefore a discrete spectrum, i.e. simple eigenvalues, as discussed in the previous chapter. It will have one zero eigenvalue corresponding to the invariant density $\rho_\beta$ and all the remaining eigenvalues lie in the negative half plane.''',
'''def simpleEigenvalue {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (eigen : ℂ) : Prop := Module.finrank ℂ (Module.End.eigenspace L eigen) = 1
def printedSpectralConclusion {E : Type*} [AddCommGroup E] [Module ℂ E]
    (L : Module.End ℂ E) (ρ : E) : Prop :=
  ρ ≠ 0 ∧ L ρ = 0 ∧ ∀ eigen : ℂ, (∃ v : E, v ≠ 0 ∧ L v = eigen • v) →
    simpleEigenvalue L eigen ∧ (eigen = 0 ∨ eigen.re < 0)''',kind='definition',
issues=['已目视核对PDF310：原文将discrete spectrum释为simple eigenvalues，这并非一般蕴含。紧预解式至多给离散谱及有限重数，不能直接给单重谱；Langevin谱还需前章所列势函数/空间条件。'],
extra=['只记录原文谱结论的精确目标命题，不宣称为定理；一般闭无界Langevin生成元、定义域及紧预解式资格未覆盖。'],
scope='原文谱断言已登记，Lean定义其点谱目标；尚缺无界算符对象和完整限定定理。',verdict='NEEDS_HUMAN')
