"""Mean-square integrals keep actual L² sums; existing generic weak alias is flagged."""
from ch06_data import add,copied,probability_copy,D
I='MolecularDynamics/Chapter06/WienerIntegration.lean'
Q='MolecularDynamics/Chapter06/WienerQuadraticVariation.lean'
add('RiemannTags','6.2.2',228,[],r'''Recall that the Riemann integral of a continuous function $g$ on $[0,\tau]$ is the limit of Riemann sums constructed as follows: partition the interval $[0,\tau]$ into $K$ subintervals each of width $\delta t=\tau/K$, choose an arbitrary $t_k$ from the $k$th subinterval, $1\leq k\leq K$, and evaluate the integral as a limit of the sum of products:
\[\int_0^\tau g(t)dt=\lim_{K\to\infty}\sum_{k=0}^{K-1}g(t_k)\delta t.\]
We know that this limit does not depend on where the $t_k$ are chosen within the subintervals. For example we can take the left or right endpoint of each subinterval or the midpoint.''',
'''theorem riemannTags : ∀ (g : ℝ → ℝ) (T : ℝ) (tags : ℕ → ℕ → ℝ),
  0 ≤ T → ContinuousOn g (Icc 0 T) →
  (∀ K k : ℕ, 0 < K → k < K → tags K k ∈ Icc ((k : ℝ)*T/K) (((k : ℝ)+1)*T/K)) →
  Tendsto (fun K : ℕ ↦ ∑ k ∈ Finset.range K, g (tags K k)*(T/K)) atTop
    (𝓝 (∫ t in (0 : ℝ)..T, g t)) := by
  sorry''',extra=['[EXTRA]非负窗口和所有合法任意tags；完整标签无关性，没有缩减为仅左端点特例。'],missing='待现成带任意标记的Riemann求积完整桥接；不建立积分构造理论。')
text=r'''By analogy, we would like to write the stochastic integral of a function $g$, where $g$ may, itself, be defined in terms of a stochastic process, as the limit of a sum:
\[\sum_{k=0}^{K-1}g(t_k)[W((k+1)\delta t)-W(k\delta t)],\quad K\to\infty.\]
The first choice is commonly referred to as Itô integration, and the second as Stratonovich integration.'''
add('ItoLeftSum','6.2.2',228,[36],text,copied(D,'itoLeftSum'),kind='definition',context=['取tk=kδt；真实随机有限和，不预置积分存在。'])
add('StrictItoIntegral','6.2.2','228–229',[36],text+ r'''
where, for a sequence of random variables, $A_K$ and a random variable $B$, we have
\[\operatorname{l.i.m.}_{K\to\infty}A_K=B\iff\lim_{K\to\infty}\mathbb E(A_K-B)^2=0.\]''',
'''def strictItoIntegral {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (W g : ℝ → Ω → ℝ) (T : ℝ) (Y : Ω → ℝ) : Prop :=
  (∀ K : ℕ, MemLp (MolecularDynamics.Chapter06Review.itoLeftSum W g T K) 2 P) ∧
  MemLp Y 2 P ∧ Tendsto (fun K : ℕ ↦ ∫ sample,
    (MolecularDynamics.Chapter06Review.itoLeftSum W g T K sample-Y sample)^2 ∂P) atTop (𝓝 0)''',kind='definition',extra=['[EXTRA]显式所有有限和与极限的L²资格，防止Bochner非可积默认值0伪造均方收敛；真实取样和极限，不假设任何求值结论。'])
add('WeakItoAlias','6.2.2','228–229',[36],text,copied(D,'isItoIntegral','weakItoAlias'),kind='definition',verdict='NEEDS_HUMAN',issues=['既有Review定义仅要求Y∈L²及误差Bochner积分收敛，未要求各有限和L²，非可积默认积分0会掩盖错误；不得用于新PASS SDE证明。'],missing='保留原正式库定义签名冻结；本地严格L²定义另列，严格模型用于后续新陈述。')
add('StratonovichSum','6.2.2',228,[37],text,
'''def stratonovichSum {Ω : Type*} (W g : ℝ → Ω → ℝ) (T : ℝ) (K : ℕ) (sample : Ω) : ℝ :=
  ∑ k ∈ Finset.range K, g (((k : ℝ)+1/2)*T/K) sample *
    (W (((k : ℝ)+1)*T/K) sample-W ((k : ℝ)*T/K) sample)''',kind='definition',context=['真实时间中点tk=(k+1/2)δt；不是端点函数值的算术均值。'])
add('SelfItoFiniteIdentity','6.2.2','228–229',[38],r'''As an example, consider the case where $g(t)=W(t)$. We suppose this to be approximated by a sum
\[\int_0^\tau W(t)dW(t)\approx\sum_{k=0}^{K-1}W(k\delta t)[W((k+1)\delta t)-W(k\delta t)],\]
\[=\frac12\sum_{k=0}^{K-1}[W((k+1)\delta t)^2-W(k\delta t)^2-(W((k+1)\delta t)-W(k\delta t))^2].\]
Breaking this into two parts, we see that the first sum telescopes to give $W(\tau)^2$ (as $W(0)=0$).''',probability_copy(I,'textbookWienerSelfItoSum_identity','selfItoFiniteIdentity'),extra=['[EXTRA]真实PreBrownian、K>0和AE W0=0；保存完整有限和望远镜恒等。'],prior=['MolecularDynamics.textbookWienerSelfItoSum_identity'])
add('Proposition62','6.2.2','229–230',[39],r'''Proposition 6.2 Let $\delta t=\tau/K$ then
\[\operatorname{l.i.m.}_{K\to\infty}\sum_{k=0}^{K-1}[(W((k+1)\delta t)-W(k\delta t))^2]=\tau,\]
where, for a sequence of random variables, $A_K$ and a random variable $B$, we have
\[\operatorname{l.i.m.}_{K\to\infty}A_K=B\iff\lim_{K\to\infty}\mathbb E(A_K-B)^2=0.\]
(This is referred to as convergence in the mean square sense.)''',probability_copy(Q,'textbookWienerQuadraticSum_meanSquare_tendsto','proposition62'),kind='proposition',label='Proposition 6.2',extra=['[EXTRA]实际PreBrownian law、τ≥0、全部均方极限；印刷最后K→0是笔误，更正K→∞。'],issues=['印刷证明的独立交叉项展开带负号；平方展开应正号，见单独疑误条。'],prior=['MolecularDynamics.textbookWienerQuadraticSum_meanSquare_tendsto'],proof=r'''With $\tau,K$ fixed, we have $\delta t=\tau/K$.
Let $W_{K,k}=W((k+1)\delta t)-W(k\delta t)=W((k+1)\tau/K)-W(k\tau/K)$ and observe that
\[\sum_{k=0}^{K-1}W_{K,k}^2-\tau=\sum_{k=0}^{K-1}[W_{K,k}^2-\delta t].\]
Then
\[I\stackrel{\rm def}=\mathbb E(\sum_{k=0}^{K-1}W_{K,k}^2-\tau)^2=\mathbb E(\sum_{k=0}^{K-1}[W_{K,k}^2-\delta t])^2.\]
Terms of the form $Z_{K,k}\stackrel{\rm def}=W_{K,k}^2-\delta t$ are independent and have mean zero. Therefore
\[\mathbb E(\sum_{k=0}^{K-1}Z_{K,k})^2=\mathbb E\sum_{k=0}^{K-1}Z_{K,k}^2-2\mathbb E\sum_{k\ne l}Z_{K,k}Z_{K,l}=\mathbb E\sum_{k=0}^{K-1}Z_{K,k}^2,\]
where the last equation follows from independence of the increments ($\mathbb E Z_kZ_l=0$ if $k\ne l$).
Also observe that $\Delta W_k$ is a normally distributed random variable with the following properties
\[\mathbb E\Delta W_k=0;\quad\mathbb E\Delta W_k^2=\delta t=\tau/K;\quad\mathbb E\Delta W_k^4=3\delta t^2=3(\tau/K)^2.\]
Thus we have
\[I=\sum_{k=0}^{K-1}\mathbb E(\Delta W_{K,k}^2-\delta t)^2
=\sum_{k=0}^{K-1}\mathbb E[\Delta W_{K,k}^4-2\delta t\Delta W_{K,k}^2+\delta t^2]
=\sum_{k=0}^{K-1}[3\delta t^2-2\delta t^2+\delta t^2]=2K\delta t^2=2\tau^2/K.\]
Thus $I\to0$ as $K\to0$, which is the desired result.''',proof_note='逐字保存含印刷负号与K→0；正式桥接使用正确独立平方和及K→∞。')
add('MeanSquareConvergence','6.2.2',229,[39],r'''where, for a sequence of random variables, $A_K$ and a random variable $B$, we have
\[\operatorname{l.i.m.}_{K\to\infty}A_K=B\iff\lim_{K\to\infty}\mathbb E(A_K-B)^2=0.\]''',
'''def meanSquareConvergence {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω)
    (A : ℕ → Ω → ℝ) (B : Ω → ℝ) : Prop :=
  (∀ K, MemLp (A K) 2 P) ∧ MemLp B 2 P ∧
  Tendsto (fun K ↦ ∫ sample, (A K sample-B sample)^2 ∂P) atTop (𝓝 0)''',kind='definition',extra=['[EXTRA]显式L²随机变量资格防止非可积Bochner默认值；不假设收敛结论。'])
