"""Second eight records; inactive until first-batch compilation is accepted."""
from ch06_data import add,copied,proposition,D,NS
add('LogTemperature','6.1.2','215–216',[5,6],r'''The temperature of a system $T$, is defined as $1/T:=\partial S/\partial E$, giving, when the system is in thermal equilibrium,
\[\frac{d}{dE_A}\ln Z_A(E_A)=\frac{d}{dE_B}\ln Z_B(E_B)=\frac1{k_BT}=: \beta.\tag{6.2}\]''',
'''theorem logTemperature : ∀ (kB : ℝ) (Z : ℝ → ℝ) (energy : ℝ),
  DifferentiableAt ℝ Z energy → 0 < Z energy →
  deriv (fun e ↦ Real.log (Z e)) energy = deriv Z energy / Z energy ∧
  MolecularDynamics.Chapter06Review.inverseTemperature
    (MolecularDynamics.Chapter06Review.entropy kB Z) energy = kB * deriv Z energy / Z energy := by
  sorry''',extra=['[EXTRA]partition在该能量可微且正；本条保留温度与log partition的实际微分关系，系统之间平衡关系由EntropyEquilibrium保留。'],missing='待HasDerivAt.log与常数乘法短桥。')
add('BathMeanValue','6.1.2',216,[7],r'''we (naively) apply the mean value theorem to $S_B$ to obtain
\[S_B(E-s)=S_B(E)-S'_B(\xi)s.\]''',
'''theorem bathMeanValue : ∀ (S : ℝ → ℝ) (energy s : ℝ),
  ContDiff ℝ 1 S → 0 < s → ∃ ξ ∈ Ioo (energy-s) energy,
    S (energy-s) = S energy - deriv S ξ * s := by
  sorry''',extra=['[EXTRA]C¹熵且s>0；只保留真实均值定理，不把ξ处导数改为E处导数。'],missing='待现成实均值定理短桥。')
add('BathTaylorEstimate','6.1.2',216,[7],r'''Since $Z_B(E-s)=\exp(S_B(E-s)/k_B)$, and $s\ll E$, we (naively) apply the mean value theorem to $S_B$.''',proposition('bathTaylor_statement','bathTaylorEstimate'),kind='extra_claim',extra=['[EXTRA]对原页热浴近似给出可核验的局部C²一阶展开及C·s²余项；这是额外严格表述，完整字面Boltzmann关系仍为NEEDS_HUMAN。'],missing='待现成C² Taylor余项；无桥接则保留sorry，不建设热力学极限。')
add('BoltzmannConstantSlope','6.1.2',216,[7],r'''and from $S'_B(\xi)=1/T$, we obtain
\[Z_B(E-s)\propto\exp(-\beta s),\qquad \beta=(k_BT)^{-1}.\]''',
'''theorem boltzmannConstantSlope : ∀ (S : ℝ → ℝ) (energy kB β : ℝ),
  Differentiable ℝ S → 0 < kB → (∀ e, deriv S e = kB * β) →
  ∀ s, Real.exp (S (energy-s)/kB) / Real.exp (S energy/kB) = Real.exp (-β*s) := by
  sorry''',kind='extra_claim',extra=['[EXTRA]理想恒温热浴明确要求熵导数在整个实轴恒定；不从固定能量的温度偷推出该条件，不将本条代替字面版。'],missing='待恒导数仿射函数与Real.exp_sub的短桥。')
add('CanonicalCDFPrinted','6.1.2',216,[],r'''On the other hand the probability for the active system to have energy $\leq\alpha$ is the same as the probability of the bath having energy $\geq E-\alpha$, this must be
\[P(\alpha)=\Pr\{E_B\geq E-\alpha\}\propto\int_0^\alpha Z_B(E-s)ds.\]
Thus we have $P(\alpha)\propto\int_0^\alpha\exp(-\beta s)ds$.''',
'''theorem canonicalCDFPrinted : ∀ (ZA ZB : ℝ → ℝ) (energy α : ℝ),
  Continuous ZA → Continuous ZB → (∀ e, 0 < ZA e) → (∀ e, 0 < ZB e) →
  0 < α → α < energy →
  (∫ s in 0..α, ZA s * ZB (energy-s)) / (∫ s in 0..energy, ZA s * ZB (energy-s)) =
  (∫ s in 0..α, ZB (energy-s)) / (∫ s in 0..energy, ZB (energy-s)) := by
  sorry''',verdict='NEEDS_HUMAN',issues=['[ERRATUM?]页末能量密度含ZA(α)，此前CDF却省略ZA(s)权重；一般ZA下两归一化CDF不相等。'],explanation='保留与真实分别计数的能量CDF相比较的字面关系；不从启发式省略权重伪造精确概率定律。',missing='原书启发式概率论证的ZA权重及热浴误差需人工裁定；不证明字面关系。')
add('CanonicalEnergyDensity','6.1.2',216,[8],r'''The volume (or number, in the case of discrete systems) of states available at energy $\alpha$ is $Z_A(\alpha)$. Thus the energy density of the canonical ensemble at energy level $\alpha$ is proportional to $Z_A(\alpha)\exp(-\beta\alpha)$.''',copied(D,'canonicalEnergyDensity'),kind='definition',context=['完整能量权重ZA保留，实轴能量积分归一化；若能量域限制非负，则ZA在负半轴取零；正有限分母才有概率密度解释。'])
add('EntropyFunctional','6.1.3',217,[9],r'''density is as a stationary point of the Gibbs-Boltzmann entropy
\[S=-k_B\int\rho\ln\rho\,d\omega,\]
subject to the constraints $\int\rho(z)d\omega=1$, $\int H(z)\rho(z)d\omega=\bar E$.''',copied(D,'entropyFunctional'),kind='definition',context=['实际Bochner积分；约束不是熵定义的自动结论，ConstrainedEntropyModel保存两个约束；0log0总定义不计熵可积性证明。'])
add('ConstrainedEntropyModel','6.1.3',217,[9,10],r'''Using the method of Lagrange multipliers, we seek stationary solutions of
\[V=S/k_B-\lambda\left[\int\rho(z)d\omega-1\right]-\beta\left[\int H(z)\rho(z)d\omega-\bar E\right]\]
with respect to the choice of density $\rho$ and coefficients $\lambda$ and $\beta$. The resulting equations for the maximizing density are obtained by variational differentiation:
\[\frac{\delta V}{\delta\rho}=0,\quad\int\rho(z)d\omega=1,\quad\int H(z)\rho(z)d\omega=\bar E.\]''',
'''def constrainedEntropyModel {D : Type*} [MeasurableSpace D] (ν : Measure D)
    (H ρ : D → ℝ) (kB lambdaParam β meanEnergy : ℝ) : ℝ × Prop :=
  (MolecularDynamics.Chapter06Review.entropyFunctional ν kB ρ / kB -
    lambdaParam * ((∫ x, ρ x ∂ν)-1) - β * ((∫ x, H x * ρ x ∂ν)-meanEnergy),
    (∫ x, ρ x ∂ν) = 1 ∧ (∫ x, H x * ρ x ∂ν) = meanEnergy)''',kind='definition',context=['完整常数项和两个约束保留；实际变分导数/驻点结论另见EntropyFirstVariation与EntropyVariation；kB≠0才按原物理解释约去。'])
