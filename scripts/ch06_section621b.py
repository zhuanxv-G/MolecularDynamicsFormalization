"""Second random-walk/Wiener batch; full path-law claims remain explicit."""
from ch06_data import add,copied,proposition,D,NS
add('InterpolatedWalk','6.2.1',226,[28],r'''For points between $t_k$ and $t_{k+1}$ we define the value of $Y(t)$ by linear interpolation:
\[Y(t)=Y_k+\Delta Y_k\frac{t-t_k}{\delta t}.\]''',copied(D,'interpolatedWalk'),kind='definition',context=['δt>0，k=⌊t/δt⌋，真实线性插值；不是Wiener路径，也不声称任意插值点方差恰等于时间差。'])
add('WalkIncrement','6.2.1','225–226',[25,28],r'''The increments of the random walk are the differences $\Delta X_n=X_n-X_{n-1}=\delta xJ_{n-1}$, thus $(X_n)$ is a random process with independent increments.
We will use the shorthand $Y_k=Y(t_k)$ and $\Delta Y_k=Y_{k+1}-Y_k=\sqrt{\delta t}J_k$. The increments are clearly independent.''',copied(D,'walkIncrement'),kind='definition',context=['本条定义实际X(n+1)−Xn增量；差分恒等式与独立性另条保存，不把独立性计为定义已证。'])
add('WalkGridMoments','6.2.1',226,[29],r'''Let us observe the following facts, for $0\leq k\leq l\leq\nu$
\[(i)\quad\mathbb E(Y_l-Y_k)=0,\qquad(ii)\quad\operatorname{Var}(Y_l-Y_k)=t_l-t_k.\]''',proposition('walkGridMoments_statement'),extra=['[EXTRA]实际独立公平L²跳跃、正δt和k≤l；保存零均值与完整增量二阶矩，不假设这些结论。'],missing='依赖有限独立中心和二阶矩短桥；不以连续插值的近似方差代替。')
add('InterpolatedWalkMean','6.2.1',226,[],r'''Then, for $0\leq t\leq s\leq\tau$, we have
\[\mathbb E(Y(s)-Y(t))=0.\]
This is easy to demonstrate. However, the intuitive corresponding statement $\operatorname{Var}(Y(s)-Y(t))=(s-t)$ does not quite hold due to the reliance on interpolation.''',
'''theorem interpolatedWalkMean : ∀ {Ω : Type*} [MeasurableSpace Ω]
    (P : Measure Ω) (J : ℕ → Ω → ℝ) (dt t s : ℝ),
  MolecularDynamics.Chapter06Review.rademacherJumps P J → 0 < dt → 0 ≤ t → t ≤ s →
  (∫ sample, MolecularDynamics.Chapter06Review.interpolatedWalk J dt s sample -
    MolecularDynamics.Chapter06Review.interpolatedWalk J dt t sample ∂P) = 0 := by
  sorry''',extra=['[EXTRA]真实线性插值均值；任意有限正时间可置于τ窗口，不声称精确插值方差等于s−t。'],missing='待实际有限和零均值及线性插值积分短桥。')
add('WalkDiffusion','6.2.1','226–227',[30],r'''In the diffusion limit the motion of the random walk can be viewed as an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process (after Norbert Wiener).
\[W(t)=\lim_{\delta t\to0}^{c}\sqrt{\delta t}\sum_{k=0}^{\lfloor t/\delta t\rfloor}J_k.\]
The convergence here, signified by the symbol $\lim^c$ is in the sense of distributions.''',proposition('walkDiffusion_statement'),extra=['[EXTRA]完整连续路径空间C([0,T],ℝ)弱法则、各时Gaussian边际、独立增量和全部有界连续路径检验函数；使用实际线性插值的n项和，不将单时CLT计为路径Donsker已证。','[EXTRA]印刷含端点的多一项有限和与标准n项版本之差在扩散极限消失须另核；连续版本和不可微性质另条保留。'],missing='缺Donsker函数空间不变性原理及tightness；不建立大型概率路径理论，保留完整sorry。')
add('WienerVector','6.2.1',227,[31],r'''As we take $n$ to infinity, $\delta t$ to zero, in such a way that $n\delta t\to t$, we obtain the random variable $W(t)$ such that
\[W(t)\sim N(0,t).\]
For the Wiener process, we know that $W(t)-W(s)$ is normally distributed with mean zero and variance $|t-s|$.''',
'''def wienerVector {n : ℕ} {Ω : Type*} [MeasurableSpace Ω]
    (B : ℝ≥0 → Ω → (Fin n → ℝ)) (P : Measure Ω) : Prop :=
  MolecularDynamics.textbookIsWienerVector B P''',kind='definition',context=['正式真实结构的别名：联合Gaussian、零均值、min(s,t)各坐标协方差及AE连续路径；定义的连续性资格不计为从PreBrownian或随机游走构造连续过程已证。','原页单时CLT和整个路径扩散极限分别处理；标量一般时刻法则在WienerIncrement中保留。'])
add('WienerIncrement','6.2.1',227,[32],r'''Moreover, we may easily demonstrate that
\[\mathbb E(W(t)-W(s))^2=|t-s|.\tag{6.7}\]
For the Wiener process, we know that $W(t)-W(s)$ is normally distributed with mean zero and variance $|t-s|$.''',proposition('wienerIncrement_statement'),label='(6.7)',extra=['[EXTRA]实际IsPreBrownianReal模型、任意非负s,t、完整Gaussian法则与二阶矩；不局限等距网格。'],missing='待Mathlib PreBrownian增量法则与Gaussian二阶矩的完整短桥；等距网格正式特例另列。')
add('WienerContinuousVersion','6.2.1','226–227',[33],r'''In the diffusion limit the motion of the random walk can be viewed as an everywhere continuous (but almost nowhere smooth) path which is called a Wiener process.''',proposition('wienerContinuousVersion_statement'),extra=['[EXTRA]从实际PreBrownian Gaussian法则构造AE连续修改，保持每个时刻AE一致；不将连续性本身作存在连续版本定理的前提。'],missing='待现成Kolmogorov连续修改桥接；若无完整桥接，不重建概率路径理论；给定连续模型的路径值封装另列[EXTRA]。')
