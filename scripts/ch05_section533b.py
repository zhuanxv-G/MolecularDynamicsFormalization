"""Retain the ambient Lebesgue nullity sentence beside microcanonical nullity."""
from ch05_data import add,NS
add('AmbientLowerDimensionNull','5.3.3',195,[],r'''We also note that lower order objects such as a point or a curve in $\mathbb R^2$, or a surface in $\mathbb R^3$, have zero measure with respect to Lebesgue measure for the ambient space.''',f'''theorem ambientLowerDimensionNull : ∀ n d (g : {NS}E d → {NS}E n) (K : Set ({NS}E d)),
  d < n → ContDiff ℝ 1 g → IsCompact K → volume (g '' K)=0 := by
  sorry''',extra=['[EXTRA]以低维C¹参数化的紧像实现原“lower order objects”，保留实际ambient Lebesgue volume结论，不与ΣE上的奇异微正则测度混同；非任意拓扑低维集合。'],missing='缺当前低维C¹像Lebesgue零测与规范Hausdorff测度的现成桥接；需要局部Lipschitz覆盖/维数几何測度接口，不建设新大型几何理论。')
