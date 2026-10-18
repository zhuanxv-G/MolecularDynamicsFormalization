from ch07_data import add
add('HarmonicHamiltonian','7.4',273,
r'''Recall that the one-dimensional harmonic oscillator with spring constant $\Omega^2$ has potential energy function $U(q)=\Omega^2q^2/2$, with Hamiltonian
\[H(q,p)=\frac{p^2}{2m}+\frac{\Omega^2q^2}{2},\tag{7.6}\]
where $(q,p)\in\mathbb R^2$ represent a particle's position and momentum, and $m>0$ is the particle's mass.''',
'''def harmonicHamiltonian (m Ω : ℝ) (x : ℝ × ℝ) : ℝ := x.2^2/(2*m)+Ω^2*x.1^2/2
def harmonicLaw (m Ω θ : ℝ) : Measure (ℝ × ℝ) :=
  (gaussianReal 0 (NNReal.ofReal (θ/Ω^2))).prod (gaussianReal 0 (NNReal.ofReal (θ*m)))''',kind='definition',label='(7.6)',extra=['正m、正θ、Ω≠0时为可归一化的正则谐振子Gibbs分布；θ=k_BT。'])
add('HarmonicMoments','7.4','273–274',
r'''In this setting, the canonical distribution $\rho_\beta$ is the product of two Gaussian distributions, where we have invariant (stationary) averages
\[\langle q\rangle=\langle p\rangle=0,\qquad\langle\Omega^2q^2\rangle=\langle p^2/m\rangle=k_BT,\qquad\langle qp\rangle=0.\]''',
'''theorem harmonicMoments (m Ω θ : ℝ) (hm : 0 < m) (hΩ : Ω ≠ 0) (hθ : 0 < θ) :
    (∫ x, x.1 ∂harmonicLaw m Ω θ) = 0 ∧
    (∫ x, x.2 ∂harmonicLaw m Ω θ) = 0 ∧
    (∫ x, Ω^2*x.1^2 ∂harmonicLaw m Ω θ) = θ ∧
    (∫ x, x.2^2/m ∂harmonicLaw m Ω θ) = θ ∧
    (∫ x, x.1*x.2 ∂harmonicLaw m Ω θ) = 0 := by
  sorry''',missing='需要正态二阶矩和乘积测度积分的完整短桥；不重建Gaussian理论。',
extra=['harmonicLaw给出实际正态乘积，未把所需各矩值作为假设；与Hamiltonian的密度识别另列覆盖缺口。'],
scope='实际正态乘积的全部五个矩；其Lebesgue密度等于归一Gibbs权的识别未另作定理。')
add('LinearIteration','7.4',274,
r'''Thus, denoting the iteration index as a subscript, we may explicitly write one iteration of a general numerical method for evolving the dynamics as
\[\binom{q_{n+1}}{p_{n+1}}=\Psi\binom{q_n}{p_n}+\mu_n,\tag{7.7}\]
where $\Psi$ is a constant matrix that depends on the stepsize $h$, the friction coefficient $\gamma$, the particle mass $m$ and the spring constant $\Omega$. Additionally $\mu_n$ is a vector of stochastic processes.''',
'''def linearUpdate (a b c d : ℝ) (x noise : ℝ × ℝ) : ℝ × ℝ :=
  (a*x.1+b*x.2+noise.1,c*x.1+d*x.2+noise.2)
def momentQ (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.1^2 ∂μ
def momentP (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.2^2 ∂μ
def momentQP (μ : Measure (ℝ × ℝ)) : ℝ := ∫ x, x.1*x.2 ∂μ''',kind='definition',label='(7.7)',
extra=['具体2×2矩阵用四个真实系数，噪声不假定自动独立；后续陈述分别补独立或相关结构。'])
add('BBKLinearForm','7.4',274,
r'''For example, in the BBK method we can compute directly from its update scheme that
\[\Psi^{\rm BBK}=\begin{bmatrix}1-\frac{h^2\Omega^2}{2m}&\frac hm(1-\frac{\gamma h}2)\\
\frac{h\Omega^2}{2m}\frac{h^2\Omega^2-4m}{2+\gamma h}&\frac{(2-\gamma h)(2m-h^2\Omega^2)}{2m(2+\gamma h)}\end{bmatrix},\]
\[\mu_n^{\rm BBK}=\begin{bmatrix}\sqrt{\frac{k_BT\gamma h^3}{2m}}R_n\\
\frac{\sqrt{2k_BT\gamma hm}}{2+\gamma h}[(1-\frac{h^2\Omega^2}{2m})R_n+R'_n]\end{bmatrix}.\]''',
'''def bbkMatrix (m Ω γ h : ℝ) : ℝ × ℝ × ℝ × ℝ :=
  (1-h^2*Ω^2/(2*m), h/m*(1-γ*h/2),
    h*Ω^2/(2*m)*((h^2*Ω^2-4*m)/(2+γ*h)),
    (2-γ*h)*(2*m-h^2*Ω^2)/(2*m*(2+γ*h)))
def bbkNoise (m Ω γ θ h R S : ℝ) : ℝ × ℝ :=
  (Real.sqrt (θ*γ*h^3/(2*m))*R,
    Real.sqrt (2*θ*γ*h*m)/(2+γ*h)*((1-h^2*Ω^2/(2*m))*R+S))''',kind='definition',
extra=['完整记录所印矩阵与噪声；从BBK更新代入谐势的代数识别暂未证明，不以定义计为已证识别。'])
add('QuadraticProducts','7.4',274,
r'''More generally, if we define the components of $\Psi$ as $\psi_{ij}$ and denote $\mu_n=[\mu_{n,1},\mu_{n,2}]^T$ we can take products of the update equations defined by (7.7) to obtain
\[q_{n+1}^2=\psi_{11}^2q_n^2+\psi_{12}^2p_n^2+\mu_{n,1}^2+2\psi_{11}\psi_{12}q_np_n+2\psi_{11}\mu_{n,1}q_n+2\psi_{12}\mu_{n,1}p_n,\tag{7.8}\]
\[p_{n+1}^2=\psi_{21}^2q_n^2+\psi_{22}^2p_n^2+\mu_{n,2}^2+2\psi_{21}\psi_{22}q_np_n+2\psi_{21}\mu_{n,2}q_n+2\psi_{22}\mu_{n,2}p_n,\tag{7.9}\]
\[q_{n+1}p_{n+1}=\psi_{11}\psi_{21}q_n^2+\psi_{12}\psi_{22}p_n^2+\mu_{n,1}\mu_{n,2}+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})q_np_n
+(\psi_{11}\mu_{n,2}+\psi_{21}\mu_{n,1})q_n+(\psi_{22}\mu_{n,1}+\psi_{12}\mu_{n,2})p_n.\tag{7.10}\]''',
'''theorem quadraticProducts (a b c d q p r s : ℝ) :
    (linearUpdate a b c d (q,p) (r,s)).1^2 =
      a^2*q^2+b^2*p^2+r^2+2*a*b*q*p+2*a*r*q+2*b*r*p ∧
    (linearUpdate a b c d (q,p) (r,s)).2^2 =
      c^2*q^2+d^2*p^2+s^2+2*c*d*q*p+2*c*s*q+2*d*s*p ∧
    (linearUpdate a b c d (q,p) (r,s)).1*(linearUpdate a b c d (q,p) (r,s)).2 =
      a*c*q^2+b*d*p^2+r*s+(a*d+b*c)*q*p+(a*s+c*r)*q+(d*r+b*s)*p := by
  dsimp [linearUpdate]
  constructor
  · ring
  constructor <;> ring''',label='(7.8)–(7.10)',proof='Take products of the update equations defined by (7.7).')
add('StationaryMomentSystem','7.4.1',275,
r'''Hence we have $\mathbb E(\mu_{n,i}q_n)=\mathbb E(\mu_{n,i}p_n)=0$, for any $i$ and $n$. Thus, taking expectations of (7.8)–(7.10) for such schemes, and then considering the limit $n\to\infty$ we obtain a closed, linear system of equations
\[Q=\psi_{11}^2Q+\psi_{12}^2P+2\psi_{11}\psi_{12}C+\bar\mu_{11},\]
\[P=\psi_{21}^2Q+\psi_{22}^2P+2\psi_{21}\psi_{22}C+\bar\mu_{22},\]
\[C=\psi_{11}\psi_{21}Q+\psi_{12}\psi_{22}P+(\psi_{11}\psi_{22}+\psi_{12}\psi_{21})C+\bar\mu_{12},\tag{7.11}\]
where $\bar\mu_{11}=\mathbb E(\mu_{n,1}^2)$, $\bar\mu_{12}=\mathbb E(\mu_{n,1}\mu_{n,2})$, $\bar\mu_{22}=\mathbb E(\mu_{n,2}^2)$.''',
'''def momentSystem (a b c d u v w Q P C : ℝ) : Prop :=
  Q = a^2*Q+b^2*P+2*a*b*C+u ∧
  P = c^2*Q+d^2*P+2*c*d*C+w ∧
  C = a*c*Q+b*d*P+(a*d+b*c)*C+v

def invariantLinearLaw (μ η : Measure (ℝ × ℝ)) (a b c d : ℝ) : Prop :=
  IsProbabilityMeasure μ ∧ IsProbabilityMeasure η ∧
  Measure.map (fun z ↦ linearUpdate a b c d z.1 z.2) (μ.prod η) = μ

theorem stationaryMomentSystem (μ η : Measure (ℝ × ℝ)) (a b c d : ℝ)
    (hinv : invariantLinearLaw μ η a b c d)
    (hq : MemLp (fun x ↦ x.1) 2 μ) (hp : MemLp (fun x ↦ x.2) 2 μ)
    (hr : MemLp (fun x ↦ x.1) 2 η) (hs : MemLp (fun x ↦ x.2) 2 η)
    (hmean : (∫ x, x.1 ∂η) = 0 ∧ (∫ x, x.2 ∂η) = 0) :
    momentSystem a b c d (momentQ η) (momentQP η) (momentP η)
      (momentQ μ) (momentP μ) (momentQP μ) := by
  sorry''',label='(7.11)',
extra=['使用独立乘积μ.prodη及实际推前不变性，不把所求矩方程当作该定理假设；所有坐标L²、噪声中心化明示。','只讨论已存在的平稳分布矩，初值分布趋平稳及长时间平均的遍历收敛未证明。'],
missing='需乘积测度、可积多项式与推前矩计算的桥接；不建立一般Markov链遍历理论。')
