"""Coordinate identities expose the original full sums, without invented Jacobians."""
from ch05_data import add,NS
add('LieCoordinates','5.2.2',185,[],r'''$\mathcal L_fv=\sum_i f_i\frac{\partial v}{\partial z_i}$.''',f'''theorem lieCoordinates : ∀ n (f : {NS}E n → {NS}E n) (g : {NS}E n → ℝ) z,
  {NS}lie f g z=∑ i,f z i*(fderiv ℝ g z) (EuclideanSpace.basisFun (Fin n) ℝ i) := by
  sorry''',extra=['[EXTRA]实际Euclidean规范基、Fréchet导数线性和坐标投影，明确原文全部有限求和；恒等式不要求另造形式梯度。'])
add('DivergenceCoordinates','5.2.2',185,[],r'''$\frac{\partial\rho}{\partial t}=-\sum_i\left(\rho\frac{\partial f_i}{\partial z_i}+f_i\frac{\partial\rho}{\partial z_i}\right)$.''',f'''theorem divergenceCoordinates : ∀ n (f : {NS}E n → {NS}E n) z,
  DifferentiableAt ℝ f z → {NS}divergence f z=
    ∑ i,(fderiv ℝ (fun x => f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i) := by
  sorry''',extra=['[EXTRA]实际可微向量场的导数迹等于所有坐标对角偏导之和；和LiouvilleProduct共同保留原完整展开，不将任意矩阵命名为Jacobian。'])
add('LiouvilleProductCoordinates','5.2.2',185,[26],r'''An alternative form for the continuity equation is:
\[\frac{\partial\rho}{\partial t}=-\sum_i\left(\rho\frac{\partial f_i}{\partial z_i}+f_i\frac{\partial\rho}{\partial z_i}\right).\]''',f'''theorem liouvilleProductCoordinates : ∀ n (f : {NS}E n → {NS}E n) (ρ : {NS}E n → ℝ) z,
  DifferentiableAt ℝ f z → DifferentiableAt ℝ ρ z →
  {NS}liouvillian f ρ z=-(∑ i : Fin n,(ρ z*(fderiv ℝ (fun x => f x i) z) (EuclideanSpace.basisFun (Fin n) ℝ i)+
    f z i*(fderiv ℝ ρ z) (EuclideanSpace.basisFun (Fin n) ℝ i))) := by
  sorry''',extra=['[EXTRA]实际点可微性；保存原整个有限求和右侧，连续性PDE左侧的时间导数由LiouvilleEquation完整条目保留。'],missing='待已验的LiouvilleProduct、Lie/散度坐标恒等式短桥；不能用含sorryAx的依赖冒称已证。')
