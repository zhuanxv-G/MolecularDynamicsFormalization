"""Inactive draft: actual Hamiltonian power derivatives and literal false bound are separate."""
from ch06_data import add,copied,NS
F='MolecularDynamics/Chapter06/LangevinLyapunov.lean'
add('UnitLangevinModel','6.4.4',251,[101,109],r'''In Langevin dynamics, taking $M=I$ for simplicity,
\[dq=pdt;\qquad dp=-\nabla U(q)dt-\gamma pdt+\sqrt{2\gamma k_BT}dW;\tag{6.47}\]''','''def unitLangevinModel {n : ℕ} {A : Type*} [MeasurableSpace A] (P : Measure A)
    (W : ℝ → A → (Fin n → ℝ)) (X : ℝ → A → ((Fin n → ℝ) × (Fin n → ℝ)))
    (U : (Fin n → ℝ) → ℝ) (γ β : ℝ) (x0 : (Fin n → ℝ) × (Fin n → ℝ)) : Prop :=
  0 < β ∧ ContDiff ℝ ∞ U ∧ MD.Ch06.langevinMassSDE P W X (fun _ ↦ 1) U γ β⁻¹ x0''',kind='definition',label='(6.47)',extra=['[EXTRA]真实单位质量完整耦合路径方程；β>0及光滑势保证原梯度存在，γ>0由实际MassLangevin资格保留。Wiener law在对应定理另给，不宣称任意W是Wiener。'])
add('PeriodicConfiningPrinted','6.4.4',253,[100],r'''The whole phase space is $D=\mathbb T^{N_c}\times\mathbb R^{N_c}$. We also consider the potential energy to be smooth ($C^\infty$) with $U(q)\to\infty$ as $|q|\to\infty$.''','''def periodicConfiningPrinted {n : ℕ} (_hn : 0 < n) (U : (Fin n → ℝ) → ℝ) : Prop :=
  ContDiff ℝ ∞ U ∧ textbookUnitPeriodicPotential U ∧
    Tendsto U (cocompact (Fin n → ℝ)) atTop''',kind='definition',verdict='NEEDS_HUMAN',issues=['原周期位置域与同一势能lift的q→∞围束条件冲突；保留字面资格而非构造一个不存在的周期围束势。'],extra=['[EXTRA]实际正维单位周期lift，cocompact表达配置无穷远；不是动量Hamiltonian的围束。'],missing='原周期/配置围束条件须导师签核，实际H^l在动量无穷远的proper结论另列。')
add('HamiltonianPower','6.4.4',253,[101],r'''For the Lyapunov condition (Assumption 2), we choose the Lyapunov function
\[\varphi(q,p)=H^l(q,p)=\left[\tfrac12\|p\|^2+U(q)\right]^l;\]
for a fixed positive integer $l$.''',copied(F,'textbookLangevinHamiltonianPower','hamiltonianPower').replace('(l : ℕ)','(l : ℕ) (_hl : 1 ≤ l)',1),kind='definition',extra=['[EXTRA]l≥1编码，真实单位质量Hamiltonian，未把形式jet当真实函数；正性与柱形proper在后续实际桥接证明。'])
add('HamiltonianPowerCancellation','6.4.4',253,[102],r'''we can see that
\[p\cdot\nabla_q\varphi-\nabla U(q)\cdot\nabla_p\varphi=\mathcal L_H\varphi=0;\]
where $\mathcal L_H$ is the Lie derivative of our original Hamiltonian system (which preserves all functions of the Hamiltonian).''','''theorem hamiltonianPowerCancellation {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (hU : Differentiable ℝ U) (l : ℕ) (_hl : 1 ≤ l) (z : textbookLangevinPhase n) :
  HasDerivAt (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
    (z+t • textbookLangevinDrift U 0 z)) 0 0 := by
  simpa using textbookLangevinHamiltonianPower_drift_hasDerivAt U hU (0 : ℝ) l z''',extra=['[EXTRA]实际沿Hamiltonian方向的真实导数为0；γ=0只在此Hamiltonian部分，非把整个物理Langevin摩擦设零。'],prior=['MolecularDynamics.textbookLangevinHamiltonianPower_drift_hasDerivAt'])
add('HamiltonianPowerMomentumDerivative','6.4.4',253,[102],r'''Using $\|p\|^2<2H$, we compute derivatives to find
\[p\cdot\nabla_p\varphi=lH^{l-1}\|p\|^2=2l\varphi-2lH^{l-1}U(q).\]''','''theorem hamiltonianPowerMomentumDerivative : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ)
    (l : ℕ) (z : textbookLangevinPhase n), 1 ≤ l →
  HasDerivAt (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l (z.1,(1+t) • z.2))
    ((l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*(∑ i, z.2 i^2)) 0 ∧
  (l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*(∑ i, z.2 i^2) =
    2*(l : ℝ)*textbookLangevinHamiltonianPower U l z -
      2*(l : ℝ)*textbookLangevinHamiltonian U z^(l-1)*U z.1 := by
  sorry''',extra=['[EXTRA]真实沿动量p方向的导数及全部两个表达式，不仅登记事先给定的导数值；实际所有坐标平方和。'],missing='待真实有限和/幂函数导数与H定义短桥；无完整现成该两项组合包装，不扩建理论。')
lap=r'''\[\Delta_p\varphi=l(l-1)H^{l-2}\|p\|^2+N_clH^{l-1}\le l(l+N_c-1)H^{l-1}.\]'''
add('HamiltonianPowerMomentumLaplacian','6.4.4',253,[103],lap,copied(F,'textbookLangevinHamiltonianPower_momentum_laplacian','hamiltonianPowerMomentumLaplacian'),extra=['[EXTRA]完整实际坐标二阶导数和及正确等式，l≥1；原随后不等式单独原样保存，未据等式声称它成立。'],prior=['MolecularDynamics.textbookLangevinHamiltonianPower_momentum_laplacian'])
add('LaplacianBoundPrinted','6.4.4',253,[103,104],lap,'''theorem laplacianBoundPrinted : ∀ {n : ℕ} (U : (Fin n → ℝ) → ℝ),
  (∀ q, 1 ≤ U q) → ∀ (l : ℕ), 1 ≤ l → ∀ z : textbookLangevinPhase n,
    (∑ i : Fin n, deriv (deriv (fun t : ℝ ↦ textbookLangevinHamiltonianPower U l
      (z+t • ((0 : Fin n → ℝ), Pi.single i 1)))) 0) ≤
      (l : ℝ)*((l : ℝ)+(n : ℝ)-1)*textbookLangevinHamiltonian U z^(l-1) := by
  sorry''',verdict='NEEDS_HUMAN',issues=['用|p|²≤2H推导时遗漏系数2；一般原界不成立，具体52>40反例另给。'],missing='保留字面错误不等式，不能证明；正确完整上界另条。')
add('LaplacianBoundCounterexample','6.4.4',253,[104],lap,copied(F,'textbookLangevinLyapunov_printed_laplacian_bound_counterexample','laplacianBoundCounterexample'),extra=['[EXTRA]现成具体n=1、U=2、l=2、p=4反例52>40；仅差异证据，未用它替代原全量词界或完整Lyapunov论证。'],prior=['MolecularDynamics.textbookLangevinLyapunov_printed_laplacian_bound_counterexample'])
