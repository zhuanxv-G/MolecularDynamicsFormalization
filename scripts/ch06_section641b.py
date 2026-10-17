"""Full finite-chain theorem and actual numerical nonirreducibility example."""
from ch06_data import add,copied,proposition,D
add('FiniteInvariant','6.4.1',246,[81],r'''An invariant distribution is a left eigenvector of $\Pi$, having only non-negative elements, and corresponding to the eigenvalue 1. That is, an invariant distribution $\psi^*$ satisfies
\[\psi^*=\psi^*\Pi.\]''',copied(D,'finiteInvariant'),kind='definition',context=['真实归一化非负左特征向量；不忽略归一化或改为右向量。'])
add('FiniteErgodicity','6.4.1',246,[82],r'''The fundamental result for Markov chains is the following: If a given Markov chain is both irreducible and aperiodic, then it can be shown that there is a unique invariant distribution $\psi^*$ such that
\[\lim_{n\to\infty}\psi_n=\psi^*,\]
for arbitrary initial distribution $\psi_0$. The convergence of an irreducible finite Markov chain to its stationary distribution can be understood through the properties of its eigenvalues by applying of the Perron-Frobenius theorem (see [269]).''',proposition('finiteErgodicity_statement','finiteErgodicity'),extra=['[EXTRA]非空真实有限状态、右随机矩阵、全部幂Πⁿ、真实全部初始概率；完整存在、唯一性及任意初值向量收敛，不假设谱隙或收敛结论。'],missing='缺现成有限非负随机矩阵Perron–Frobenius/primitive极限完整打包桥接；不建设大型理论。')
add('StochasticEntryBound','6.4.1',245,[78],r'''it is a matrix whose entries are all nonnegative and less than or equal to 1.''',
'''theorem stochasticEntryBound : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ),
  MolecularDynamics.Chapter06Review.stochasticMatrix matrix → ∀ i j, matrix i j ≤ 1 := by
  sorry''',missing='待真实非负行和1的有限和单项界短证明。')
add('FiniteChainExample','6.4.1',246,[],r'''Fig. 6.6 A Markov matrix (left) and its graph representation (right). In this example, the Markov Chain is not irreducible.
\[\Pi=\begin{bmatrix}0.2&0.1&0.7&0&0\\0&0&0&1&0\\0.3&0&0&0.3&0.4\\0&0.5&0&0.3&0.2\\0&0&0&1&0\end{bmatrix}.\]''',
'''def finiteChainExample : Matrix (Fin 5) (Fin 5) ℝ :=
  !![(1/5),(1/10),(7/10),0,0;
     0,0,0,1,0;
     (3/10),0,0,(3/10),(2/5);
     0,(1/2),0,(3/10),(1/5);
     0,0,0,1,0]''',kind='definition',label='Fig. 6.6',context=['原数值矩阵全项保留，decimal精确有理数；图示的非不可约数学结论另条，不列为纯定性排除。'])
add('ExampleStochastic','6.4.1',246,[],r'''Fig. 6.6 A Markov matrix (left) and its graph representation (right).''',
'''theorem exampleStochastic : MolecularDynamics.Chapter06Review.stochasticMatrix finiteChainExample := by
  sorry''',kind='extra_claim',extra=['[EXTRA]原具体数值矩阵的真实随机行资格检查。'],missing='待五行实际有限算术短证明。')
add('ExampleNotIrreducible','6.4.1',246,[],r'''In this example, the Markov Chain is not irreducible.''',
'''theorem exampleNotIrreducible : ¬ MolecularDynamics.Chapter06Review.irreducible finiteChainExample := by
  sorry''',label='Fig. 6.6',missing='待实际Πⁿ中状态2不能达到1的有限归纳短证明，不以不可达结论作假设。')
add('Communicates','6.4.1','245–246',[81],r'''States $i$ and $j$ are said to communicate if $\pi_{ij}^{(l_1)}>0$ and $\pi_{ji}^{(l_2)}>0$ for some integers $l_1$ and $l_2$. This means that it is possible to reach $j$ from $i$ with positive probability and vice-versa.''',
'''def communicates {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ) (i j : Fin k) : Prop :=
  (∃ n : ℕ, 0 < (matrix^n) i j) ∧ ∃ n : ℕ, 0 < (matrix^n) j i''',kind='definition',context=['两个可能不同的真实有限时间及两个方向。'])
add('DirectedGraphIrreducible','6.4.1',246,[81],r'''Then one may understand irreducibility as expressing the connectedness of this graph.
For a directed graph, we must have, for any pair of vertices $A$ and $B$, paths which take us from $A$ to $B$ and vice-versa.''',
'''theorem directedGraphIrreducible : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ),
  MolecularDynamics.Chapter06Review.stochasticMatrix matrix →
  (MolecularDynamics.Chapter06Review.irreducible matrix ↔
    ∀ i j, Relation.ReflTransGen (fun a b ↦ 0 < matrix a b) i j) := by
  sorry''',extra=['[EXTRA]真实正权边与有向路径可达关系；∀i,j强连通，不用无向连通偷换。'],missing='缺非负矩阵幂正项与有向路径的完整有限求和桥接；不建设一般PF理论。')
