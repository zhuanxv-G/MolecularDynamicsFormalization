# 下一批：actual densely defined Brownian LinearPMap 及可闭图闭包

目标 BrownianClosedOperator.lean。只用同一actual Gibbs L²和已证明full smooth periodic domain dense；U C∞ periodic，mass arbitrary diagonal；β≠0用于formal symmetry/closability。实际closure仍不声称selfadjoint、compact resolvent或谱结论。

固定源码路线：
- Mathlib.LinearAlgebra.LinearPMap：真实结构domain : Submodule和toFun : domain→ₗactualL²，mk_apply rfl。将前批actual domain/operator直接打包，不引入operator值或domain存在假设。
- Mathlib.Analysis.InnerProductSpace.LinearPMap：LinearPMap.IsFormalAdjoint是全pair真实inner equality；前批domain_symmetric给T.IsFormalAdjoint T。已provedDense结合IsFormalAdjoint.le_adjoint给T≤T.adjoint。adjoint_isClosed实际requiresDense，不能用junk nondense adjoint作证明。
- 同一dense及T≤T.adjoint推actual adjoint domain dense；实际adjoint closed→isClosable.leIsClosable给T.IsClosable（不假设closed extension）。
- Mathlib.Topology.Algebra.Module.LinearPMap：IsClosable.graph_closure_eq_closure_graph，le_closure，IsClosable.closure_isClosed，closureHasCore，真实图closure构造。actualclosure.domain包含actualfull smooth domain，故dense；实际core原domain，original算子所有smoothlift值保留。
- 先将这些局部证明并一次统一验收；闭包symmetry/actualselfadjoint需额外证明。后续Poincare/compact embedding与resolvent仍未完成。不得把adjoint closure构造或formal symmetry当selfadjoint。

以上固定源码已读；新LinearPMap/closure目标尚未实现或验证。当前BrownianSmoothDensity16public full-check01正在运行，正式Lean输入冻结。
