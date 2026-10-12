"""Eight exact L2 and average records on the original domain D, PDF204–205."""
from ch05_data import add,NS
add('DomainL2','5.2.1',183,[14],r'''The set of functions from $D\subset\mathbb R^m$ to $\mathbb R$ which satisfy $\int_D\rho^2(z)\,d\omega<\infty$ is referred to as the space $L^2(D)$.''',f'''@[reducible] def domainL2 (n : ℕ) (D : Set ({NS}E n)) := Lp ℝ 2 (volume.restrict D)''',kind='definition',extra=['[EXTRA]Mathlib Lp使用Lebesgue可测函数的AE等价类；书中未写商空间，若不取AE类，所谓范数可能为0而原始函数非零。保留一般D；透明别名复用实际Lp的实例。'])
add('L2Norm','5.2.1',183,[14],r'''we define the $L^2(D)$ norm by $\|\rho\|_{L^2(D)}\stackrel{\rm def}{=}[\int_D\rho^2(z)\,d\omega]^{1/2}$.''',f'''def domainL2Norm {{n : ℕ}} {{D : Set ({NS}E n)}} (g : domainL2 n D) := ‖g‖''',kind='definition',context=['实际Lp范数；与原积分公式的等式独立定理，不将定义编译冒称公式已证。'])
add('L2Inner','5.2.1',183,[15],r'''for any $\phi,\psi\in L^2(D)$, the inner product is defined by $\langle\phi,\psi\rangle_{L^2(D)}\stackrel{\rm def}{=}\int_D\phi(z)\psi(z)\,d\omega$.''',f'''def domainL2Inner {{n : ℕ}} {{D : Set ({NS}E n)}} (f g : domainL2 n D) : ℝ :=
  ∫ z in D,f z*g z''',kind='definition',context=['在真实AE类的Mathlib可测代表上积分；乘积可积由Lp2保证。'])
add('L2NormSquare','5.2.1',183,[16],r'''Thus $\|\rho\|_{L^2(D)}^2=\langle\rho,\rho\rangle_{L^2(D)}$.''',f'''theorem domainL2NormSquare : ∀ n (D : Set ({NS}E n)) (g : domainL2 n D),
  domainL2Norm g^2=domainL2Inner g g := by
  sorry''',context=['实际Lp内积到积分桥接，不假设范数积分公式。'])
add('L2Complete','5.2.1',183,[17],r'''This is a real Hilbert space or complete inner product space.''',f'''theorem domainL2Complete : ∀ n (D : Set ({NS}E n)) (u : ℕ → domainL2 n D),
  CauchySeq u → ∃ v : domainL2 n D,Tendsto u atTop (𝓝 v) := by
  sorry''',extra=['[EXTRA]完备结论在AE商L²上；原生函数集合的正定性缺AE资格。'])
add('L2SymmetricBilinear','5.2.1',183,[18],r'''The inner product is a symmetric, bilinear operation: if $\alpha,\beta$ are real scalars and $f,g,h\in L^2(D)$, then $\langle\alpha f+\beta g,h\rangle=\alpha\langle f,h\rangle+\beta\langle g,h\rangle$, and $\langle f,g\rangle=\langle g,f\rangle$.''',f'''theorem domainL2SymmetricBilinear : ∀ n (D : Set ({NS}E n)) (f g h : domainL2 n D) (a b : ℝ),
  domainL2Inner (a • f+b • g) h=a*domainL2Inner f h+b*domainL2Inner g h ∧
    domainL2Inner f g=domainL2Inner g f := by
  sorry''',context=['完整两个结论都保留，在Lp商上以实际内积/积分桥接。'])
add('CompactL2','5.2.1',183,[19],r'''The space $L^2(\mathbb R^m)$ includes for example the continuous functions with compact (closed, bounded) support, where the support of a function $f$ is the closure of the set of arguments for which the function is nonzero and is denoted $\operatorname{supp}f$.''',f'''theorem compactL2 : ∀ n (g : {NS}E n → ℝ),
  Continuous g → HasCompactSupport g → MemLp g 2 volume := by
  sorry''',context=['HasCompactSupport对应闭支持tsupport的紧性，Function.support只是非零集合。'])
add('DensityAverageOn','5.2.1',184,[20],r'''Given a density $\rho$, we may identify a collection of functions $g$ for which the integral with respect to $\rho$ is bounded, i.e. for which we can define the inner product $\langle g,\rho\rangle=\int_Dg(z)\rho(z)\,d\omega$, and thus we can define
\[\operatorname{Av}_\rho(g)\stackrel{\rm def}{=}\frac{1}{\int_D\rho(z)\,d\omega}\langle g,\rho\rangle=\int_Dg\widehat\rho\,d\omega.\]
We term this the spatial average of the function $g$ with respect to the probability measure associated to $\rho$.''',f'''def densityAverageOn {{n : ℕ}} (D : Set ({NS}E n)) (ρ g : {NS}E n → ℝ) : ℝ :=
  (∫ z in D,g z*ρ z)/(∫ z in D,ρ z)''',kind='definition',context=['平均的概率解释限于正的有限归一化分母及可积乘积；定义仅复现完整实际积分比值，不假设它是内积适用于任意g。'])
