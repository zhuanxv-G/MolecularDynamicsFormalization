from ch07_data import add

add('FirstOrderOperator','7.8',291,
r'''By composing the semigroup operators
\[\exp(h\widehat{\mathcal L}_{[XYZ]}^\dagger)=\exp(h\mathcal L_Z^\dagger)\exp(h\mathcal L_Y^\dagger)\exp(h\mathcal L_X^\dagger),\]
and computing the terms in the BCH expansion, we have
\[\widehat{\mathcal L}_{[XYZ]}^\dagger=\mathcal L_{LD}^\dagger+h\mathcal L_{1,[XYZ]}^\dagger+O(h^2),\]
where
\[\mathcal L_{1,[XYZ]}^\dagger=-\frac12([\mathcal L_X^\dagger,\mathcal L_Y^\dagger]+[\mathcal L_X^\dagger,\mathcal L_Z^\dagger]+[\mathcal L_Y^\dagger,\mathcal L_Z^\dagger]).\tag{7.20}\]
The first order correction function for this scheme is then given by the particular solution to the PDE,
\[\mathcal L_{LD}^\dagger(f_{1,[XYZ]}\rho_\beta)=-\mathcal L_{1,[XYZ]}^\dagger\rho_\beta.\tag{7.21}\]''',
'''def firstOrderOperator {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) : R :=
  (-1/2 : ℝ) • (comm X Y+comm X Z+comm Y Z)
theorem firstOrderOperator_coefficient {R : Type*} [Ring R] [Algebra ℝ R] (X Y Z : R) :
    PowerSeries.coeff 1 (formalModifiedGenerator (threeStage X Y Z)) = firstOrderOperator X Y Z := by
  sorry
def correctionEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L L1 : Module.End ℝ E) (ρ ρf : E) : Prop := L ρf = -L1 ρ''',label='(7.20)–(7.21)',missing='直接系数归约的短路线超过时间盒；保留未证。',
extra=['前向组合采用Z,Y,X顺序；正式级数系数推论覆盖所有六个排列，L0为三者和。修正方程为必要形式方程，可解性独立。'])

add('HomogeneousNormalization','7.8',291,
r'''The general solution of (7.21) will consist of the sum of the homogeneous solution $f_{1,[XYZ]}^{[HS]}(q,p)$ and particular solution $f_{1,[XYZ]}^{[PS]}(q,p)$ in the usual way. However, since $\mathcal L_{LD}^\dagger\vartheta=0$ has as its only solution $\vartheta\propto\rho_\beta$, the homogeneous solution of (7.21) is $f_{1,[XYZ]}^{[HS]}(q,p)=c$, for some constant $c$. Our assumption that $\langle f_{1,[XYZ]}\rangle=0$ means that $c=-\langle f_{1,[XYZ]}^{[PS]}\rangle$.''',
'''theorem homogeneousNormalization {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (ρ u v rhs : E)
    (hker : ∀ w, L w = 0 → ∃ c : ℝ, w = c • ρ)
    (hu : L u = rhs) (hv : L v = rhs) : ∃ c : ℝ, u = v+c • ρ := by
  obtain ⟨c,hc⟩ := hker (u-v) (by rw [map_sub,hu,hv,sub_self])
  exact ⟨c,by rw [← hc]; abel⟩
theorem centeredParticular (μ : Measure Ω) [IsProbabilityMeasure μ] (f : Ω → ℝ)
    (hf : Integrable f μ) : (∫ x, f x-(∫ y, f y ∂μ) ∂μ) = 0 := by
  rw [integral_sub hf (integrable_const _)]
  simp''',
extra=['核恰为ρ的一维空间是明确前提；不把Langevin核唯一性当作已证明。第二条为实际概率归一化的中心化恒等式。'])

add('CommutatorPermutationRelations','7.8.1',292,
r'''\[([\mathcal L_O^\dagger,\mathcal L_A^\dagger]+[\mathcal L_O^\dagger,\mathcal L_B^\dagger])\rho_\beta=[\mathcal L_O^\dagger,\mathcal L_A^\dagger+\mathcal L_B^\dagger]\rho_\beta=0.\]
\[\mathcal L_{1,[ABO]}^\dagger\rho_\beta=\mathcal L_{1,[OAB]}^\dagger\rho_\beta=-\mathcal L_{1,[OBA]}^\dagger\rho_\beta=-\mathcal L_{1,[BAO]}^\dagger\rho_\beta=-\frac12[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta.\tag{7.22}\]
\[f_{1,[ABO]}=f_{1,[OAB]}=-f_{1,[OBA]}=-f_{1,[BAO]}.\tag{7.23}\]
\[\mathcal L_{1,[AOB]}^\dagger\rho_\beta=-\mathcal L_{1,[BOA]}^\dagger\rho_\beta=-\frac12[\mathcal L_A^\dagger-\mathcal L_B^\dagger,\mathcal L_O^\dagger]\rho_\beta+\mathcal L_{1,[ABO]}^\dagger\rho_\beta.\tag{7.24}\]''',
'''theorem commutatorPermutationRelations {E : Type*} [AddCommGroup E] [Module ℝ E]
    (A B O : Module.End ℝ E) (ρ : E) (hO : O ρ = 0) (hH : (A+B) ρ = 0) :
    (comm O A+comm O B) ρ = 0 ∧
    firstOrderOperator A B O ρ = firstOrderOperator O A B ρ ∧
    firstOrderOperator A B O ρ = -firstOrderOperator O B A ρ ∧
    firstOrderOperator A B O ρ = -firstOrderOperator B A O ρ ∧
    firstOrderOperator A B O ρ = (-1/2 : ℝ) • comm A B ρ ∧
    firstOrderOperator A O B ρ = -firstOrderOperator B O A ρ ∧
    firstOrderOperator A O B ρ = (-1/2 : ℝ) • comm (A-B) O ρ+firstOrderOperator A B O ρ := by
  sorry''',label='(7.22)–(7.24)',
extra=['实际线性作用与Oρ=0,(A+B)ρ=0明示。修正函数的符号关系还需统一零均值和核唯一性；本条只证明/陈述交换子与右端项关系，函数关系列缺口。'],
scope='首式及(7.22),(7.24)全部算符作用关系；(7.23)需归一解唯一性桥，未另作Lean定理。',
missing='线性算符非交换代数作用桥接；本轮保留未证，不建设一般弱误差理论。')

add('GibbsDerivativeIdentities','7.8.1','292–293',
r'''If we define the function $g(q,p)$ as $g(q,p)=\beta p^TM^{-1}\nabla U(q)$, then through simple computation we have
\[\mathcal L_A^\dagger\rho_\beta=-\mathcal L_B^\dagger\rho_\beta=g(q,p)\rho_\beta.\]
\[[\mathcal L_A^\dagger,\mathcal L_B^\dagger]\rho_\beta=-(\mathcal L_A^\dagger+\mathcal L_B^\dagger)(g\rho_\beta)=(\mathcal L_O^\dagger-\mathcal L_{LD}^\dagger)(g\rho_\beta).\]
For a function $\psi(q)$ purely of position, we have
\[\mathcal L_{LD}^\dagger(\psi(q)\rho_\beta)=-(p^TM^{-1}\nabla\psi(q))\rho_\beta(q,p),\]
and hence we can compute
\[\mathcal L_O^\dagger(g(q,p)\rho_\beta)=\gamma\rho_\beta(-p\cdot\nabla_pg+\beta^{-1}\nabla_p\cdot M\nabla_pg)
=-\gamma g\rho_\beta=\gamma\beta\mathcal L_{LD}^\dagger(U(q)\rho_\beta).\]''',
'''def mechanicalHamiltonian (m : V n) (U : V n → ℝ) (x : Phase n) : ℝ :=
  (∑ i, x.2 i^2/(2*m i))+U x.1
def gibbsWeight (m : V n) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  Real.exp (-β*mechanicalHamiltonian m U x)
def gFunction (m : V n) (U : V n → ℝ) (β : ℝ) (x : Phase n) : ℝ :=
  β*∑ i, x.2 i/m i*gradient U x.1 i
def phaseO (m : V n) (γ β : ℝ) (ρ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ouForward m γ β⁻¹ (fun p ↦ ρ (x.1,p)) x.2
def phaseLD (m : V n) (U : V n → ℝ) (γ β : ℝ) (ρ : Phase n → ℝ) : Phase n → ℝ :=
  aForward m ρ+bForward U ρ+phaseO m γ β ρ
theorem gibbsDerivativeIdentities (m : V n) (U ψ : V n → ℝ) (β γ : ℝ)
    (hm : ∀ i, 0 < m i) (hβ : 0 < β) (hU : ContDiff ℝ ⊤ U) (hψ : ContDiff ℝ ⊤ ψ) :
    let ρ := gibbsWeight m U β
    let g := gFunction m U β
    aForward m ρ = g*ρ ∧ bForward U ρ = -(g*ρ) ∧
    phaseLD m U γ β (fun x ↦ ψ x.1*ρ x) =
      (fun x ↦ -(∑ i, x.2 i/m i*gradient ψ x.1 i)*ρ x) ∧
    phaseO m γ β (g*ρ) = (fun x ↦ -γ*g x*ρ x) ∧
    phaseO m γ β (g*ρ) = (fun x ↦ γ*β*phaseLD m U γ β (fun y ↦ U y.1*ρ y) x) := by
  sorry''',
extra=['ρ为未归一Gibbs权，所有微分等式对常数归一化同样成立；实际概率还要正有限配分积分。所有质量正、β>0、光滑资格明示。','覆盖g、A/B作用、纯位置ψ作用及O(gρ)两种等价写法；交换子作用与中间OU共轭式在原文登记但另列覆盖缺口。'],
missing='实际多维Gibbs指数微分、二阶OU乘积法则与求和桥，超过短证明；不建SDE解或遍历理论。')
