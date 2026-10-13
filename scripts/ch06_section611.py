"""First eight obligations, original printed 214–216 / PDF235–237 inspected."""
from ch06_data import add,copied,proposition,D,NS,EXCLUDED
add('Microcanonical','6.1.1',214,[1],r'''The density function may then be represented by a Dirac delta function as follows:
\[\rho_{\rm mc}=Z^{-1}\delta[H-E],\qquad Z=\int_D\delta[H-E]d\omega.\]''',
'''def microcanonical {n : ℕ} (H : MolecularDynamics.Chapter05Review.E n → ℝ) (energy : ℝ) :=
  MolecularDynamics.Chapter05Review.microMeasure H energy''',kind='definition',context=['δ[H−E]是正则能量面上的1/‖∇H‖加权Hausdorff测度，不是环境Lebesgue密度；沿用第5章真实microMeasure定义。','固定N,V,E及正则能量、正有限partition才有概率解释；不重新证明coarea识别。'])
add('Entropy','6.1.2',214,[2],r'''In terms of a microcanonical system, the entropy is enshrined in the famous formula that appears on Boltzmann's tombstone:
\[S=k_B\ln Z.\tag{6.1}\]''',copied(D,'entropy'),kind='definition',label='(6.1)',context=['kB约1.38×10⁻²³ J/K为物理常量记号；Z>0时log具有熵解释；热力学第二定律为物理建模原则，非本条Lean结论。'])
add('IndependentPartition','6.1.2',215,[3],r'''We denote by $Z(E_A,E_B)$ the total number of states the system can occupy with systems A and B having energies $E_A$ and $E_B$, respectively. We make use of our assumption that the two systems do not exchange particles so that the total number of states the combined system can be found in depends solely on the energies of the two independent systems, i.e.,
\[Z(E_A,E_B)=Z_A(E_A)\times Z_B(E_B).\]''',proposition('independentPartition_statement'),extra=['[EXTRA]独立、分别固定能量的真实加权能量面测度乘积；不将固定总能量partition的卷积偷换为乘积。'],missing='待Measure.prod_univ等现成测度定理短桥；不构建微正则coarea理论。')
add('EntropyAdditivity','6.1.2',215,[3],r'''Taking logarithms and replacing the value for $E_B$ by $E-E_A$, we have
\[\ln Z(E_A,E-E_A)=\ln Z_A(E_A)+\ln Z_B(E-E_A).\]''',proposition('entropyAdditivity_statement'),extra=['[EXTRA]两个正实数partition；结论同时保留乘kB的熵加法，kB=1包含所印log式。'],missing='待Real.log_mul及ring短证明。')
add('EntropyEquilibrium','6.1.2',215,[4],r'''This value of $E_A$ occurs where
\[\frac{d}{dE_A}\ln Z(E_A,E-E_A)=0,\]
or equivalently where
\[\frac{d}{dE_A}S_A=\frac{d}{dE_B}S_B,\]
where we have used Boltzmann's relation to express this in terms of the entropy.''',proposition('entropyEquilibrium_statement'),extra=['[EXTRA]固定总能量；两个熵函数在相应能量可微，内点局部最大为前提；实际导数相等为结论，不假设平衡导数关系。'],missing='待局部极值导数零、真实链式法则及导数唯一性短证明。')
add('Temperature','6.1.2',215,[5],r'''The temperature of a system $T$, is defined as
\[\frac1T:=\frac{\partial S}{\partial E}.\]''',copied(D,'temperature'),kind='definition',context=['inverseTemperature S E=deriv S E；temperature取其倒数；实际导数非零才得到倒数解释。'])
add('InverseThermal','6.1.2',216,[6],r'''giving, when the system is in thermal equilibrium,
\[\frac{d}{dE_A}\ln Z_A(E_A)=\frac{d}{dE_B}\ln Z_B(E_B)=\frac1{k_BT}=: \beta.\tag{6.2}\]
We shall refer to the quantity $\beta$ as the system's inverse or reciprocal temperature.''',copied(D,'inverseThermal'),kind='definition',label='(6.2)',context=['β=(kBT)⁻¹定义；等温平衡关系的导数等式另见EntropyEquilibrium与LogTemperature，不以定义计为关系已证。','物理解释要求kB>0,T>0。'])
add('BathTaylor','6.1.2',216,[7],r'''Since $Z_B(E-s)=\exp(S_B(E-s)/k_B)$, and $s\ll E$, we (naively) apply the mean value theorem to $S_B$ to obtain
\[S_B(E-s)=S_B(E)-S'_B(\xi)s,\]
and from $S'_B(\xi)=1/T$, we obtain
\[Z_B(E-s)\propto\exp(-\beta s).\]''',
'''theorem bathBoltzmannPrinted : ∀ (S : ℝ → ℝ) (energy kB β : ℝ),
  ContDiff ℝ 2 S → 0 < energy → 0 < kB → deriv S energy = kB * β →
  (∀ s : ℝ, 0 < s → ∃ ξ ∈ Icc (energy-s) energy,
    S (energy-s) = S energy - deriv S ξ * s) ∧
  (∀ s ∈ Icc (0 : ℝ) energy,
    Real.exp (S (energy-s)/kB) / Real.exp (S energy/kB) = Real.exp (-β*s)) := by
  sorry''',extra=['[EXTRA]熵C²、正热浴能量及kB；β以原页固定温度关系表示，不假设所需中间点导数恒定。'],issues=['[ERRATUM?]原书脚注3承认热浴推导不精确；S′(ξ)=1/T通常只能作为大热浴近似，完整精确Boltzmann因子保留字面NEEDS_HUMAN。'],verdict='NEEDS_HUMAN',explanation='保留均值定理与精确Boltzmann因子的完整印刷论证；固定能量导数不推出所有中间点导数恒定，不能把精确关系计为本地PASS。严格均值定理/局部Taylor余项另列[EXTRA]。',missing='热浴近似缺量化误差/热力学极限；本条不证明，不恢复封存长证明。')
EXCLUDED += [dict(printed_page='211–214',pdf_page='232–235',reason='引言关于热浴、环境、瞬态/稳态和模拟的物理动机、图6.1与历史说明为定性内容；N/V粒子密度、NVE/NVT及固定N,V,E为context notation，数学微正则密度公式已保留。')]
