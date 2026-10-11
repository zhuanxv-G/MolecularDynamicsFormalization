"""Eight cotangent-projection records, visually checked PDF181–182."""
from ch04_data import add,copied,D,NS
P='MolecularDynamics/Chapter04/'
add('ProjectedEulerPrinted','4.3.4',159,[56],r'''On the other hand it is not too difficult to correct this defect by incorporating an additional projection onto the cotangent space:
\[q_{n+1}=q_n+hM^{-1}\bar p_{n+1},\tag{4.20}\]
\[\bar p_{n+1}=p_n-hF_n-hg'(q_n)^T\lambda_n,\tag{4.21}\]
\[0=g(q_{n+1}),\tag{4.22}\]
\[p_{n+1}=\bar p_{n+1}-g'(q_{n+1})^T\mu_{n+1},\tag{4.23}\]
\[0=g'(q_{n+1})M^{-1}p_{n+1}.\tag{4.24}\]''',copied(D,'projectedEulerRelation','projectedEulerPrinted').replace('h • F z.1','h • (-F z.1)'),kind='definition',verdict='NEEDS_HUMAN',explanation='原(4.21)写−hF_n，与此前F=−∇U及p163的+hF不一致；逐字保留，质量一致及正确力符号版另列。',issues=[dict(code='ERRATUM?',detail='p159(4.21)力符号与p163及F=−∇U定义不一致。')])
add('ProjectedEulerRelation','4.3.4',159,[],r'''The demonstration that the method is symplectic can be seen as a consequence of the following lemma.''',copied(D,'projectedEulerRelation'),kind='definition',extra=['[EXTRA]实际力F=−∇U采用+hF版本，与p163一致；不是(4.21)逐字公式。'])
add('Lemma41','4.3.4','159–160',[57],r'''Lemma 4.1 Let $\gamma:\mathbb R^{N_c}\to\mathbb R$ be $C^2$. Let $q,p\in\mathbb R^{N_c}$ be constrained to the manifold defined by
\[\gamma(q)=0,\quad p\cdot\nabla\gamma(q)=0,\]
and suppose $P,\mu$ satisfy $P=p-\mu\nabla\gamma(q)$. Then
\[\sum_{j=1}^{N_c}dq_j\wedge dP_j=\sum_{j=1}^{N_c}dq_j\wedge dp_j.\]''',copied(P+'ConstrainedProjection.lean','lemma_4_1','lemma41'),label='Lemma 4.1',kind='lemma',proof=r'''Clearly the result follows provided
\[\sum_{j=1}^{N_c}dq_j\wedge d[\mu\nabla\gamma(q)]_j=0,\]
where $[\ldots]_j$ indicates the jth component of the term in brackets. We have
\[\sum_jdq_j\wedge d[\mu\nabla\gamma(q)]_j=\sum_jdq_j\wedge\left(\frac{\partial\gamma}{\partial q_j}d\mu+\mu\sum_i\gamma''_{ij}dq_j\right).\]
Then we note
\[\sum_jdq_j\wedge\frac{\partial\gamma}{\partial q_j}d\mu=\sum_jdq_j\frac{\partial\gamma}{\partial q_j}\wedge d\mu=0,\]
since $\gamma(q)\equiv0$ implies $d\gamma(q)=\sum_j\frac{\partial\gamma}{\partial q_j}dq_j\equiv0$. Moreover
\[\sum_jdq_j\wedge\sum_i\gamma''_{ij}dq_j=0,\]
since the Hessian matrix $\gamma''$ is symmetric.''',issues=[dict(code='ERRATUM?',detail='p160证明两处内和印刷dq_j；实际Hessian链式公式应dq_i。原proof_latex保持字面，正式库用真实Hessian对称性证明结论。')],extra=['真实局部参数图、q/p/μ可微，约束在x邻域成立；完整拉回2形式对任意u,v相等。'],prior=['MolecularDynamics.lemma_4_1'],correspondence=[dict(source='γ(q)=0、p·∇γ(q)=0、P=p−μ∇γ(q)及完整两形式相等',lean='lemma41中的邻域位置/隐藏约束、实际参数图与任意u,v的拉回等式',note='标量完整原陈述，保留p的隐藏约束；不把拉回等式作假设。')])
add('MultiMomentumPullback','4.3.4',160,[58],r'''Observe that $g'(q_{n+1})^T\mu_{n+1}=\sum_{k=1}^l\mu_{n+1,k}\nabla g_k(q_{n+1})$. Thus we may apply Lemma 4.1 with $\gamma$ replaced by each $g_k$ to demonstrate
\[\sum_jdq_{n+1,j}\wedge dp_{n+1,j}=\sum_jdq_{n+1,j}\wedge d\bar p_{n+1,j}.\]''',copied(P+'ConstrainedProjection.lean','textbookMultiConstrainedMomentum_preserves_pullback','multiMomentumPullback'),extra=['有限约束族、真实C²约束与可微乘子/参数图；只给定光滑分支，不声称构造解存在。'],prior=['MolecularDynamics.textbookMultiConstrainedMomentum_preserves_pullback'])
add('ProjectedEulerPullback','4.3.4',160,[59],r'''Using similar argumentation based on the properties of the wedge product, we next show
\[\sum_jdq_{n+1,j}\wedge d\bar p_{n+1,j}=\sum_jdq_{n,j}\wedge d\bar p_{n+1,j};\]
and, finally, invoking Lemma 4.1 again,
\[\sum_jdq_{n,j}\wedge d\bar p_{n+1,j}=\sum_jdq_{n,j}\wedge dp_{n,j}.\]''',copied(P+'ConstrainedIntegrator.lean','textbookProjectedEulerChart_preserves_pullback','projectedEulerPullback'),extra=['真实势力、C²势与约束、可微乘子/参数图，前后位置约束；力kick系数a任意实数覆盖符号两版；不是求解分支存在证明。'],prior=['MolecularDynamics.textbookProjectedEulerChart_preserves_pullback'])
add('CotangentMultiplier','4.3.4',159,[60],r'''$0=g'(q_{n+1})M^{-1}p_{n+1}$.''',copied(P+'CotangentProjection.lean','textbookCotangentMultiplier','cotangentMultiplier'),kind='definition',extra=['[EXTRA]将(4.23–24)在Gram非奇异资格下解出实际μ=(GM⁻¹Gᵀ)⁻¹GM⁻¹p；正文未另印此显式式。'])
add('CotangentProjection','4.3.4',159,[60],r'''$p_{n+1}=\bar p_{n+1}-g'(q_{n+1})^T\mu_{n+1}$.''',copied(P+'CotangentProjection.lean','textbookCotangentProjection','cotangentProjection'),kind='definition',extra=['[EXTRA]采用实际Gram逆乘子；非奇异Gram是方法资格，另条证明隐藏约束。'])
add('CotangentHidden','4.3.4',159,[61],r'''$0=g'(q_{n+1})M^{-1}p_{n+1}$.''',copied(P+'ConstrainedGram.lean','textbookCotangentProjection_hiddenConstraint_of_mass_and_independence','cotangentHidden'),extra=['[EXTRA]对实际逆Gram构造证明结论，正质量与约束梯度线性独立；不把隐藏约束作假设。'],prior=['MolecularDynamics.textbookCotangentProjection_hiddenConstraint_of_mass_and_independence'])
