from ch07_data import add

add('PerturbationCoefficientEquation','7.7.3','289–290',
r'''Inserting this ansatz into the stationary Fokker-Planck equation $\widehat{\mathcal L}^\dagger\widehat\rho=0$, we obtain
\[(\mathcal L_{LD}^\dagger+h\mathcal L_1^\dagger+h^2\mathcal L_2^\dagger+O(h^3))(\rho_\beta[1+hf_1+h^2f_2+O(h^3)])=0.\]
Combining like powers, we have at zero’th order, the equation $\mathcal L_{LD}^\dagger\rho_\beta=0$.
At first order we obtain
\[\mathcal L_{LD}^\dagger(\rho_\beta f_1)+\mathcal L_1^\dagger\rho_\beta=0.\tag{7.19}\]''',
'''def actionCoefficient {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E) (k : ℕ) : E :=
  ∑ j ∈ Finset.range (k+1), L j (ρ (k-j))
theorem perturbationCoefficientEquation {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : ℕ → Module.End ℝ E) (ρ : ℕ → E)
    (h0 : actionCoefficient L ρ 0 = 0) (h1 : actionCoefficient L ρ 1 = 0) :
    L 0 (ρ 0) = 0 ∧ L 0 (ρ 1)+L 1 (ρ 0) = 0 := by
  constructor
  · simpa [actionCoefficient] using h0
  · simpa [actionCoefficient, Finset.sum_range_succ] using h1''',label='(7.19)',
proof='Insert the two formal series into the stationary equation and combine like powers of h.',
extra=['在真实线性作用的形式系数卷积上推导0阶和1阶必要方程；并未由这些必要方程证明原离散链存在不变分布。'])

add('ObservableCorrectionExpansion','7.7.3',290,
r'''For some observable $\vartheta(q,p)$, we have that
\[\langle\vartheta\rangle_h=\int_{\mathcal D}\vartheta(q,p)\widehat\rho(q,p)d\omega
=\int_{\mathcal D}\vartheta(q,p)\rho_\beta(q,p)(1+hf_1(q,p)+h^2f_2(q,p)+\cdots)d\omega
=\langle\vartheta\rangle+h\langle\vartheta f_1\rangle+h^2\langle\vartheta f_2\rangle+\cdots.\]''',
'''theorem observableCorrectionExpansion (ν : Measure Ω) (φ ρ f1 f2 : Ω → ℝ) (h : ℝ)
    (h0 : Integrable (fun x ↦ φ x*ρ x) ν)
    (h1 : Integrable (fun x ↦ φ x*ρ x*f1 x) ν)
    (h2 : Integrable (fun x ↦ φ x*ρ x*f2 x) ν) :
    (∫ x, φ x*ρ x*(1+h*f1 x+h^2*f2 x) ∂ν) =
      (∫ x, φ x*ρ x ∂ν)+h*(∫ x, φ x*ρ x*f1 x ∂ν)+h^2*(∫ x, φ x*ρ x*f2 x ∂ν) := by
  have heq : ∀ x, φ x*ρ x*(1+h*f1 x+h^2*f2 x) =
      (φ x*ρ x+h*(φ x*ρ x*f1 x))+h^2*(φ x*ρ x*f2 x) := by intro x; ring
  simp_rw [heq]
  have hout := integral_add (h0.add (h1.const_mul h)) (h2.const_mul (h^2))
  have hin := integral_add h0 (h1.const_mul h)
  simp only [Pi.add_apply] at hout hin
  rw [hout, hin, integral_const_mul, integral_const_mul]''',
proof='Distribute the product and use linearity of integration at each finite order.',
extra=['完整覆盖0–2阶有限截断积分；无限级数交换与实际误差余项仍需支配收敛及弱展开理论，明确不声称已证。'])

add('PerturbativeSolvabilityCaution','7.7.3',290,
r'''It will be difficult to solve the perturbation equation (7.19) in general, although its linearity and the fact that $\mathcal L_{LD}^\dagger$ (with our assumptions) has a compact resolvent (and therefore a discrete spectrum) together imply that if the perturbation can be bounded, then it should be possible to solve for the correction function. We expect that this solution should be stable with respect to perturbation (and exponentially attracting). This also implies global existence (for all positive time) of the semigroup defining the solution of the time-dependent problem. We do not provide such a rigorous result here but simply plunge ahead, in the best tradition of applied mathematics, to obtain a perturbative expansion; verification of our results must therefore be obtained by numerical experiment, a posteriori.''',
'''def correctionSolvable {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (rhs : E) : Prop := ∃ u : E, L u = rhs''',kind='definition',
extra=['原书明确未给严格可解性/指数吸引/半群全局存在定理；保留其全部原文主张并定义可解性目标。','不能由紧预解式和有界扰动单独推出任意rhs可解；核方向的Fredholm相容条件、定义域与谱隙均是覆盖缺口。'],
scope='可解性目标与原书未证明的预期已登记；指数稳定和全局半群存在不作为已获定理。',verdict='NEEDS_HUMAN')
