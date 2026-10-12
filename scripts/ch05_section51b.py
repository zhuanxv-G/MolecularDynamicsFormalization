"""Two remaining original coordinate/operator statements, PDF202."""
from ch05_data import add,copied,D,NS
add('SolutionOperator','5.1',181,[7],r'''$\widetilde g(z,t)=G_t\widetilde g(z,0),\qquad\hbox{where }G_t=e^{t\mathcal L_f}$.''',copied(D,'solutionOperator'),kind='definition',context=['真实pullback解算子；exp是原书给定的算子记号，不声称未建设的无界指数级数收敛。'])
add('CoordinateLie','5.1',181,[8],r'''In this notation, the symbol $\partial_i$ refers to the $i$th coordinate function of $z$ ($\partial_i(z)=z_i$). Calculating directly we have $\mathcal L_fz_i=f_i$.''',f'''theorem coordinateLie : ∀ n (f : {NS}E n → {NS}E n) (z : {NS}E n) (i : Fin n),
  {NS}lie f (fun x => x i) z=f z i := by
  sorry''',context=['保留实际EuclideanSpace的第i坐标投影；∂i是原书的坐标函数，不是对其它函数的偏导。'])
add('LiePullbackCommutes','5.1',181,[],r'''$(\mathcal L_f\widetilde g)(z)=f(z)\cdot\nabla_z[g(\mathcal F_t(z))]
=f(z)\cdot\mathcal F_t'(z)^T\nabla g(\mathcal F_t(z))
=\mathcal F_t'(z)f(z)\cdot\nabla g(\mathcal F_t(z))
=f(\mathcal F_t(z))\cdot\nabla g(\mathcal F_t(z))
=(\mathcal L_fg)(\mathcal F_t(z))$.''',f'''theorem liePullbackCommutes : ∀ n (f : {NS}E n → {NS}E n) Φ (g : {NS}E n → ℝ),
  {NS}flow f Φ → ContDiff ℝ 2 (Function.uncurry Φ) → ContDiff ℝ 1 g → ∀ t z,
    {NS}lie f ({NS}pullback Φ g t) z={NS}lie f g (Φ t z) := by
  sorry''',extra=['[EXTRA]实际C²流与C¹可观测量；完整Lie交换结论单列，不只保留中间DFt·f输运式。'],missing='所需FlowFieldTransport短桥已失败3条路线并停止；本条保留sorry，不以含sorryAx的引理伪造已证。')
