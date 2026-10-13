"""Numerical propagators and literal Euler component divergence."""
from ch05_data import add,copied,proposition,D,NS
add('DiscreteAveragePrinted','5.6',206,[72],r'''If $z_n$ represents the approximation to $z(t_n)$, then we might attempt to estimate $\bar g$ by
\[\bar g\approx\lim_{n\to\infty}n^{-1}\sum_{k=0}^ng(z_k).\]''',copied(D,'discreteAveragePrinted'),kind='definition',context=['原式包含n+1项却除n，字面有限和保留；无限极限并非对所有算法/所有轨道存在。'])
add('DiscreteAverage','5.6',206,[72],r'''$\bar g\approx\lim_{n\to\infty}n^{-1}\sum_{k=0}^ng(z_k)$.''',copied(D,'discreteAverage'),kind='definition',extra=['[EXTRA]标准n项平均修正版，另列不覆盖原n+1项；n=0总化除法不赋予统计平均意义。'])
add('DiscretePropagator','5.6',206,[73],r'''In a similar way, a numerical method $z_{n+1}=F_h(z_n)$ induces an effective distributional propagator.''',copied(D,'discretePropagator'),kind='definition',context=['实际Measure.map迭代映射；不把有限modified equation宣称算法的精确全时流。'])
add('ModifiedField','5.6',206,[74],r'''One way to understand this propagator is to interpret the numerical method as being approximately equivalent to the solution of a perturbed differential equation
\[\frac{dz}{dt}=f(z)+h^rf^{(r)}(z)=\widetilde f_h(z).\]
The perturbation term may be viewed as the finite truncation of the perturbative expansion obtained from the backward error analysis using the methods of the previous chapter. ($r$ is the order of the numerical method.)''',copied(D,'modifiedField'),kind='definition',context=['实际有限截断向量场；近似与余项受控未由定义推出，不假设形式展开收敛。'])
add('ModifiedLiouvillian','5.6',206,[75],r'''Let us assume that the perturbed equation is a realistic model for the numerical solutions, then define the evolving density by
\[\frac{\partial\rho}{\partial t}=\mathcal L_{\widetilde f}^{*}\rho
\stackrel{\rm def}{=}\mathcal L_f^*\rho+h^r\mathcal L_{f^{(r)}}^*\rho.\]''',proposition('modifiedLiouvillian_statement'),extra=['[EXTRA]实际Fréchet导数和trace，可微f/fr/u资格；只证微分表达式对场线性，不声称余项密度误差已受控。'],missing='待Fréchet sum/smul与trace线性短桥。')
add('ForwardEuler','5.6','206–207',[],r'''Applying Forward Euler to the harmonic oscillator, we have
\[q_{n+1}=q_n+hp_n,\qquad p_{n+1}=p_n-hq_n,\]
or $\binom{q_{n+1}}{p_{n+1}}=\begin{pmatrix}1&h\\-h&1\end{pmatrix}\binom{q_n}{p_n}$.''',copied(D,'forwardEuler'),kind='definition',context=['单位频率真实二维振子映射，不恢复其他章节长证明。'])
add('ForwardComponentsPrinted','5.6',207,[],r'''we see that the eigenvalues of the propagation matrix are outside the unit disk. Thus both solution components tend to infinity unless $(q_0,p_0)=(0,0)$.''',f'''theorem forwardComponentsPrinted : ∀ h : ℝ,h ≠ 0 → ∀ z : {NS}E 2,z ≠ 0 →
  Tendsto (fun k : ℕ => |({NS}forwardEuler h)^[k] z 0|) atTop atTop ∧
  Tendsto (fun k : ℕ => |({NS}forwardEuler h)^[k] z 1|) atTop atTop := by
  sorry''',verdict='NEEDS_HUMAN',explanation='[ERRATUM?]外扩旋转只能推出范数增长，两个单独分量会振荡；例如h=1的八步角周期中可反复出现分量0，不能静默以范数替代原两分量结论。',extra=['[EXTRA]h非零、非原点初值；“趋无穷”按绝对值解释仍有反例。'],missing='原两分量说法需裁定，不证明；范数增长修正版另条。')
add('ForwardEnergyGrowth','5.6',207,[],r'''the eigenvalues of the propagation matrix are outside the unit disk.''',f'''theorem forwardEnergyGrowth : ∀ (h : ℝ) (z : {NS}E 2) (k : ℕ),
  ((({NS}forwardEuler h)^[k] z) 0)^2+((({NS}forwardEuler h)^[k] z) 1)^2=
    (1+h^2)^k*((z 0)^2+(z 1)^2) := by
  sorry''',extra=['[EXTRA]实际有限步能量增长恒等式，作为原谱外扩的直接代数后果另列；本式允许h=0，渐近发散需h≠0和非原点。'],missing='待具体映射迭代的平方展开归纳短证明。')
