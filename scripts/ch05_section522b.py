"""Boundary terms, full adjoint qualification and the real measure propagator."""
from ch05_data import add,copied,proposition,D,NS
add('RectangularDomain','5.2.2',184,[],r'''Let $A$ be a suitable region of volume $V$ within the phase space (say a rectangular $m$-dimensional box).''',f'''def rectangularDomain {{n : ℕ}} (a b : {NS}E n) := {NS}rectangle a b''',kind='definition',extra=['[EXTRA]明确书中矩形例子；不把一般区域的边界通量声明缩成仅矩形。'])
add('FaceFlux','5.2.2',184,[],r'''$\frac{d\vartheta}{dt}=-\int_{\partial A}f\cdot n\,\rho(z;t)\,d\sigma$.''',copied('MolecularDynamics/Chapter05/Statements.lean','faceFlux'),kind='definition',extra=['[EXTRA]矩形单个面上ρfi的真实Hausdorff面积积分；正负法向由上下两个面的组合体现。'])
add('BoxFluxBalance','5.2.2',184,[23],r'''Using the divergence theorem, we may rewrite the latter quantity as a volume integral:
\[\frac{d\vartheta}{dt}=-\int_A\nabla\cdot(f(z)\rho(z;t))\,d\omega.\]''',proposition('fluxBalance_statement'),extra=['[EXTRA]原书矩形例子的全部面公式，和一般光滑域通量条目并存；实际被流输运的光滑密度。'],missing='缺矩形Hausdorff分面散度定理与密度输运桥接；不建设大型几何理论。')
add('BoundaryTerm','5.2.2',185,[],r'''where the term $B=\sum_i\int_{\partial A_\ell}uf_iv\nu_i\,d\sigma$, is a surface integral over the boundary of $A_\ell$, where $\nu_i$ is the $i$th component of the unit outward normal to the surface $\partial A_\ell$ bounding the region $A_\ell$.''',f'''def boxBoundaryTerm {{n : ℕ}} (f : {NS}E n → {NS}E n) (u v : {NS}E n → ℝ) (ell : ℝ) : ℝ :=
  let a : {NS}E n := WithLp.toLp 2 (fun _ => -ell)
  let b : {NS}E n := WithLp.toLp 2 (fun _ => ell)
  ∑ i,({NS}faceFlux f (fun z => u z*v z) a b i ell-
    {NS}faceFlux f (fun z => u z*v z) a b i (-ell))''',kind='definition',context=['各面实际面积积分及上下法向符号；不以虚构的未定边界项符号替代。'])
add('TruncatedIntegrationByParts','5.2.2',185,[],r'''We truncate the domain to a large box $A_\ell$ with edge of length $2\ell$ centered at the origin, approximating the inner product by:
\[\langle u,\mathcal L_fv\rangle\approx\int_{A_\ell}u\mathcal L_fv\,d\omega=\int_{A_\ell}u\sum_i f_i\frac{\partial v}{\partial z_i}\,d\omega.\]
Splitting this sum up, we treat each term by integration by parts
\[\int_{A_\ell}u\sum_i f_i\frac{\partial v}{\partial z_i}\,d\omega=\sum_i\int_{A_\ell}uf_i\frac{\partial v}{\partial z_i}\,d\omega\tag{5.4}\]
\[=B-\sum_i\int_{A_\ell}v\frac{\partial}{\partial z_i}(uf_i)\,d\omega.\tag{5.5}\]''',f'''theorem truncatedIntegrationByParts : ∀ n (f : {NS}E n → {NS}E n) (u v : {NS}E n → ℝ) ell,
  0 < n → 0 < ell → ContDiff ℝ 1 f → ContDiff ℝ 1 u → ContDiff ℝ 1 v →
  let A := {NS}rectangle (WithLp.toLp 2 (fun _ => -ell)) (WithLp.toLp 2 (fun _ => ell))
  (∫ z in A,u z*{NS}lie f v z)=boxBoundaryTerm f u v ell+
    (∫ z in A,{NS}liouvillian f u z*v z) := by
  sorry''',extra=['[EXTRA]正边长、C¹数据及真实矩形面；等号(5.4)的有限求和分配已经内含于实际Lie导数，非正式∞近似未当精确等号。'],missing='缺矩形散度/分面分部积分桥接；不建设新曲面积分理论。')
add('RapidAdjoint','5.2.2','185–186',[27],r'''Let $u,v$ be two scalar valued functions in $\mathbb R^m$ which tend to zero sufficiently rapidly at infinity. By our assumptions that $u$ and $v$ are rapidly decaying we know that $B\to0$, as $\ell\to\infty$. Taking the limit, we are thus left with the equation
\[\langle u,\mathcal L_fv\rangle=-\sum_i\int_{\mathbb R^m}v\frac{\partial}{\partial z_i}(uf_i)\,d\omega=\langle M_fu,v\rangle.\]
We refer to $M_f$ as the adjoint operator of $\mathcal L_f$ and we write $M_f=\mathcal L_f^*$.''',f'''theorem rapidAdjoint : ∀ n (f : {NS}E n → {NS}E n) (u v : {NS}schwartzSpace n),
  0 < n → ContDiff ℝ 1 f →
  Integrable (fun z => u z*{NS}lie f v z) volume →
  Integrable (fun z => {NS}liouvillian f u z*v z) volume →
  Tendsto (boxBoundaryTerm f u v) atTop (𝓝 0) →
  (∫ z,u z*{NS}lie f v z)=(∫ z,{NS}liouvillian f u z*v z) := by
  sorry''',extra=['[EXTRA]快速衰减函数用真实SchwartzMap资格；明确混合乘积可积及原证明所用实际B→0条件（任意增长的f下不能仅凭u/v衰减推出）；不是把最终伴随等式作前提。'],missing='缺矩形分部积分、扩域积分极限与真实边界项消失桥接；不建设大型曲面/输运理论。')
add('CompactAdjoint','5.2.2','185–186',[27],r'''$\langle u,\mathcal L_fv\rangle=\langle M_fu,v\rangle$.''',proposition('liouvillianAdjoint_statement'),extra=['[EXTRA]紧支持C¹版本，作为快速衰减完整条目的特殊情形另列；是微分表达式的积分配对，不是闭Hilbert算子伴随的域识别。'],missing='缺Euclidean分部积分/散度桥接；不建设新多维边界理论。')
add('MeasurePropagator','5.2.2',186,[28],r'''The density $\rho$ evolves as the solution of the partial differential equation $\partial\rho/\partial t=\mathcal L_f^*\rho$, where we interpret $\rho$ as a function of both $z$ and $t$ and view $\mathcal L_f^*$ as only operating on the spatial components. This means, formally, $\rho(z;t)=e^{t\mathcal L_f^*}\rho(z;0)$. We can think of $\exp(t\mathcal L_f^*)$ as defining the propagator of measure.''',copied(D,'measurePropagator'),kind='definition',context=['实际Measure.map输运；形式exp仅记号，不宣称已构造无界闭算子指数或一般密度PDE解。'])
