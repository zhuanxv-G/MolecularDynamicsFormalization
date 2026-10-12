"""Footnote/function-space details and the displayed normalized average."""
from ch05_data import add,NS
add('ClosedSupport','5.2.1',183,[],r'''the support of a function $f$ is the closure of the set of arguments for which the function is nonzero and is denoted $\operatorname{supp}f$.''',f'''def closedSupport {{n : ℕ}} (f : {NS}E n → ℝ) : Set ({NS}E n) := tsupport f''',kind='definition',context=['tsupport=closure(Function.support f)；和非零点集合明确区分。'])
add('GaussianL2','5.2.1',183,[],r'''$L^2(\mathbb R^m)$ also includes many other types of functions important in molecular modelling, for example the multivariate Gaussian $\exp(-\sum_{i=1}^m\alpha_i x_i^2)$, where $\alpha_i>0,i=1,2,\ldots,m$ are coefficients; such a function goes rapidly to zero as any $x_i\to\infty$, so the improper integral converges.''',f'''theorem gaussianL2 : ∀ n (a : Fin n → ℝ), (∀ i,0 < a i) →
  MemLp (fun z : {NS}E n => Real.exp (-(∑ i,a i*(z i)^2))) 2 volume := by
  sorry''',context=['真正任意有限维加权Gaussian，未改为径向单一系数或有界域。'],missing='待Mathlib Gaussian积分与Euclidean有限乘积坐标变换桥接；不新建Gaussian积分理论。')
add('FiniteJumpL2','5.2.1',183,[],r'''$L^2(\mathbb R^m)$ also includes the compactly supported functions with finite “jump discontinuities” at a finite number of locations.''',f'''theorem finiteJumpL2 : ∀ n (g : {NS}E n → ℝ) (S : Set ({NS}E n)),
  S.Finite → HasCompactSupport g → ContinuousOn g Sᶜ →
  (∀ z ∈ S,∃ C > 0,∃ U ∈ 𝓝 z,∀ x ∈ U,|g x| ≤ C) →
    MemLp g 2 volume := by
  sorry''',extra=['[EXTRA]有限跳跃采用有限异常集外连续且异常点附近有限界的严格资格；仅sup点值不控制跳跃邻域，不假设全局MemLp结论。'],missing='待局部有限界到紧支持全局界、AE可测和MemLp短桥；不建设新函数空间理论。')
add('NormalizedAverageFormula','5.2.1',184,[20],r'''$\operatorname{Av}_\rho(g)\stackrel{\rm def}{=}\frac{1}{\int_D\rho(z)\,d\omega}\langle g,\rho\rangle=\int_Dg\widehat\rho\,d\omega$.''',f'''theorem normalizedAverageFormula : ∀ n (D : Set ({NS}E n)) (ρ g : {NS}E n → ℝ),
  densityAverageOn D ρ g=(∫ z in D,g z*(ρ z/(∫ x in D,ρ x))) := by
  sorry''',context=['积分比值的实际线性恒等式；概率解释另须正分母及原密度条件，不将代数式误当所有输入都有概率意义。'])
