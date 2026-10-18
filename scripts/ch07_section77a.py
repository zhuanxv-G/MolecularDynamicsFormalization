from ch07_data import add

add('ModifiedGenerator','7.7',284,
r'''We begin by defining the generator $\widehat{\mathcal L}$ associated to the propagation of averages under the numerical method for an SDE. We think of this generator as a perturbation of the exact Langevin dynamics generator $\mathcal L_{LD}$, or
\[\widehat{\mathcal L}=\mathcal L_{LD}+h\mathcal L_1+h^2\mathcal L_2+h^3\mathcal L_3+O(h^4).\tag{7.16}\]
However, the operators involved are not equivalent to the operators that would arise from any stochastic differential equation (see [403]), so we must give up the direct analogy between the formal series and continuous SDE models (which is available in the deterministic setting).''',
'''def formalModifiedGenerator {R : Type*} [Ring R] [Algebra ℝ R]
    (S : PowerSeries R) : PowerSeries R :=
  PowerSeries.mk (fun k ↦ PowerSeries.coeff (k+1) (MolecularDynamics.textbookFormalOperatorLogarithm S))
def formalGeneratorExpansion {R : Type*} [Ring R] [Algebra ℝ R]
    (L : PowerSeries R) (L0 L1 L2 L3 : R) : Prop :=
  PowerSeries.coeff 0 L = L0 ∧ PowerSeries.coeff 1 L = L1 ∧
  PowerSeries.coeff 2 L = L2 ∧ PowerSeries.coeff 3 L = L3''',kind='definition',label='(7.16)',
extra=['只取形式幂级数系数；O(h⁴)在此意为0–3阶系数相等，不宣称无界算符级数收敛，也不声称是另一SDE的生成元。'])

add('InvariantDensityExpansion','7.7',284,
r'''We write this invariant distribution as a perturbation of the (target) canonical distribution
\[\widehat\rho=\rho_\beta[1+hf_1+h^2f_2+h^3f_3+O(h^4)],\tag{7.17}\]
with each correction function $f_k(q,p)$ satisfying
\[\int_{\mathcal D} f_k(q,p)\rho_\beta(q,p)d\omega=0,\]
ensuring a useful equivalence in the partition function
\[\int_{\mathcal D}\widehat\rho(q,p)d\omega=\int_{\mathcal D}\rho_\beta(q,p)d\omega.\]
Our computed average is therefore $\langle\phi\rangle_h\stackrel{\rm def}=\int_{\mathcal D}\phi(q,p)\widehat\rho(q,p)d\omega$.''',
'''def densityExpansion (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ) : ℕ → Ω → ℝ
  | 0 => ρ
  | k+1 => fun x ↦ ρ x*f (k+1) x
def centeredCorrections (μ : Measure Ω) (f : ℕ → Ω → ℝ) : Prop :=
  IsProbabilityMeasure μ ∧ ∀ k, 0 < k → Integrable (f k) μ ∧ (∫ x, f k x ∂μ) = 0
def computedAverage (ν : Measure Ω) (φ ρhat : Ω → ℝ) : ℝ := ∫ x, φ x*ρhat x ∂ν
theorem densityExpansion_zeroMass (ν : Measure Ω) (ρ : Ω → ℝ) (f : ℕ → Ω → ℝ)
    (hρ : Integrable ρ ν)
    (hf : ∀ k, 0 < k → Integrable (fun x ↦ ρ x*f k x) ν ∧ (∫ x, ρ x*f k x ∂ν) = 0) :
    ∀ k, (∫ x, densityExpansion ρ f k x ∂ν) = if k = 0 then ∫ x, ρ x ∂ν else 0 := by
  intro k
  cases k with
  | zero => simp [densityExpansion]
  | succ k => simpa [densityExpansion] using (hf (k+1) (Nat.zero_lt_succ k)).2''',kind='definition',label='(7.17)',
extra=['系数零质量不等于任意h的截断密度非负；概率密度仍须非负、可积且归一。余项质量也为零或完整级数可交换积分时才推出精确总质量一致。','此处证明所有形式系数的质量约束；未把有限截断表达式假称实际不变概率。'])

add('ExactABOPropagators','7.7.1',285,
r'''\[(e^{t\mathcal L_A}\phi)(q,p)=\phi(q+tM^{-1}p,p),\qquad
(e^{t\mathcal L_B}\phi)(q,p)=\phi(q,p-t\nabla U(q)),\]
\[(e^{t\mathcal L_O}\phi)(q,p)=\int_{\mathcal P}\phi(q,e^{-\gamma t}p+\zeta M^{1/2}x)\frac{e^{-|x|^2/2}}{(2\pi)^{N_c/2}}dx,\]
where $\zeta=[k_BT(1-e^{-2\gamma t})]^{1/2}$.''',
'''def propagateA (m : V n) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ driftStep m t
def propagateB (U : V n → ℝ) (t : ℝ) (φ : Phase n → ℝ) : Phase n → ℝ := φ ∘ kickStep U t
def propagateO (m : V n) (γ θ t : ℝ) (φ : Phase n → ℝ) (x : Phase n) : ℝ :=
  ∫ R, φ (ouStep m γ θ t R x) ∂Measure.pi (fun _ : Fin n ↦ gaussianReal 0 1)''',kind='definition',
extra=['O用实际独立标准正态乘积测度；θ>0、γ≥0、t≥0、正质量时对应OU噪声。期望用于可积φ，未把不可积函数的默认积分当物理期望。','半群律及实际SDE生成元识别需OU转移律与Markov理论，本条只定义固定时刻传播子。'])

add('OperatorOrderReversal','7.7.1',285,
r'''For example, for the method labelled by the string $[ABAO]$, we have
\[\exp(h\widehat{\mathcal L}_{[ABAO]})=\exp((h/2)\mathcal L_A)\exp(h\mathcal L_B)\exp((h/2)\mathcal L_A)\exp(h\mathcal L_O),\]
where importantly note the apparent reversal of the sequence of products, known as the vertauschungssatz. We will find it more convenient to work with the adjoint of the perturbed generator, denoted $\widehat{\mathcal L}^\dagger$, which we may compute as
\[\exp(h\widehat{\mathcal L}_{[ABAO]}^\dagger)=\exp(h\mathcal L_O^\dagger)\exp((h/2)\mathcal L_A^\dagger)\exp(h\mathcal L_B^\dagger)\exp((h/2)\mathcal L_A^\dagger).\]''',
'''theorem pullback_order {E F : Type*} (A B : E → E) (φ : E → F) :
    φ ∘ (B ∘ A) = (φ ∘ B) ∘ A := rfl
def abaoBackward (m : V n) (U : V n → ℝ) (γ θ h : ℝ) (φ : Phase n → ℝ) :=
  propagateA m (h/2) (propagateB U h (propagateA m (h/2) (propagateO m γ θ h φ)))''',
extra=['覆盖反向拉回组合恒等式和ABAO的全部四段期望传播式；其与前面随机abao映射期望相等仍需推前积分桥。','伴随前向传播子的四段顺序记录在原文；独立定义实际密度伴随的函数空间和边界条件列为覆盖缺口。'],
scope='确定性拉回顺序及ABAO后向传播定义；无界算符指数/伴随识别尚缺。')

add('StationaryModifiedPDE','7.7.1','285–286',
r'''Under the propagation of the numerical scheme (or the discretized dynamics), the Fokker-Planck equation gives us that the evolution of a density of points $\rho$ is given by
\[\frac\partial{\partial t}\rho(z,t)=\widehat{\mathcal L}^\dagger\rho,\]
with the important case of its invariant distribution satisfying the partial differential equation
\[\widehat{\mathcal L}^\dagger\widehat\rho=0.\]''',
'''def formalDensityEvolution {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (L : E →L[ℝ] E) (ρ : ℝ → E) : Prop := ∀ t, HasDerivAt ρ (L (ρ t)) t
def stationaryModifiedDensity {E : Type*} [AddCommGroup E] [Module ℝ E]
    (L : Module.End ℝ E) (ρ : E) : Prop := L ρ = 0''',kind='definition',
extra=['真实离散转移一般不嵌入连续Markov半群，修改方程仅为形式分析；不宣称任意离散SDE方法有上述真实Fokker–Planck演化。','Markov半群资格、密度正性归一、无界生成元定义域及嵌入性尚缺；此处仅明确定义方程，不证明等价。'])

add('TwoOperatorBCH','7.7.1',286,
r'''Recall that for linear operators $X$ and $Y$, we can write the composition of their exponentials as
\[\exp(hX)\exp(hY)=\exp(hZ),\]
where we have the expansion
\[Z=X+Y+\frac h2[X,Y]+\frac{h^2}{12}([X,[X,Y]]+[Y,[Y,X]])+O(h^3).\]
The notation $[X,Y]\stackrel{\rm def}=XY-YX$ represents the commutator of the operators $X$ and $Y$.''',
'''def comm {R : Type*} [Ring R] (X Y : R) : R := X*Y-Y*X
def twoStage {R : Type*} [Ring R] [Algebra ℝ R] (X Y : R) : PowerSeries R :=
  MolecularDynamics.textbookFormalOperatorExponential X * MolecularDynamics.textbookFormalOperatorExponential Y
theorem twoOperatorBCH {R : Type*} [Ring R] [Algebra ℝ R] (X Y : R) :
    PowerSeries.coeff 0 (formalModifiedGenerator (twoStage X Y)) = X+Y ∧
    PowerSeries.coeff 1 (formalModifiedGenerator (twoStage X Y)) = (1/2 : ℝ) • comm X Y ∧
    PowerSeries.coeff 2 (formalModifiedGenerator (twoStage X Y)) =
      (1/12 : ℝ) • (comm X (comm X Y)+comm Y (comm Y X)) := by
  sorry''',
extra=['任意实代数中的非交换形式幂级数；不要求无界算符指数收敛。本条完整记录所印0–2阶。'],
missing='已有log与exp低阶系数，但非交换乘积展开到三阶的桥接仍未证明；不建立一般BCH理论。')

add('TaylorRemainder','7.7.1','286–287',
r'''We can make use of Taylor’s theorem to write the identity
\[P_h=P_0+h\left.\frac{dP_t}{dt}\right|_{t=0}+\cdots+\frac{h^n}{n!}\left.\frac{d^nP_t}{dt^n}\right|_{t=0}
+\frac{h^{n+1}}{n!}\int_0^1(1-\lambda)^n\left.\frac{d^{n+1}P_t}{dt^{n+1}}\right|_{t=\lambda h}d\lambda,\]
for some finite truncation index $n\in\{1,2,3,\ldots\}$. Hence for observables of sufficient smoothness with compact support, this remainder term will remain bounded (see [223]).''',
'''theorem taylorRemainder (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) (h : ℝ) :
    F h = (∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0) +
      h^(k+1)/(Nat.factorial k : ℝ)*∫ t in (0 : ℝ)..1, (1-t)^k*iteratedDeriv (k+1) F (t*h) := by
  sorry
theorem taylorRemainder_bound (F : ℝ → ℝ) (k : ℕ) (hF : ContDiff ℝ (k+1) F) :
    Asymptotics.IsBigO (𝓝 (0 : ℝ))
      (fun h ↦ F h-∑ j ∈ Finset.range (k+1), h^j/(Nat.factorial j : ℝ)*iteratedDeriv j F 0)
      (fun h ↦ h^(k+1)) := by
  sorry''',
extra=['只覆盖作用于单个可观测量和点后的标量C^(n+1) Taylor恒等式及局部余项界；把ABO无界算符组合在紧支撑光滑测试函数上归约到这些假设仍是覆盖缺口。'],
missing='需要Mathlib实函数Taylor积分余项桥；不建立通用弱误差展开。')
