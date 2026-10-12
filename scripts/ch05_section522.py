"""Eight actual density/flux/continuity objects, PDF205–206."""
from ch05_data import add,copied,proposition,D,NS
add('MassFraction','5.2.2',184,[21],r'''Let $\rho(z;t)$ be the probability density associated to a collection of phase points moving under a vector field $f$ on the phase space $\mathbb R^m$. Let $A$ be a suitable region of volume $V$ within the phase space (say a rectangular $m$-dimensional box). The fraction $\vartheta$ of phase points present in $A$ at time $t$ is the integral of $\rho$ over $A$:
\[\vartheta(t)=\int_A\rho(z;t)\,d\omega.\]''',copied(D,'massFraction'),kind='definition',context=['实际随时间变化的区域积分；不把轨道时间平均混作密度集合的质量。'])
add('MassDerivative','5.2.2',184,[22],r'''which may be viewed as a smooth function of time. On the one hand
\[\frac{d\vartheta}{dt}=\int_A\frac{\partial\rho(z;t)}{\partial t}\,d\omega.\]''',proposition('massDerivative_statement'),extra=['[EXTRA]明确参数微分与积分交换所需的可积支配界、邻域逐点可微及可积性；不假设已交换的导数等式。'],missing='待Mathlib参数积分微分接口桥接；不建设一般输运解存在理论。')
add('OutwardNormal','5.2.2',184,[],r'''where $n(z)$ is the unit outward normal to the surface $\partial A$ at the point $z$ and $d\sigma$ is the surface element.''',f'''def outwardNormalFor {{n : ℕ}} (A : Set ({NS}E n)) (ν : {NS}E n → {NS}E n) : Prop :=
  ∀ z ∈ frontier A,∃ O : Set ({NS}E n),∃ r : {NS}E n → ℝ,
    IsOpen O ∧ z ∈ O ∧ ContDiffOn ℝ 2 r O ∧
    (∀ x ∈ O,x ∈ A ↔ r x < 0) ∧ {NS}grad r z ≠ 0 ∧
    ν z=‖{NS}grad r z‖⁻¹ • {NS}grad r z''',kind='definition',extra=['[EXTRA]通过局部真实光滑定义函数r的负侧表示域，并由实际梯度定义正向单位法线。这里采用C²光滑边界资格；矩形的角点另条以分面公式保存，不假设边界通量恒等式。'])
add('GeneralFluxBalance','5.2.2',184,[23],r'''this same rate of change may be written as the negative of the particle flux over the boundary of $A$:
\[\frac{d\vartheta}{dt}=-\int_{\partial A}f\cdot n\,\rho(z;t)\,d\sigma.\]
Using the divergence theorem, we may rewrite the latter quantity as a volume integral:
\[\frac{d\vartheta}{dt}=-\int_A\nabla\cdot(f(z)\rho(z;t))\,d\omega.\]''',f'''theorem generalFluxBalance : ∀ n (D A : Set ({NS}E n)) (ν f : {NS}E n → {NS}E n)
  (Φ : ℝ → {NS}E n → {NS}E n) (ρ : ℝ → {NS}E n → ℝ),
  0 < n → IsOpen D → IsOpen A → closure A ⊆ D → Bornology.IsBounded A → outwardNormalFor A ν →
  ContDiffOn ℝ 1 f D → {NS}flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → (∀ t,Φ t '' D=D) →
  ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) → (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)={NS}measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t,HasDerivAt ({NS}massFraction ρ A)
    (-(∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂({NS}hausdorffArea (n-1)))) t ∧
    (∫ z in A,{NS}divergence (fun x => ρ t x • f x) z)=
      ∫ z in frontier A,(inner ℝ (f z) (ν z))*ρ t z ∂({NS}hausdorffArea (n-1)) := by
  sorry''',extra=['[EXTRA]保留一般开放流不变相空间D，A闭包在D内，实际受限密度Measure.map条件及光滑有界域/真实法线资格；不要求ρ在D外光滑或归一化。两个原通量与散度结论都保存。矩形分面版本另列，未用单一区域计算替代此条。'],missing='缺真实Hausdorff曲面通量的散度定理与一般光滑输运密度桥接；不建设大型几何/PDE理论。')
add('Divergence','5.2.2',185,[24],r'''$M_fw=-\nabla\cdot(wf)$.''',copied(D,'divergence'),kind='definition',extra=['[EXTRA]实际Fréchet导数的线性迹，等价坐标偏导和需要标准有限维接口；不以任意矩阵命名Jacobian。'])
add('Liouvillian','5.2.2',185,[24],r'''The operator $M_f$, defined for a scalar valued function $w$ by $M_fw=-\nabla\cdot(wf)$, is called the Liouvillian operator.''',copied(D,'liouvillian'),kind='definition',context=['真实乘积向量场的导数迹，不把形式符号当闭算子已构造。'])
add('LiouvilleEquation','5.2.2',185,[25],r'''Therefore, since this should hold for an arbitrary domain $A$, we must have
\[\frac{\partial\rho}{\partial t}=-\nabla\cdot(\rho f).\]
This is called the Liouville equation or continuity equation. It tells us how the distribution of phase points varies in time and space.''',f'''theorem liouvilleEquation : ∀ n (D : Set ({NS}E n)) (f : {NS}E n → {NS}E n) Φ (ρ : ℝ → {NS}E n → ℝ),
  IsOpen D → ContDiffOn ℝ 1 f D → {NS}flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) →
  (∀ t,Φ t '' D=D) → ContDiffOn ℝ 1 (Function.uncurry ρ) (Set.univ ×ˢ D) →
  (∀ t,probabilityDensityOn D (ρ t)) →
  (∀ t,densityMeasureOn D (ρ t)={NS}measurePropagator Φ t (densityMeasureOn D (ρ 0))) →
  ∀ t z,z ∈ D → HasDerivAt (fun s => ρ s z) ({NS}liouvillian f (ρ t) z) t := by
  sorry''',extra=['[EXTRA]一般开放流不变D内的真实光滑密度及实际输运条件；不假设连续性方程，不要求域外ρ光滑，不构造一般PDE解存在或唯一性。'],missing='缺一般密度输运到逐点连续性方程的曲面/测度变换桥接；不建设大型输运理论。')
add('LiouvilleProduct','5.2.2',185,[26],r'''An alternative form for the continuity equation is:
\[\frac{\partial\rho}{\partial t}=-\sum_i\left(\rho\frac{\partial f_i}{\partial z_i}+f_i\frac{\partial\rho}{\partial z_i}\right).\]''',proposition('liouvilleProduct_statement'),extra=['[EXTRA]明确ρ和f在z的真实可微性；原全部坐标乘积展开由线性迹与Df/ρ链式规则表达。'],missing='待Fréchet乘积导数与实际Euclidean坐标线性迹展开短桥。')
