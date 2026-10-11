"""Prepared claims for their exact printed subsection."""
from ch04_data import add,copied,proposition,D,NS
add('ComponentPrinted','4.3.3',158,[55],r'''In general, we perform a sequence of updates
\[\Delta\Lambda_j=[\nabla g_j(Q)^TM^{-1}G_j^1]^{-1}g_j(Q),\qquad Q:=Q-M^{-1}G_n^j\Delta\Lambda_j,\]
as $j$ cycles repeatedly from $1$ to $m$.''',
f'''def componentPrinted {{n l : ℕ}} (m : Fin n → ℝ) (g : Fin l → {NS}Q n → ℝ)
    (q Qnow : {NS}Q n) (Gsup1 : Fin l → {NS}Q n) (j : Fin l) : {NS}Q n :=
  Qnow-(g j Qnow / {NS}dot ({NS}grad (g j) Qnow) ({NS}invMass m (Gsup1 j))) •
    {NS}invMass m ({NS}grad (g j) q)''',kind='definition',verdict='NEEDS_HUMAN',explanation='字面分母G_j^1与已定义G_n^j不一致。引入待解释Gsup1保留它，更新方向仍为G_n^j；常规修正版另列。',extra=['[EXTRA]Gsup1是未定义印刷G_j^1的显式参数，未假设它等于已定义梯度。'],issues=[dict(code='ERRATUM?',detail='一般分量式分母G_j^1疑为G_n^j的索引误写；原文不静默改。')])
add('ComponentConstraintStep','4.3.3',158,[],r'''\[\Delta\Lambda_1=[\nabla g_1(Q)^TM^{-1}G_n^1]^{-1}g_1(Q).\]
We then update $Q$ by
\[Q:=Q-M^{-1}G_n^1\Delta\Lambda_1.\]''',copied(D,'componentConstraintStep'),kind='definition',extra=['[EXTRA]一般j采用已定义Gn^j=grad gj(qn)，取非零分母才是可用步骤；原一般式索引疑误由ComponentPrinted保留。'])
add('ComponentSweep','4.3.3',158,[],r'''and continue to update $\Lambda_2$ in the same manner (using the second constraint). In general, we perform a sequence of updates ... as $j$ cycles repeatedly from $1$ to $m$.''',copied(D,'componentSweep'),kind='definition',extra=['[EXTRA]一次完整顺序sweep，使用上一条统一Gn索引；多轮为其真实函数迭代。'],context=['检查全部分量或残差的停止建议为实现背景，不以定义证明收敛。'])
