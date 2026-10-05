# 下一目标：actual Hilbert core 与 closed-domain coercivity
Gibbs weighted Poincare和actualµ mean0 core coercivity已完整。下一BrownianClosedCoercivity.lean，先实际连续g一般Varµ≤C energy与Dirichlet，给κVarµ≤-∫gLg，无mean0前提；actualtoLp norm²/innerone=mean和variance_eq_sub给κ(‖x‖²-⟪x,1⟫²)≤-⟪x,T x⟫。
用已有full smooth domain embedding/unique lift等式把core Hilbert范数、meanone与generator联系；constantone真实norm1/closedkillsconstant已接受。真正graphclosure equalsclosed graph与isClosed_le continuous norms/inner/pow把该全部pointwise inequality延到closed-domain，无自伴假设。
在closed-domain x⊥1获得κ‖x‖²≤-⟪x,Tclosed x⟫；derivezero kernel只有constant span，real nonzero eigenvalue用formal symmetry对one→actualorthogonality再κ bound。区分这些条件下真实closed eigen bounds与full spectral gap/selfadjoint/compactresolvent，后者仍独立未完成。
固定BrownianClosedOperator_mem_graphClosure为private，只可复用public graph theorem+LinearPMap.mem_graph实际构造closuremembership；不得import访问private名称。
局部全部完整后再统一full，保留原一般mass/U/β与所有历史资料。
