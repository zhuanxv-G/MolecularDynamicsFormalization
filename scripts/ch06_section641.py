"""Finite-chain vocabulary retains row direction, positive return times and true communication."""
from ch06_data import add,copied,D
add('StochasticMatrix','6.4.1',245,[78],r'''A discrete Markov Chain is a stochastic process in which, at each step, a transition is made from the current state $i$ to another $j$ selected from a given probability distribution. In the case of a finite collection of states $\Sigma=\{1,2,\ldots,k\}$, we assume that the transition probabilities $\pi_{ij}\in[0,1]$ are given and denote the state at time $n$ by $S_n$. Thus we have
\[\Pr(S_{n+1}=j\mid S_n=i)=\pi_{ij}.\]
The sum of the elements in row $i$ gives the probability of being in some state at time $n+1$ given that we were in state $i$ at time $n$, thus it is one.''',copied(D,'stochasticMatrix'),kind='definition',context=['真实右随机矩阵：所有元素非负和每行和1；≤1由这两条件推出，另条显式保存。'])
add('FiniteDistribution','6.4.1',245,[78],r'''A distribution on the state space is typically associated to a row vector $\psi=(\psi_1,\psi_2,\ldots,\psi_k)$ with nonzero elements and which is normalized such that
\[\sum_{i=1}^k\psi_i=1.\]''',copied(D,'finiteDistribution'),kind='definition',extra=['[EXTRA]概率权重取非负，允许零概率状态；原nonzero作为“typically”的描述而非概率的必要条件，不添加严格正初值要求。'],issues=['印刷nonzero应区分典型正权重与一般非负概率；原句完整保留，未声明字面nonzero定义网站PASS。'])
add('FiniteEvolution','6.4.1',245,[79],r'''The probability of being in state $i$ at the $n+1$st iteration, is the sum over $j$ of the probabilities of being in state $j$ multiplied by the probability of transitioning from state $j$ to state $i$, thus
\[\psi_{n+1}=\psi_n\Pi.\]''',copied(D,'finiteEvolution'),kind='definition',context=['实际右乘Πⁿ的初值演化；n+1递推另条证明，i→j行约定不颠倒。'])
add('FiniteEvolutionRecurrence','6.4.1',245,[79],r'''\[\psi_{n+1}=\psi_n\Pi.\]''',
'''theorem finiteEvolutionRecurrence : ∀ {k : ℕ} (matrix : Matrix (Fin k) (Fin k) ℝ)
    (initial : Fin k → ℝ) (n : ℕ),
  MolecularDynamics.Chapter06Review.finiteEvolution matrix initial (n+1)=
    Matrix.vecMul (MolecularDynamics.Chapter06Review.finiteEvolution matrix initial n) matrix := by
  sorry''',missing='待pow_succ及真实行向量乘法结合短桥。')
add('ReturnTimes','6.4.1',245,[80],r'''For each state of the chain, we define the number $d(i)$ to be the greatest common divisor of all integers $l$ such that $\pi_{ii}^{(l)}>0$ (if the probability of return to state $i$ is zero, then we set $d(i)=0$).''',copied(D,'returnTimes'),kind='definition',extra=['[EXTRA]真实Πˡ正返回时间l>0，排除0步恒等阵；原gcd周期定义必须如此解读。'])
add('Period','6.4.1',245,[80],r'''For each state of the chain, we define the number $d(i)$ to be the greatest common divisor of all integers $l$ such that $\pi_{ii}^{(l)}>0$ (if the probability of return to state $i$ is zero, then we set $d(i)=0$).''',copied(D,'period'),kind='definition',context=['取全部正返回时间公因子集合在ℕ的sSup；无返回时间时该集合无界，Nat的sSup值0；不把某一个返回时间误作周期。'])
add('Aperiodic','6.4.1',245,[80],r'''If $d(i)=1$, for all $i$ then we say that the chain is aperiodic.''',copied(D,'aperiodic'),kind='definition')
add('Irreducible','6.4.1','245–246',[81],r'''States $i$ and $j$ are said to communicate if $\pi_{ij}^{(l_1)}>0$ and $\pi_{ji}^{(l_2)}>0$ for some integers $l_1$ and $l_2$. This means that it is possible to reach $j$ from $i$ with positive probability and vice-versa.
A finite state space model is irreducible if every state is reachable from every other state in a finite “time”, where time in this context refers to the number of iterations of the chain. Equivalently, we say the model is irreducible if all states communicate.''',copied(D,'irreducible'),kind='definition',context=['∀i,j保证双向可达；允许i=j的0步，不将无向连接当作有向强连通。'])
