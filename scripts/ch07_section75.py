from ch07_data import add, EXCLUDED

add('PerturbedHamiltonian','7.5',279,
r'''We consider sampling canonically the Hamiltonian
\[H(q,p)=p^2/2+q^2/2+\epsilon q^4/4,\tag{7.13}\]
using Langevin dynamics, where $q,p\in\mathbb R$, with a small nonlinearity parameter $\epsilon>0$.''',
'''def perturbedPotential (ε q : ℝ) : ℝ := q^2/2+ε*q^4/4
def perturbedHamiltonian (ε : ℝ) (x : ℝ × ℝ) : ℝ := x.2^2/2+perturbedPotential ε x.1
def perturbedGibbs (ε : ℝ) : Measure (ℝ × ℝ) :=
  let w := fun x : ℝ × ℝ ↦ Real.exp (-perturbedHamiltonian ε x)
  volume.withDensity (fun x ↦ ENNReal.ofReal (w x/(∫ y, w y)))
def perturbedStep (s : Fin 4) (ε γ h R S : ℝ) : (ℝ × ℝ) → (ℝ × ℝ) :=
  let m : V 1 := fun _ ↦ 1
  let U : V 1 → ℝ := fun q ↦ perturbedPotential ε (q 0)
  scalarLift (if s = 0 then aboba m U γ 1 h (fun _ ↦ R)
    else if s = 1 then baoab m U γ 1 h (fun _ ↦ R)
    else if s = 2 then obabo m U γ 1 h (fun _ ↦ R) (fun _ ↦ S)
    else oabao m U γ 1 h (fun _ ↦ R) (fun _ ↦ S))
def perturbedStationary (s : Fin 4) (ε γ h : ℝ) (μ : Measure (ℝ × ℝ)) : Prop :=
  IsProbabilityMeasure μ ∧ MemLp (fun x ↦ x.1) 2 μ ∧ MemLp (fun x ↦ x.2) 2 μ ∧
  Measure.map (fun z : (ℝ × ℝ) × (ℝ × ℝ) ↦ perturbedStep s ε γ h z.2.1 z.2.2 z.1)
    (μ.prod ((gaussianReal 0 1).prod (gaussianReal 0 1))) = μ''',kind='definition',label='(7.13)',
extra=['后面所印系数取单位温度θ=1与单位质量；原段未显式写温度依赖，其他温度不声称覆盖。','分布是实际归一Gibbs权；ε>0时的可积归一性及动量独立Gaussian识别另列待证。'])

add('PerturbedErrorExpansion','7.5',280,
r'''We find that truncating the update equations to $O(\epsilon^3)$ is sufficient to explicitly resolve the leading order behavior of the error for these discretization schemes, and we give the differences between observed numerical averages and exact averages below:
\[\langle q^2\rangle_h^{[ABOBA]}-\langle q^2\rangle=\frac{3h^2\epsilon[48\epsilon-4+3\gamma^2(9\epsilon-1)]}{12\gamma^2+16}+O(\epsilon h^4+\epsilon^3h^2),\]
\[\langle q^2\rangle_h^{[BAOAB]}-\langle q^2\rangle=-\frac{9h^2\epsilon^2}{6\gamma^2+8}-\frac{3h^4\epsilon^2[6\gamma^4+19\gamma^2+16]}{8(3\gamma^2+4)^2}+O(\epsilon^2h^6+\epsilon^3h^2),\]
\[\langle q^2\rangle_h^{[OBABO]}-\langle q^2\rangle=h^2\left(\frac14+\frac{\epsilon[144\epsilon+81\epsilon\gamma^2-9\gamma^2-12]}{12\gamma^2+16}\right)+O(h^4+\epsilon^3h^2),\]
\[\langle q^2\rangle_h^{[OABAO]}-\langle q^2\rangle=-h^2\left(\frac14+\frac{18\epsilon^2}{12\gamma^2+16}\right)+O(h^4+\epsilon^3h^2).\tag{7.14}\]''',
'''def perturbedLeading (s : Fin 4) (γ ε h : ℝ) : ℝ :=
  if s = 0 then 3*h^2*ε*(48*ε-4+3*γ^2*(9*ε-1))/(12*γ^2+16)
  else if s = 1 then -9*h^2*ε^2/(6*γ^2+8)-3*h^4*ε^2*(6*γ^4+19*γ^2+16)/(8*(3*γ^2+4)^2)
  else if s = 2 then h^2*(1/4+ε*(144*ε+81*ε*γ^2-9*γ^2-12)/(12*γ^2+16))
  else -h^2*(1/4+18*ε^2/(12*γ^2+16))
def perturbedRemainder (s : Fin 4) (ε h : ℝ) : ℝ :=
  if s = 0 then ε*h^4+ε^3*h^2
  else if s = 1 then ε^2*h^6+ε^3*h^2 else h^4+ε^3*h^2
def positivePairLimit : Filter (ℝ × ℝ) :=
  𝓝[Set.Ioi (0 : ℝ) ×ˢ Set.Ioi (0 : ℝ)] (0,0)
theorem perturbedErrorExpansion (s : Fin 4) (γ : ℝ) (hγ : 0 < γ)
    (μ : ℝ → ℝ → Measure (ℝ × ℝ))
    (hinv : ∀ ε h, 0 < ε → 0 < h → perturbedStationary s ε γ h (μ ε h)) :
    Asymptotics.IsBigO positivePairLimit
      (fun z ↦ momentQ (μ z.1 z.2)-momentQ (perturbedGibbs z.1)-perturbedLeading s γ z.1 z.2)
      (fun z ↦ perturbedRemainder s z.1 z.2) := by
  sorry''',label='(7.14)',
extra=['原书以形式截断推得系数；本条把正ε、正h趋零的余项写成明确待证估计，不声称形式截断已给出严格证明。','实际平稳分布、坐标L²、独立Gaussian噪声及γ>0均写入前提；没有把待求平均或展开作为假设。'],
missing='需要非线性平稳矩层级截断及一致余项控制的大型理论；本轮不建设。')

add('PerturbedErrorOrders','7.5',280,
r'''The behavior of the methods can thus be summarized as
\[|\langle q^2\rangle_h^{[ABOBA]}-\langle q^2\rangle|=O(\epsilon h^2),\qquad
|\langle q^2\rangle_h^{[BAOAB]}-\langle q^2\rangle|=O\left(\frac{\epsilon^2h^2}{1+\gamma^2}+\epsilon^2h^4\right),\]
\[|\langle q^2\rangle_h^{[OBABO]}-\langle q^2\rangle|=O(h^2),\qquad
|\langle q^2\rangle_h^{[OABAO]}-\langle q^2\rangle|=O(h^2).\tag{7.15}\]
The twofold surprising result though, is that (a) the leading error of the $[BAOAB]$ scheme has behavior proportional to $\epsilon^2$, while (b) the leading order term of the $[BAOAB]$ scheme is annihilated for large $\gamma$.''',
'''def perturbedErrorScale (s : Fin 4) (γ ε h : ℝ) : ℝ :=
  if s = 0 then ε*h^2 else if s = 1 then ε^2*h^2/(1+γ^2)+ε^2*h^4 else h^2
theorem perturbedErrorOrders (s : Fin 4) (γ : ℝ) (hγ : 0 < γ)
    (μ : ℝ → ℝ → Measure (ℝ × ℝ))
    (hinv : ∀ ε h, 0 < ε → 0 < h → perturbedStationary s ε γ h (μ ε h)) :
    Asymptotics.IsBigO positivePairLimit
      (fun z ↦ |momentQ (μ z.1 z.2)-momentQ (perturbedGibbs z.1)|)
      (fun z ↦ perturbedErrorScale s γ z.1 z.2) := by
  sorry
theorem baoabLeading_largeFriction (ε h : ℝ) :
    Filter.Tendsto (fun γ : ℝ ↦ -9*h^2*ε^2/(6*γ^2+8)) Filter.atTop (𝓝 0) := by
  sorry''',label='(7.15)',
extra=['双参数正向极限已明确；γ固定的常数不等于γ一致误差界。原书(7.14)的ε³h²余项不足以单独推出BAOAB的ε²h²+ε²h⁴界，需要额外结构；保留为待证。'],
missing='首项衰减需有理函数极限短桥；四个误差阶需要非线性平稳弱误差与一致余项理论。')
EXCLUDED.append({'section':'7.5','printed_page':'280–281','reason':'Fig.7.3、时间窗10^8及各ε,h实验曲线和经验排序是数值观测，不作为待证对象。'})
